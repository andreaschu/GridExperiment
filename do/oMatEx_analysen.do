version 16
use "${data}oMatEx_merged.dta", clear 
drop fmineinko fsitzum1 fsitzum2 fsitzum3 fsitzum4 fsitzum5 d313a1 d313a2 ///
	d313a3 d313a4 d313a5 d313a6 d313a7 d313a8 d313a9 d313a10 d313a11 ///
	d313a12 feininsg1 feininsg2 feinelto1 feinelto2 feinjobo1 feinjobo2 ///
	feinbafo1 feinbafo2 feinkredo1 feinkredo2  feinandq1 feinandq2 sf_d3_6 ///
	d36 d36open sf_d3_6a breite_d36 hoehe_d36 mobile_d36

	
*******************************************************************
cd "${results}"
cap log close
log using oMatEx-Gesamt_results2_`: di %tdCY-N-D daily("$S_DATE", "DMY")', replace

***************************************************************************
** Projekt/ Studie: Experiment offene Matrix 
***************************************************************************
** Beschreibung Experiment:
** Erhebung der Verwendung von Stunden auf verschiedene Aktivitäten im aktuellen (bzw. letzten) Semester
**** zlvwo (zlvwo2): Lehrveranstaltungen
**** zseswo (zseswo2): Selbststudium
**** zerwo (zerwo2): Erwerbstätigkeit
**** zcarwo (zcarwo2): Pflege von Verwandten/Bekannten
**** zchiwo (zchiwo2): Kinderbetreuung
// "im letzten Semester" nur sichtbar, wenn HS-Semester (ssemhs)>1

**** dkinja: Haben Sie Kinder? (1) nein/ (2) ja
**** ssemhs: In welchem Hochschulsemester befinden Sie sich?

** verschiedene Ansichten der offenen Matrix:
**** view_a56: Seitendarstellung nach Funktionalität: 0=Matrix-Ansicht, 1= Carousel, 2=scroll down

** [1.] für Befragungsabbruch:
**** a56max: maximaler Seitenfortschritt, 0= mind. bis 79, 1= 79 (A_56/Matrix/Carousel), 80 (A_56c/scroll down, spaltenweise), 81 (A_56b/ Carousel spaltenweise) oder 82 (A_56a/scroll down, zeilenweise) 
**** a56last: Seitenabbruch auf A_56/A_56a/A_56b/A_56c, 0= mind. bis 79, 1= Abbruch auf Seite 79 (A_56), 80 (A_56c), 81 (A_56b) oder 82 (A_56a) 

** [2.] für Item-Nonresponse:
****  m2_zeitmiss: Anzahl Missing-Werte mit HS>1 (zwei Spalten), ohne Kinder (0-8) 
****  zeitmiss: Anzahl der Missing-Werte bei den Variablen zlvwo - zchiwo2 (0-10) (wenn HS-Semester> 1 und Kinder='ja')
****  zeit1miss: Anzahl der Missing-Werte bei den Variablen zlvwo - zchiwo (nur 'dieses Semester')
****  zeit2miss: Anzahl der Missing-Werte bei den Variablen zlvwo2 - zchiwo2 (nur 'letztes Semester')
****  a56miss: Missing-Vorkommen dichotom, 0= keine Missings, 1=mind. 1 Missing für dieses und letztes Semester (zlvwo-zchiwo, zlvwo2-zchiwo2)

** [3.] für Bearbeitungszeit/ Verweildauer
**** A56_dauer: Seitenverweildauer zusammengefasst von p79 bis p82


** ggf. Kontrollvariablen
**** vd1_20: Selbsteinschätzung digitaler Kompetenz
**** pbigintro, pbigextro, pbigtraum, pbigkrit, pbiggenau, pbigfaul, pbigruh, pbignerv, pbigkrea, pbignoku: Big Five
**** digflehr1 - digflehr6
**** pswskill, pswkraft, pswaufg: Selbstwirksamkeitserwartungen

tab survey

/// nur Auswertungen von "normaler" Aufsplittung
drop if conview==3 | conview==4
*_________________________________________________________
*_______________ Deskriptive Statistiken _________________
*_________________________________________________________

tab survey

tab split_zeit survey

tab mobile_a56 survey

tab view_a56 survey

tab view_a56 split_zeit if survey==2

table view_a56, contents(mean A56_dauer n A56_dauer) format(%9.2f)

*__________________________________________________
*_______________ Auswertungen _____________________
*__________________________________________________

*///////////////////////////////////////////////////////////////////
*____________[1.] Befragungsabbruch________ 
*///////////////////////////////////////////////////////////////////

tab a56max view_a56, col exp V nokey chi2
tab a56last view_a56, col exp V nokey chi2
 
*///////////////////////////////////////////////////////////////////
*____________[2.] Item-Nonresponse________ 
*///////////////////////////////////////////////////////////////////

*____________ Verteilung ob Missing-Vorkommen (keine Kinder, mind. 2. Sem.)
tab a56miss view_a56, exp V nokey chi2 col

*____________ Verteilung ob Missing-Vorkommen unterteilt nach Survey (keine Kinder, mind. 2. Sem.)
bysort survey: tab a56miss view_a56, exp V nokey chi2 col

/////////////
*____________ Verteilung von Item-Nonresponse (keine Kinder, mind. 2. Sem.)
tab m2_zeitmiss view_a56, exp V nokey chi2 col

*____________ Verteilung von Item-Nonresponse unterteilt nach Survey (keine Kinder, mind. 2. Sem.)
bysort survey: tab m2_zeitmiss view_a56 , exp V nokey chi2 col


*///////////////////////////////////////////////////////////////////
*____________[3.] Bearbeitungsdauer (ohne Missings)________ 
*///////////////////////////////////////////////////////////////////
preserve
//// Fälle entfernen mit Bearbeitungsdauer von mehr als 10 Minuten
drop if A56_dauer>600

table view_a56 if m2_zeitmiss==0 & A56_dauer!=. , contents(mean A56_dauer n A56_dauer max A56_dauer p25 A56_dauer p90 A56_dauer) format(%9.2f)

*____________ T-Test (nur mobile vs. non-mobile)
ttest A56_dauer if m2_zeitmiss==0 , by(mobile_a56)

*____________ Varianzanalyse 
anova A56_dauer view_a56 if m2_zeitmiss==0

table view_a56 if m2_zeitmiss==0, contents(mean A56_dauer p50 A56_dauer p25 A56_dauer p75 A56_dauer n A56_dauer) format(%9.2f)
/// nur Befragte ohne Item-Nonresponse um die Beobachtung konstant zu halten, da item-nonresponse abhängig von View/Gerät ist.

restore

*///////////////////////////////////////////////////////////////////
*____________[4.] Angaben________ 
*///////////////////////////////////////////////////////////////////

*---------------- Angaben zu diesem Semester (nur ohne Missings) ----------------
// Lehrveranstaltungen
ttest zlvwo if m2_zeitmiss==0, by(mobile_a56)
oneway zlvwo view_a56 if m2_zeitmiss==0, scheffe
table view_a56 if m2_zeitmiss==0, contents(mean zlvwo n zlvwo sd zlvwo) format(%9.2f)

// Selbststudium
ttest zseswo if m2_zeitmiss==0, by(mobile_a56)
oneway zseswo view_a56 if m2_zeitmiss==0, scheffe
table view_a56 if m2_zeitmiss==0, contents(mean zseswo n zseswo sd zseswo) format(%9.2f)

// Erwerbstätigkeit
ttest zerwo if m2_zeitmiss==0, by(mobile_a56)
oneway zerwo view_a56 if m2_zeitmiss==0, scheffe
table view_a56 if m2_zeitmiss==0, contents(mean zerwo n zerwo sd zerwo) format(%9.2f)

// Pflege von Verwandten / Bekannten
ttest zcarwo if m2_zeitmiss==0, by(mobile_a56)
oneway zcarwo view_a56 if m2_zeitmiss==0, scheffe
table view_a56 if m2_zeitmiss==0, contents(mean zcarwo n zcarwo sd zcarwo) format(%9.2f)

////////////////////////
// Summenindex der Angaben (dieses Semester)
ttest sum_zeit_sem1 if m2_zeitmiss==0, by(mobile_a56)
oneway sum_zeit_sem1 view_a56 if m2_zeitmiss==0, scheffe
table view_a56 if m2_zeitmiss==0, contents(mean sum_zeit_sem1 n sum_zeit_sem1 sd sum_zeit_sem1) format(%9.2f)

*---------------- Angaben zum letzten Semester (längere Zeit vergangen)----------------
// Lehrveranstaltungen
ttest zlvwo2 if m2_zeitmiss==0, by(mobile_a56)
oneway zlvwo2 view_a56 if m2_zeitmiss==0, scheffe
table view_a56 if m2_zeitmiss==0, contents(mean zlvwo2 n zlvwo2 sd zlvwo2) format(%9.2f)

// Selbststudium
ttest zseswo2 if m2_zeitmiss==0, by(mobile_a56)
oneway zseswo2 view_a56 if m2_zeitmiss==0, scheffe
table view_a56 if m2_zeitmiss==0, contents(mean zseswo2 n zseswo2 sd zseswo2) format(%9.2f)

// Erwerbstätigkeit
ttest zerwo2 if m2_zeitmiss==0, by(mobile_a56)
oneway zerwo2 view_a56 if m2_zeitmiss==0, scheffe
table view_a56 if m2_zeitmiss==0, contents(mean zerwo2 n zerwo2 sd zerwo2) format(%9.2f)

// Pflege von Verwandten / Bekannten
ttest zcarwo2 if m2_zeitmiss==0, by(mobile_a56)
oneway zcarwo2 view_a56 if m2_zeitmiss==0, scheffe
table view_a56 if m2_zeitmiss==0, contents(mean zcarwo2 n zcarwo2 sd zcarwo2) format(%9.2f)


////////////////////////
// Summenindex der Angaben (letztes Semester)
ttest sum_zeit_sem2 if m2_zeitmiss==0, by(mobile_a56)
oneway sum_zeit_sem2 view_a56 if m2_zeitmiss==0, scheffe
table view_a56 if m2_zeitmiss==0, contents(mean sum_zeit_sem2 n sum_zeit_sem2 sd sum_zeit_sem2) format(%9.2f)


log close



preserve
drop if dkinja != 1  | ssemhs <= 1 | ssemhs == .
drop if m2_zeitmiss==.
drop if view_a56==.

///contract view_a56 m2_zeitmiss, percent(_percent)
///separate _percent, by(view_a56) veryshortlabels


bysort view_a56 m2_zeitmiss: gen miss_a56=_N 
bysort view_a56: gen pct_view100=_N 

*1. Variante
bysort view_a56: gen viewA56_pct100=_N 
gen miss_a56pct=miss_a56/ viewA56_pct100*100

/*
*2. Variante
egen viewA56_pct100Count= count(view_a56)
egen miss_a56Count= rownonmiss(view_a56 m2_zeitmiss) 
gen miss_a56pctCount =miss_a56Count/ viewA56_pct100Count*100
*/
table view_a56 if m2_zeitmiss!=., contents(mean miss_a56pct n miss_a56pct) format(%9.2f) 

*///////////////////////////////////////////////////////////////////
*____________Balkendiagramm der Missings (mit Prozentwerten)________ 
*///////////////////////////////////////////////////////////////////



graph bar miss_a56pct, ///
	over(m2_zeitmiss, gap(0) label(labsize(vsmall) labgap(.5))) over(view_a56, gap(160) label(labsize(small) labgap(.5))) ///
	asyvars legend(off) ///
	title("Distribution of Missing Values by Way of Presentation") ///
	graphregion(color(white)) showyvars ///
	ytitle("share of respondents (in percent)") ///
	yscale(titlegap(3)) ///
	ylabel( , labsize(vsmall)) ///
	bar(1, color("122 181 29")) ///	
	bar(2, color("8 94 111")) ///
	bar(3, color("10 125 148")) ///
	bar(4, color("12 144 171")) ///
	bar(5, color("103 142 171")) ///
	bar(6, color("154 164 171")) ///
	bar(7, color("72 100 120")) ///	
	bar(8, color("95 95 95")) ///
	bar(9, color("69 69 69")) ///	
	note("Source: own calculation" "n=24,981")

	
/*
graph bar miss_a56pct, ///
	over(m2_zeitmiss, gap(0) label(labsize(vsmall) labgap(.5))) over(view_a56, gap(160) label(labsize(small) labgap(.5))) ///
	asyvars legend(off) ///
	title("distribution of missing values by way of presentation") ///
	graphregion(color(white)) showyvars ///
	ytitle("share of respondents (in percent)") ///
	legend(pos(2) col(1) size(small) keygap(1)) ///
	yscale(titlegap(3)) ///
	ylabel( , labsize(vsmall)) ///
	bar(1, color("122 181 29")) ///	
	bar(2, color("8 94 111")) ///
	bar(3, color("10 125 148")) ///
	bar(4, color("12 144 171")) ///
	bar(5, color("103 142 171")) ///
	bar(6, color("154 164 171")) ///
	bar(7, color("72 100 120")) ///	
	bar(8, color("95 95 95")) ///
	bar(9, color("69 69 69")) ///	
	note("Source: own calculation" "n=24,981")
*/	

/*	
	bar(3, color("10 125 148")) ///
	bar(4, color("10 125 148")) ///
	bar(5, color("10 125 148")) ///
	bar(6, color("250 202 25")) ///
	bar(7, color("246 159 36")) ///
	bar(8, color("95 95 95")) ///
	bar(9, color("69 69 69")) ///	
*/
	
/*
graph bar miss_a56pct, ///
	over(m2_zeitmiss, gap(0)) over(view_a56) ///
	asyvars  ///
	graphregion(color(white)) ///
	ytitle("number of respondents (percent)") ///
	legend(pos(2) col(1) size(small)) ///
	ylabel( , labsize(vsmall)) ///
	bar(1, color("11 131 156")) ///	
	bar(2, color("122 181 29")) ///
	bar(3, color("198 204 22")) ///
	bar(4, color("198 204 22")) ///
	bar(5, color("250 202 25")) ///
	bar(6, color("246 159 36")) ///
	bar(7, color("222 159 22")) ///
	bar(8, color("222 110 22")) ///
	bar(9, color("250 91 25")) ///
	note("Source: own calculation" "n=24,981")	
	
graph bar miss_a56pct, ///
	over(m2_zeitmiss, gap(0)) over(view_a56) ///
	asyvars  ///
	graphregion(color(white)) ///
	ytitle("number of respondents (percent)") ///
	legend(pos(2) col(1) size(small)) ///
	ylabel( , labsize(vsmall)) ///
	bar(1, color("246 159 36")) ///
	bar(2, color("15 185 219")) ///
	bar(3, color("14 164 194")) ///
	bar(4, color("11 131 156")) ///
	bar(5, color("122 181 29")) ///
	bar(6, color("95 95 95")) ///
	bar(7, color("107 107 107")) ///
	bar(8, color("171 171 171")) ///
	bar(9, color("95 95 95")) ///
	note("Source: own calculation" "n=24,981")

graph bar miss_a56pct, ///
	over(m2_zeitmiss, gap(0)) over(view_a56) ///
	asyvars  ///
	graphregion(color(white)) ///
	ytitle("number of respondents (percent)") ///
	legend(pos(2) col(1) size(small)) ///
	ylabel( , labsize(vsmall)) ///
	bar(1, color("122 181 29")) ///	
	bar(2, color("95 95 95")) ///
	bar(3, color("107 107 107")) ///
	bar(4, color("198 204 22")) ///
	bar(5, color("227 204 14")) ///
	bar(6, color("250 202 25")) ///
	bar(7, color("246 159 36")) ///
	bar(8, color("222 159 22")) ///
	bar(9, color("222 110 22")) ///
	note("Source: own calculation" "n=24,981")
	
*/


/*

graph bar miss_a56pct, ///
	over(m2_zeitmiss, gap(0)) over(view_a56) ///
	asyvars  ///
	graphregion(color(white)) ///
	ytitle("number of respondents (percent)") ///
	legend(pos(1) ring(0) col(1) size(vsmall)) ///
	ylabel( , labsize(vsmall)) ///
	bar(1, color("122 181 29")) ///	
	bar(2, color("0 106 178")) ///
	bar(3, color("121 160 191")) ///
	bar(4, color("221 221 221")) ///
	bar(5, color("95 95 95")) ///
	bar(6, color("178 210 232")) ///
	bar(7, color("246 159 36")) ///
	bar(8, color("152 149 150")) ///
	bar(9, color("102 166 209")) ///
	note("Source: own calculation" "n=24,981")
*/


		
*green-grey
/*
graph bar miss_a56pct, ///
	over(m2_zeitmiss, gap(0)) over(view_a56) ///
	asyvars  ///
	graphregion(color(white)) ///
	ytitle("number of respondents (percent)") ///
	legend(pos(1) ring(0) col(1) size(vsmall)) ///
	ylabel( , labsize(vsmall)) ///
	bar(1, color("122 181 29")) ///	
	bar(2, color("8 94 111")) ///
	bar(3, color("10 125 148")) ///
	bar(4, color("12 144 171")) ///
	bar(5, color("103 142 171")) ///
	bar(6, color("72 100 120")) ///
	bar(7, color("154 164 171")) ///
	bar(8, color("95 95 95")) ///
	bar(9, color("69 69 69")) ///
	note("Source: own calculation" "n=24,981")
*/		


	
graph save Graph "${results}A56_missing_Bar.gph", replace 
graph export "${results}A56_missing_Bar.png", as(png) replace 

/*
graph bar (percent) if ssemhs > 1 & ssemhs != . & dkinja==1, over(m2_zeitmiss, descending) over(view_a56) ///
	graphregion(color(white)) bgcolor(blue) ///
	stack percent scheme(s2color)  ///
	subtitle(% of view group) ///
	asyvars ///
	bar(1, bfcolor(white*0)) ///
	bar(2, bfcolor("89 89 89")) ///
	bar(3, bfcolor("214 217 121")) ///
	bar(4, bfcolor("160 166 5")) ///
	bar(5, bfcolor(ltkhaki)) ///
	bar(6, bfcolor(stone)) ///
	bar(7, bfcolor(khaki)) ///
	bar(8, bfcolor(brown)) 
graph save Graph "${results}A56_missing_stackedBar.gph", replace 
graph export "${results}A56_missing_stackedBar.png", as(png) replace 
*/



restore
preserve

*///////////////////////////////////////////////////////////////////
*____________Boxplots Bearbeitungsdauer ________ 
*///////////////////////////////////////////////////////////////////
drop if A56_dauer==.

table view_a56 if m2_zeitmiss==0 & A56_dauer!=. & A56_dauer>600, contents(mean A56_dauer n A56_dauer p25 A56_dauer p50 A56_dauer p75 A56_dauer) format(%9.2f) 



drop if A56_dauer>600
drop if m2_zeitmiss!=0

table view_a56 if m2_zeitmiss==0 & A56_dauer!=., contents(mean A56_dauer n A56_dauer p25 A56_dauer p50 A56_dauer p75 A56_dauer) format(%9.2f) 

//// Fälle entfernen mit Bearbeitungsdauer von mehr als 10 Minuten
drop if A56_dauer>600

graph hbox A56_dauer if m2_zeitmiss==0 , ///
	over(view_a56, relabel(1 "matrix (n=9,640)" 2 "carousel" 3 "scroll down") ///
	label(labsize(small) labgap(2.5))) noout /// 
	box(1, lcolor("71 71 71") fcolor("0 106 178") fintensity(inten100)) ///
	title("Distribution of Response Time by Way of Presentation") ///
	graphregion(color(white)) ///
	ytitle("response time in seconds", size(vsmall)) ///
	ylabel( , labsize(vsmall) labgap(.5)) ///
	note("To accounts for possible breaks during the survey, duration of more than 10 minutes were excluded." ///
	"Only observations were included without missing values." "Source: own calculation" "n=14,073", size(vsmall))

	
graph save Graph "${results}A56_respTime_BoxPlot.gph", replace 
graph export "${results}A56_respTime_BoxPlot.png", as(png) replace 

///fcolor("121 160 191") 	
/*	
graph save Graph "${results}miss_a56.gph", replace 
graph export "${results}miss_a56.png", as(png) replace 
*/
restore
*******************************************************************
************************* ANMERKUNGEN *****************************
* bei missingcount_a56 gibt es durch "egen ... anycount" eine leicht fehlerhafte Zählung: es verbleiben zu viele Werte "0", die eigentlich Missing "." sein sollten.
/*
graph bar missingcount_a56 if ssemhs > 1 & ssemhs != . & dkinja==1, over(m2_zeitmiss) over(view_a56)
graph save Graph "${results}missing_a56.gph", replace 
graph export "${results}missing_a56.png", as(png) replace 
*/

