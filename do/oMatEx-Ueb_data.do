**** Matrix-Experiment: Corona-Befragung 2021/ Überbrückungshilfe
**** Seite A56/ A56a (Zeitbudget)
**** Seite D3_6
**** Aufbereitung Befragungsdaten

*********************************************************************
*_______________ Überbrückungshilfe (SiD-Corona 2021)___________
global version "2021-04-21"
global orig "P:\Zofar\SiD\SiD-Corona-2021\orig\\${version}\"

****************************************************************************
** Projekt/ Studie: prod_ueberbrueckungshilfe
** Zweck: Auswertung des Experiments zur Darstellung von offenen Matrizen
** Erstelldatum: 22.02.2021 12:38:32
** Datensatz: Mon Feb 22 12:38:32 CET 2021
****************************************************************************
** Glossar Missing-Werte
** -9999 : voreingestellte Missing-Werte, insbesondere bei technischen Variablen
** -9992 : Item wurde gemäß Fragebogensteuerung nicht angezeigt oder befindet sich auf der Seite des Befragungsabbruches
** -9990 : Item wurde gesehen, aber nicht beantwortet
** -9991 : Seite, auf der sich das Item befindet, wurde gemäß Fragebogensteuerung oder aufgrund eines vorherigen Befragungsabbruches nicht besucht
** -9995 : Variable wurde nicht erhoben (-9992 oder -9991), jedoch für die Fragebogensteuerung verwendet
*************************************************************************
*************************************************************************
*79 "A_56" 
*80 "A_56c" 
*81 "A_56b" 
*82 "A_56a"

*65 "D3_6"
*66 "D3_6a"

*____________Daten importieren____________________
import delimited "${orig}data.csv", delimiter(comma) bindquote(strict) clear 


*____________Datensatz anpassen ____________________
keep id token lastpage lastcontact firstcontact finished preloadhs_id ///
	preloadhs_name preloadpanel consent url uas ///
	split_zeit split_fin ///
	width width2 width3 height height2 height3 ///	
	jscheck jscheck2 jscheck3 ismobile ismobile2 ismobile3 ///
	ssemfs ssemhs ssemul dkinja vd1_20 ///
	fmineinko fsitzum1 fsitzum2 fsitzum3 fsitzum4 fsitzum5 ///
	zlvwo zlvwo2 zseswo zseswo2 zerwo zerwo2 zcarwo zcarwo2 zchiwo zchiwo2 ///
	sf_a56 sf_a56b fbafja d313a1 d313a2 d313a3 d313a4 ///
	d313a5 d313a6 d313a7 d313a8 d313a9 d313a10 d313a11 d313a12 feininsg1 ///
	feininsg2 feinelto1 feinelto2 feinjobo1 feinjobo2 feinbafo1 feinbafo2 ///
	feinkredo1 feinkredo2 feinandq1 feinandq2 sf_d3_6 d36 d36open sf_d3_6a
	
*** Tester
foreach n of numlist 1/500 {
 quiet: drop if token=="tester`n'"
 quiet: drop if token=="part`n'"
 }

*** doppelte Fälle
bysort token: gen count= _N
drop if count==2
drop count

*** Variablen und Werte beschriften
label var dkinja "Haben Sie Kinder?"
label define dkinja_labelset 1 "[1] nein" 2 "[2] ja" 
label values dkinja dkinja_labelset

label var ssemfs "Im wievielten Fachsemester befinden Sie sich zurzeit?"
label var ssemhs "Im wievielten Hochschulsemester befinden Sie sich zurzeit?"
label var ssemul "Befinden Sie sich aktuell in einem Urlaubssemester?"

label var vd1_20 "Inwieweit würden Sie sich die folgenden Fähigkeiten und Kenntnisse zuschreiben: digitale Kompetenzen"
label define vd1_20_labelset 1 "[1] gar nicht" 2 "[2]" 3 "[3]" 4 "[4]" 5 "[5] in hohem Maße" 
label values vd1_20 vd1_20_labelset

label var zlvwo "Zeitbudget - dieses Semester (Std. pro (typ.) Woche: Lehrveranstaltungen"
label var zlvwo2 "Zeitbudget - letztes Semester (Std. pro (typ.) Woche: Lehrveranstaltungen"
label var zseswo "Zeitbudget - dieses Semester (Std. pro (typ.) Woche: Selbststudium"
label var zseswo2 "Zeitbudget - letztes Semester (Std. pro (typ.) Woche: Selbststudium"
label var zerwo "Zeitbudget - dieses Semester (Std. pro (typ.) Woche: Erwerbstätigkeit"
label var zerwo2 "Zeitbudget - letztes Semester (Std. pro (typ.) Woche: Erwerbstätigkeit"
label var zcarwo "Zeitbudget - dieses Semester (Std. pro (typ.) Woche: Pflege von Verwandten/Bekannten"
label var zcarwo2 "Zeitbudget - letztes Semester (Std. pro (typ.) Woche: Pflege von Verwandten/Bekannten"
label var zchiwo "Zeitbudget - dieses Semester (Std. pro (typ.) Woche: Kinderbetreuung"
label var zchiwo2 "Zeitbudget - letztes Semester (Std. pro (typ.) Woche: Kinderbetreuung"

label var feininsg1 "Gesamteinnahmen (€ pro Monat im letzten Semester)"
label var feininsg2 "Gesamteinnahmen (€ pro Monat in diesem Semester)"
label var feinelto1 "davon entfallen auf… Eltern und Verwandte (im letzten Semester)"
label var feinelto2 "davon entfallen auf… Eltern und Verwandte (in diesem Semester)"
label var feinjobo1 "davon entfallen auf… Erwerbstätigkeit (im letzten Semester)"
label var feinjobo2 "davon entfallen auf… Erwerbstätigkeit (in diesem Semester)"
label var feinbafo1 "davon entfallen auf… BAföG (im letzten Semester)"
label var feinbafo2 "davon entfallen auf… BAföG (in diesem Semester)"
label var feinkredo1 "davon entfallen auf… Kredit/Darlehen (im letzten Semester)"
label var feinkredo2 "davon entfallen auf… Kredit/Darlehen (in diesem Semester)"
label var feinandq1 "davon entfallen auf… weitere Finanzierungsquelle(n) (im letzten Semester)"
label var feinandq2 "davon entfallen auf… weitere Finanzierungsquelle(n) (in diesem Semester)"

label var sf_d3_6 "Es werden weitere Finanzierungsquellen genannt. Bitte benutzen Sie den Pfeil od"
label var d36 "Werden Sie durch Ihre Eltern oder andere Personen unterstützt, indem diese best"
label var d36open "Werden Sie durch Ihre Eltern oder andere Personen unterstützt, indem diese best"
label var sf_d3_6a "Auf dieser Seite wird auch nach den Finanzierungsquellen in diesem Semester gef"


*____________Seitenverweildauer mergen ____________________
merge 1:1 token using "${data}Ueb_history_collapsed.dta", keepusing(p79 p80 p81 p82 visit79 visit80 visit81 visit82 p65 p66 visit65 visit66 maxpage dauer speed_med speed_mn dauer)


label var speed_med "mittlere Seitenverweildauer"
label var speed_mn "durchschnittliche Seitenverweildauer"
*label var dauer_mn "durchschnittliche Bearbeitungsdauer des Fragebogen"
*label var dauer_med "mittlere Bearbeitungsdauer des Fragebogens"
*label var dauer "???"
// To Do: dauer wahrscheinlich Summe von Verweildauern und Visits --> checken und ggf. korrigieren

*__________________________________________________________________
*____________Bildschirmgröße _________________________________

destring width, gen(breite1)
destring height, gen(hoehe1)
gen breite1=width
gen hoehe1=height

destring width2, gen(breite_a56)
destring height2, gen(hoehe_a56)
gen breite_a56=width2
gen hoehe_a56=height2

destring width3, gen(breite_d36)
destring height3, gen(hoehe_d36)
gen breite_d36=width3
gen hoehe_d36=height3

*************************************************************************
*************************************************************************
*____________Indikatoren erstellen____________________
// Indikatoren für Antwortverhalten und Datenqualität


*________________ [0.] Seitenansicht der offenen Matrix _______________________
gen view_a56=.
replace view_a56=0 if split_zeit==1 & breite_a56 >= 768 
replace view_a56=1 if split_zeit==1 & breite_a56 <768 
replace view_a56=0 if split_zeit==2 & breite_a56 >= 768 
replace view_a56=2 if split_zeit==2 & breite_a56 <768
replace view_a56=0 if split_zeit==3 & breite_a56 >= 768 
replace view_a56=1 if split_zeit==3 & breite_a56 <768
replace view_a56=0 if split_zeit==4 & breite_a56 >= 768 
replace view_a56=2 if split_zeit==4 & breite_a56 <768

label var view_a56 "Ansicht A_56 unterteilt: Carousel vs. Scrolling"
label define view_a56 0 "matrix" 1 "carousel" 2 "scroll down"
label val view_a56 view_a56
tab view_a56

gen context_a56=.
replace context_a56=0 if split_zeit==1 & breite_a56 >= 768 
replace context_a56=1 if split_zeit==1 & breite_a56 <768 
replace context_a56=1 if split_zeit==2 & breite_a56 <768
replace context_a56=2 if split_zeit==3 & breite_a56 <768
replace context_a56=2 if split_zeit==4 & breite_a56 <768

label var context_a56 "Ansicht A_56 unterteilt: zeilenweise vs. Spaltwenweise"
label define context_a56 0 "Matrix" 1 "zeilenweise" 2 "spaltenweise"
label val context_a56 context_a56
tab context_a56


gen conview_a56=.
replace conview_a56=0 if split_zeit==1 & breite_a56 >= 768 
replace conview_a56=1 if split_zeit==1 & breite_a56 <768 
replace conview_a56=2 if split_zeit==2 & breite_a56 <768
replace conview_a56=3 if split_zeit==3 & breite_a56 <768
replace conview_a56=4 if split_zeit==4 & breite_a56 <768

label var conview_a56 "Ansicht A_56 nach 4 Gruppen unterteilt"
label define conview_a56 0 "Matrix" 1 "Carousel, zeilenweise" 2 "scroll down zeilenweise" 3 "carousel, spaltenweise" 4 "scroll down, spaltenweise"
label val conview_a56 conview_a56
tab conview_a56


*--- mobile Ansicht (wenn Bildschirmbreite < 768) (Index-Seite)
gen mobile=0 
replace mobile=1 if breite1 <768 
label var mobile "Mobilansicht (Breite < 768, index-Seite)"
tab mobile

*--- mobile Ansicht (wenn Bildschirmbreite < 768)
gen mobile_a56=0 
replace mobile_a56=1 if breite_a56 <768 
label var mobile_a56 "A_56 Mobilansicht (Breite < 768)"
tab mobile_a56

*--- mobile Ansicht (wenn Bildschirmbreite < 768)
gen mobile_d36=0 
replace mobile_d36=1 if breite_d36 <768 
label var mobile_d36 "D3_6 Mobilansicht (Breite < 768)"
tab mobile_d36


*________________________________________________________________
*________________ [1.] für Befragungsabbruch ________________________
// zentrale Frage: Hängt der Abbruch des Fragebogens mit der Darstellung zusammen?
// Befragungsabbruch nach 1. maxpage und nach 2. lastpage
*79 "A_56" 
*80 "A_56c" 
*81 "A_56b" 
*82 "A_56a"

gen a56max=0 if maxpage>=79
replace a56max=1 if maxpage>=79 & maxpage<=82
label var a56max "Befragungsabbruch bei offener Matrix (mit maxpage)"

gen a56last=0 if maxpage>=79
replace a56last=1 if lastpage=="/A_56.xhtml" | lastpage=="/A_56a.xhtml" |  lastpage=="/A_56b.xhtml" |  lastpage=="/A_56c.xhtml"
label var a56last "Befragungsabbruch bei offener Matrix (mit lastpage)"

*---
gen a56_last=0 if split_zeit==1 & maxpage>=79
replace a56_last=1 if lastpage=="/A_56.xhtml"
label var a56_last "A_56 als letzte Seite"
gen a56_max=0 if split_zeit==1 & maxpage>=79
replace a56_max=1 if maxpage==79
label var a56_max "A_56 als maximale Seite"

gen a56a_last=0 if split_zeit==2 & maxpage>=82
replace a56a_last=1 if lastpage=="/A_56a.xhtml"
label var a56a_last "A_56a als letzte Seite"
gen a56a_max=0 if split_zeit==2 & maxpage>=82
replace a56a_max=1 if maxpage==82
label var a56a_max "A_56a als maximale Seite"

gen a56b_last=0 if split_zeit==3 & maxpage>=81
replace a56b_last=1 if lastpage=="/A_56b.xhtml"
label var a56b_last "A_56b als letzte Seite"
gen a56b_max=0 if split_zeit==3 & maxpage>=81
replace a56b_max=1 if maxpage==81
label var a56b_max "A_56b als maximale Seite"

gen a56c_last=0 if split_zeit==4 & maxpage>=80
replace a56c_last=1 if lastpage=="/A_56c.xhtml"
label var a56c_last "A_56c als letzte Seite"
gen a56c_max=0 if split_zeit==4 & maxpage>=80
replace a56c_max=1 if maxpage==80
label var a56c_max "A_56c als maximale Seite"


*_______________________________________________________________
*________________ [2.] für item nonresponse ________________________
// -9990-Werte gelten als Itemnonresponse

foreach var of varlist zlvwo zlvwo2 zseswo zseswo2 zerwo zerwo2 zcarwo zcarwo2 zchiwo zchiwo2 {
    gen `var'_miss = 0
	replace `var'_miss= 1 if `var'==-9990 
}


// missing-Muster (bestimmte Items --> satisficing oder carousel nicht verstanden)
gen zeitmiss_pat=0 if maxpage>=79
replace zeitmiss_pat=1 if zlvwo==-9990 | zlvwo2==-9990
replace zeitmiss_pat=2 if zseswo==-9990 | zseswo2==-9990
replace zeitmiss_pat=3 if zerwo==-9990 | zerwo2==-9990
replace zeitmiss_pat=4 if zcarwo==-9990 | zcarwo2==-9990
replace zeitmiss_pat=5 if zchiwo==-9990 | zchiwo2==-9990
label var zeitmiss_pat "Itemnonresponse nach Items sortiert (inkl. 0 Missings)"


gen zeitmiss_pat2=. 
replace zeitmiss_pat2=1 if zlvwo==-9990 | zlvwo2==-9990
replace zeitmiss_pat2=2 if zseswo==-9990 | zseswo2==-9990
replace zeitmiss_pat2=3 if zerwo==-9990 | zerwo2==-9990
replace zeitmiss_pat2=4 if zcarwo==-9990 | zcarwo2==-9990
replace zeitmiss_pat2=5 if zchiwo==-9990 | zchiwo2==-9990
label var zeitmiss_pat2 "Itemnonresponse nach Items sortiert (ohne 0 Missings)"

label define zeitmisslb 0 "0: keine Missings" 1 "1: Lehrveranstaltungen" 2  "2: Selbststudium" 3  "3: Erwerbstätigkeit" 4  "4: Pflege von Verwandten/Bekannten" 5  "5: Kinderbetreuung"
label val zeitmiss_pat zeitmiss_pat2 zeitmisslb

// Anzahl der Missing-Werte auf Seite A56/A56a
/*
gen zeit_miss=.
replace zeit_miss=1 if zlvwo==-9990 | zseswo==-9990 | zerwo==-9990 | zcarwo==-9990 | zchiwo==-9990
*/

*** 3.  Einschränkung auf erste Spalte (in diesem Semester)
egen zeit1miss= anycount(zlvwo zseswo zerwo zcarwo zchiwo), values(-9990)
label var zeit1miss "Anzahl Itemnonresponse bei zlvwo, zseswo, zerwo, zcarwo, zchiwo (mit HS=1 (nur erste Spalte), (0-5))"
tab zeit1miss
list zlvwo zseswo zerwo zcarwo zchiwo if zeit1miss==4

*** 4.  Einschränkung auf zweite Spalte (im letzten Semester)
egen zeit2miss= anycount(zlvwo2 zseswo2 zerwo2 zcarwo2 zchiwo2), values(-9990)
label var zeit2miss "Anzahl Itemnonresponse bei zlvwo2, zseswo2, zerwo2, zcarwo2, zchiwo2"
tab zeit2miss


*** 
egen zeitmissNoChild= anycount(zlvwo zseswo zerwo zcarwo zlvwo2 zseswo2 zerwo2 zcarwo2) if ssemhs>1 & ssemhs!=. & dkinja==1 & maxpage>=79, values(-9990)
label var zeitmissNoChild "Anzahl Itemnonresponse bei zlvwo/ zlvwo2 - zcarw/zcarwo2 (keine Kinder, mind. 2. HS-Sem.)"
tab zeitmissNoChild

// Missings auf Seite A56/A56a als binäre Variablen
gen a56miss=.
replace a56miss=0 if zeitmissNoChild==0
replace a56miss=1 if (zeitmissNoChild>=1) & (ssemhs>1 & ssemhs != . & dkinja==1)

*to delete
*replace a56miss=1 if (zeit1miss>=1 & zeit1miss<=5) & (zeit2miss>=1 & zeit2miss<=5 & ssemhs>1 & ssemhs != .)
tab a56miss

mvdecode zlvwo zlvwo2 zseswo zseswo2 zerwo zerwo2 zcarwo zcarwo2 zchiwo zchiwo2 ismobile dkinja ssemhs, mv(-9990 = . \ -9991=.a \ -9992=.b \ -9995=.c)



*** 1. Einschränkung auf Hochschulsemester>1 und Kinder= 'ja' (alle Variablen werden gezeigt, zweispaltige Matrix)
foreach v of varlist zlvwo zlvwo2 zseswo zseswo2 zerwo zerwo2 zcarwo zcarwo2 {
	gen miss`v' =.  
	replace miss`v' =0 if `v'!=. 
	replace miss`v' =1 if `v'==. & ssemhs>1 & ssemhs != .
	replace miss`v' =0 if `v'==.a | `v'==.b | `v'==.c
}



egen zeitmiss= rowtotal(misszlvwo misszlvwo2 misszseswo misszseswo2 misszerwo misszerwo2 misszcarwo misszcarwo2), missing
label var zeitmiss "Anzahl Missing-Werte mit HS>1 und Kinder='ja' (0-10)"
tab zeitmiss


drop misszlvwo misszlvwo2 misszseswo misszseswo2 misszerwo misszerwo2 misszcarwo misszcarwo2

*** 2. Einschränkung auf Hochschulsemester>1 und ohne Kinder (zchiwo) (alle Variablen werden gezeigt, zweispaltige Matrix)
foreach v of varlist zlvwo zlvwo2 zseswo zseswo2 zerwo zerwo2 zcarwo zcarwo2 {
	gen miss`v' =.  
	replace miss`v' =1 if `v'==. & ssemhs>1 & ssemhs != . & dkinja==1
	replace miss`v' =0 if `v'!=. & `v'!= .a & `v'!=.b & `v'!=.c 
}

egen m2_zeitmiss= rowtotal(misszlvwo misszlvwo2 misszseswo misszseswo2 misszerwo misszerwo2 misszcarwo misszcarwo2) if ssemhs>1 & ssemhs != . & dkinja==1, missing
label var m2_zeitmiss "Anzahl Missing-Werte mit HS>1, ohne Kinder (0-8)"
tab m2_zeitmiss

*________________________________________________________________
*________________ [3.] für Bearbeitungsdauer ________________________
drop if token=="s21DhhBaT" | token=="s21jcTpbG" | token=="s21H2yuhR" | token=="s21l5bFko" | token=="s21t4NknT" 

gen A56_dauer=p79
replace A56_dauer=p80 if A56_dauer==.
replace A56_dauer=p81 if A56_dauer==.
replace A56_dauer=p82 if A56_dauer==.


/*
// Variable mit Verweildauer auf a56 und a56a erstellen
// --> korrigieren um Fälle, die auf beiden Seiten waren
gen c=1 if p79!=. & p80!=. & p81!=. & p82!=.
tab c
gen A56_dauer=p79 if c!=1
replace A56_dauer=p71 if c!=1 & A56_dauer==.
tab A56_dauer if c==1
drop c

 *** ToDo: nachvollziehen und korrigieren 
list token split_zeit p79 p82 if (p79!=. & p82!=.)

+----------------------------------------+
|     token   split_zeit    p79      p82 |
|----------------------------------------|
| s21DhhBaT          2    2.999    1.431 |
| s21jcTpbG          1   12.053   82.794 |
+----------------------------------------+

list token split_zeit p80 p82 if (p80!=. & p82!=.)

+------------------------------------------+
|     token   split_zeit    p80        p82 |
|------------------------------------------|
| s21H2yuhR          4   24.195   1769.526 |
| s21l5bFko          2   192.07      2.406 |
| s21t4NknT          4   75.254    1287.73 |
+------------------------------------------+

*/

*___ Bearbeitungsdauer der Seite A56/A56/A56a ins Verhältnis setzen mit der durchschnittlichen Seitenverweildauer (speed_mn)
gen a= A56_dauer/speed_mn
// >1 --> Bearbeitung der Seite ist länger als die durchschnittliche Seitenverweildauer, <1 --> Bearbeitung der Seite ist kürzer als die durchschnittliche
tabstat a, statistics(mean sd min max)

*___ Bearbeitungsdauer der Seite A56/A56/A56a ins Verhältnis setzen mit der mittleren Seitenverweildauer (speed_med)
gen b= A56_dauer/speed_med
tabstat b, statistics(mean sd min max)
// >1 --> Bearbeitung der Seite ist länger als die mittlere Seitenverweildauer, <1 --> Bearbeitung der Seite ist kürzer als die mittlere

*________________________________________________________
*________________ [4.] für Antworten ________________________
*___Summenindex der Variablen zlvwo - zcarwo
egen sum_zeit_sem1= rowtotal(zlvwo zseswo zerwo zcarwo) , missing
label var sum_zeit_sem1 "wöchentliches Zeitbudget in diesem Semester (ohne Kinder)"
egen sum_zeit_sem2= rowtotal(zlvwo2 zseswo2 zerwo2 zcarwo2) , missing
label var sum_zeit_sem2 "wöchentliches Zeitbudget im letzten Semester (ohne Kinder)"

