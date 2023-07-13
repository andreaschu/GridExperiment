**** Matrix-Experiment: Corona-Sonderbefragung 2020
**** Seite A56/ A56a (Zeitbudget)
**** Aufbereitung Befragungsdaten


*********************************************************************
*_______________ SiD-Corona 2020 ___________
global version "2020-08-10"
global orig "P:\Zofar\SiD\SiD-Corona\orig\\${version}\"


***************************************************************************
** Projekt/ Studie: prod_corona-sid
** Zweck: Auswertung des Experiments zur Darstellung von offenen Matrizen
** Erstelldatum: 27.07.2020
** Ersteller: Andrea Schulze
***************************************************************************
** Glossar Missing-Werte
** -9999 : voreingestellte Missing-Werte, insbesondere bei technischen Variablen
** -9992 : Item wurde gemäß Fragebogensteuerung nicht angezeigt oder befindet sich auf der Seite des Befragungsabbruches
** -9990 : Item wurde gesehen, aber nicht beantwortet
** -9991 : Seite, auf der sich das Item befindet, wurde gemäß Fragebogensteuerung oder aufgrund eines vorherigen Befragungsabbruches nicht besucht
** -9995 : Variable wurde nicht erhoben (-9992 oder -9991), jedoch für die Fragebogensteuerung verwendet
*************************************************************************
*************************************************************************

*____________Daten importieren____________________
import delimited "${orig}data.csv", delimiter(comma) bindquote(strict) clear 


*____________Datensatz anpassen ____________________
*** Datensatz auf wichtige Variablen reduzieren
keep height width ismobile jscheck token ///
	zlvwo zlvwo2 zseswo zseswo2 zerwo  zerwo2 zcarwo zcarwo2 zchiwo zchiwo2 ///
	s_split_zeit1 lastpage ssemhs ssemfs ssemul dkinja vd1_20

*** Tester
foreach n of numlist 1/200 {
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
label var vd1_20 "Selbsteinschätzung digitaler Kompetenz"


	
*____________Seitenverweildauer mergen ____________________
merge 1:1 token using "${data}history_collapsed.dta", keepusing(p71 p72 visit71 visit72 maxpage dauer speed_med speed_mn dauer dauer_mn dauer_med)

label var speed_med "mittlere Seitenverweildauer"
label var speed_mn "durchschnittliche Seitenverweildauer"
label var dauer_mn "durchschnittliche Bearbeitungsdauer des Fragebogen"
label var dauer_med "mittlere Bearbeitungsdauer des Fragebogens"
*label var dauer "???"
// To Do: dauer wahrscheinlich Summe von Verweildauern und Visits --> checken und ggf. korrigieren

*__________________________________________________________________
*____________Bildschirmgröße _________________________________
replace width="" if width=="null"
replace height="" if height=="null"

gen screen=height + "x" + width

tab1 jscheck ismobile screen, miss

tab1 width height if screen==""

destring width, gen(breite)
destring height, gen(hoehe)

*************************************************************************
*************************************************************************
*____________Indikatoren erstellen____________________
// Indikatoren für Antwortverhalten und Datenqualität


*________________ [0.] Seitenansicht der offenen Matrix ________________________
gen view_a56=.
replace view_a56=0 if s_split_zeit1==2 & breite >= 768 
replace view_a56=1 if s_split_zeit1==2 & breite <768 
replace view_a56=2 if s_split_zeit1==1 & breite <768
label define view_a56 0 "matrix" 1 "carousel" 2 "scroll down"
label val view_a56 view_a56
label var view_a56 "Seitenansicht der offenen Matrix (A_56)"
tab view_a56

*--- mobile Ansicht (wenn Bildschirmbreite < 768)
gen mobile=0 
replace mobile=1 if breite <768 
tab mobile

*________________________________________________________________
*________________ [1.] für Befragungsabbruch ________________________
// zentrale Frage: Hängt der Abbruch des Fragebogens mit der Darstellung zusammen?
// Befragungsabbruch nach 1. maxpage und nach 2. lastpage

gen a56max=0 if maxpage>=71
replace a56max=1 if maxpage==71 | maxpage==72
label var a56max "Befragungsabbruch bei A_56/A_56a (mit maxpage)"

gen a56last=0 if maxpage>=71
replace a56last=1 if lastpage=="/A_56.xhtml" | lastpage=="/A_56a.xhtml"
label var a56last "Befragungsabbruch bei A_56/A_56a (mit lastpage)"

*---
gen a56a_last=0 if s_split_zeit1==1 & maxpage>=71
replace a56a_last=1 if lastpage=="/A_56a.xhtml"
label var a56a_last "A56a als letzte Seite"
gen a56a_max=0 if s_split_zeit1==1 & maxpage>=71
replace a56a_max=1 if maxpage==71 
label var a56a_max "A56a als maximale Seite"

gen a56b_last=0 if s_split_zeit1==2 & maxpage>=72
replace a56b_last=1 if lastpage=="/A_56.xhtml"
label var a56b_last "A56 als letzte Seite"
gen a56b_max=0 if s_split_zeit1==2 & maxpage>=72
replace a56b_max=1 if maxpage==72 
label var a56b_max "A56 als maximale Seite"


*_______________________________________________________________
*________________ [2.] für item nonresponse ________________________
// -9990-Werte gelten als Itemnonresponse

foreach var of varlist zlvwo zlvwo2 zseswo zseswo2 zerwo zerwo2 zcarwo zcarwo2 zchiwo zchiwo2 {
    gen `var'_miss = 0
	replace `var'_miss= 1 if `var'==-9990 
}


// missing-Muster (bestimmte Items --> satisficing oder carousel nicht verstanden)
gen zeitmiss_pat=0 if maxpage>=71 & ssemhs > 1 & ssemhs != .
replace zeitmiss_pat=1 if (zlvwo==-9990 | zlvwo2==-9990) & ssemhs > 1 & ssemhs != .
replace zeitmiss_pat=2 if (zseswo==-9990 | zseswo2==-9990) & ssemhs > 1 & ssemhs != .
replace zeitmiss_pat=3 if (zerwo==-9990 | zerwo2==-9990) & ssemhs > 1 & ssemhs != .
replace zeitmiss_pat=4 if (zcarwo==-9990 | zcarwo2==-9990) & ssemhs > 1 & ssemhs != .
replace zeitmiss_pat=5 if (zchiwo==-9990 | zchiwo2==-9990) & ssemhs > 1 & ssemhs != .
label var zeitmiss_pat "Itemnonresponse nach Items sortiert (inkl. 0 Missings)"


gen zeitmiss_pat2=. 
replace zeitmiss_pat2=1 if (zlvwo==-9990 | zlvwo2==-9990) & ssemhs > 1 & ssemhs != .
replace zeitmiss_pat2=2 if (zseswo==-9990 | zseswo2==-9990) & ssemhs > 1 & ssemhs != .
replace zeitmiss_pat2=3 if (zerwo==-9990 | zerwo2==-9990) & ssemhs > 1 & ssemhs != .
replace zeitmiss_pat2=4 if (zcarwo==-9990 | zcarwo2==-9990) & ssemhs > 1 & ssemhs != .
replace zeitmiss_pat2=5 if (zchiwo==-9990 | zchiwo2==-9990) & ssemhs > 1 & ssemhs != .
label var zeitmiss_pat2 "Itemnonresponse nach Items sortiert (ohne 0 Missings)"

label define zeitmisslb 0 "0: keine Missings" 1 "1: Lehrveranstaltungen" 2  "2: Selbststudium" 3  "3: Erwerbstätigkeit" 4  "4: Pflege von Verwandten/Bekannten" 5  "5: Kinderbetreuung"
label val zeitmiss_pat zeitmiss_pat2 zeitmisslb

// Anzahl der Missing-Werte auf Seite A56/A56a
/*
gen zeit_miss=.
replace zeit_miss=1 if zlvwo==-9990 | zseswo==-9990 | zerwo==-9990 | zcarwo==-9990 | zchiwo==-9990
*/


*** 3.  Einschränkung auf erste Spalte (in diesem Semester)
egen zeit1miss= anycount(zlvwo zseswo zerwo zcarwo zchiwo) if ssemhs==1, values(-9990)
label var zeit1miss "Anzahl Itemnonresponse bei zlvwo - zchiwo (mit HS=1 (nur erste Spalte), (0-5))"
tab zeit1miss
list zlvwo zseswo zerwo zcarwo zchiwo if zeit1miss==4

*** 4.  Einschränkung auf zweite Spalte (im letzten Semester)
egen zeit2miss= anycount(zlvwo2 zseswo2 zerwo2 zcarwo2 zchiwo2) if ssemhs>1 & ssemhs != ., values(-9990)
label var zeit2miss "Anzahl Itemnonresponse bei zlvwo2 - zchiwo2 (mit HS>1 (nur zweite Spalte), (0-5))"
tab zeit2miss

*** 
egen zeitmissNoChild= anycount(zlvwo zseswo zerwo zcarwo zlvwo2 zseswo2 zerwo2 zcarwo2) if ssemhs>1 & ssemhs != . & dkinja==1 & maxpage>=71, values(-9990)
label var zeitmissNoChild "Anzahl Itemnonresponse bei zlvwo/ zlvwo2 - zcarw/zcarwo2 (keine Kinder, mind. 2. HS-Sem.)"
tab zeitmissNoChild


// Missings auf Seite A56/A56a als binäre Variablen
gen a56miss=.
replace a56miss=0 if zeitmissNoChild==0
replace a56miss=1 if (zeitmissNoChild>=1) & (ssemhs>1 & ssemhs != . & dkinja==1)

*to delete
*replace a56miss=1 if (zeit1miss>=1 & zeit1miss<=5) & (zeit2miss>=1 & zeit2miss<=5 & ssemhs>1 & ssemhs != .)
tab a56miss


mvdecode zlvwo zlvwo2 zseswo zseswo2 zerwo zerwo2 zcarwo zcarwo2 zchiwo zchiwo2 ismobile s_split_zeit1 dkinja ssemhs, mv(-9990 = . \ -9991=.a \ -9992=.b \ -9995=.c)

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

// Variable mit Verweildauer auf a56 und a56a erstellen
// --> korrigieren um Fälle, die auf beiden Seiten waren
gen c=1 if p72!=. & p71!=.
tab c
gen A56_dauer=p72 if c!=1
replace A56_dauer=p71 if c!=1 & A56_dauer==.
tab A56_dauer if c==1
drop c

*___ Bearbeitungsdauer der Seite A56/A56/A56a ins Verhältnis setzen mit der durchschnittlichen Seitenverweildauer (speed_mn)
gen a= A56_dauer/speed_mn
// >1 --> Bearbeitung der Seite ist länger als die durchschnittliche Seitenverweildauer, <1 --> Bearbeitung der Seite ist kürzer als die durchschnittliche
tabstat a, statistics(mean sd min max)

*___ Bearbeitungsdauer der Seite A56/A56/A56a ins Verhältnis setzen mit der mittleren Seitenverweildauer (speed_med)
gen b= A56_dauer/speed_med
tabstat b, statistics(mean sd min max)
// >1 --> Bearbeitung der Seite ist länger als die mittlere Seitenverweildauer, <1 --> Bearbeitung der Seite ist kürzer als die mittlere


*tabout screen using "${out}doc\screen-size.xls", dpcomma oneway replace cells(col)

*drop url jscheck ismobile width height screen width_t height_t

*________________________________________________________
*________________ [4.] für Antworten ________________________
*___Summenindex der Variablen zlvwo - zchiwo2
egen sum_zeit= rowtotal(zlvwo), missing



*________________ [5.] Sonstiges________________________
destring jscheck width height, force replace

*** Missing-Werte definiern
mvdecode height width ismobile jscheck ///
	s_split_zeit1 lastpage ssemhs dkinja vd1_20, ///
	mv(-9990 = . \ -9991=.a \ -9992=.b \ -9999=.c)


