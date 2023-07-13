**** Matrix-Experiment: Corona-Sonderbefragung 2020
**** Seite A56/ A56a (Zeitbudget)
**** Aufbereitung history-Daten

*********************************************************************
*_______________ SiD-Corona 2020 ___________
global version "2020-08-10"
global workdir "P:\Zofar\0_matrix_exp\"	
global orig "P:\Zofar\SiD\SiD-Corona\orig\\${version}\"
global data "${workdir}data\"
global results "${workdir}results\"

***************************************************************************
** Projekt/ Studie: prod_corona-sid 
** Daten: history-Daten
** Zweck: Auswertung des Experiments zur Darstellung von offenen Matrizen
** Erstelldatum: 27.07.2020
** Ersteller: Andrea Schulze
***************************************************************************
*__________________________________________________________________
** Do-File zur Aufbereitung der history-Daten zur Verwendung der Analyse des Matrix-Experiments
** Matrix-Experiment:
** - offene Matrix auf A_56 wurde für mobile Geräte unterschiedlich dargestellt
** - A_56 (p72) --> Standard-Auflösung in ein Carousel
** - A_56a (p71) --> Darstellung der Informationen untereinander (scroll down)
*__________________________________________________________________

*____________Daten importieren____________________
import delimited "${orig}history.csv", delimiter(comma) bindquote(strict) clear 

*____________Fälle löschen ____________________
*** Tester
foreach n of numlist 1/200 {
 quiet: drop if token=="tester`n'"
 quiet: drop if token=="part`n'"
 }
 
*_________Zeitstempel in numerische Variable umwandeln_______
gen double seiteneing=clock(timestamp, "YMDhms", 2020)
format seiteneing %-tc
label var seiteneing "Zeitstempel für Seiteneingang"

*________Berechnung der Verweildauer pro Seite (in Sekunden)____
//Achtung: automatischer SessionTimeout i.d.R. nach einer halben Stunde
sort participant_id seiteneing, stable
gen verwdauer= seiteneing[_n+1]-seiteneing if participant_id==participant_id[_n+1]

replace verwdauer= verwdauer/1000

label var verwdauer "Verweildauer pro Seite in Sekunden"

tabstat verwdauer, statistics(mean median min max sd)
//Korrektur der Verweildauer auf max. 30 Minuten (1800 Sekunden) pro Seitenbesuch
replace verwdauer=1800 if verwdauer>1800 & verwdauer!=.

*__________Fragebogenseiten nummerieren___________
// Seitennummerierung nach Reihenfolge im Fragebogen (QML)
gen seitennr=.
replace seitennr=0 if page=="index"
replace seitennr=1 if page=="offer"
replace seitennr=2 if page=="A_17"
replace seitennr=3 if page=="CO_1"
replace seitennr=4 if page=="D1_13"
replace seitennr=5 if page=="N_4"
replace seitennr=6 if page=="CO_2"
replace seitennr=7 if page=="N_9b"
replace seitennr=8 if page=="CO_3"
replace seitennr=9 if page=="CO_4"
replace seitennr=10 if page=="D2_21"
replace seitennr=11 if page=="CO_5"
replace seitennr=12 if page=="CO_6"
replace seitennr=13 if page=="A_23"
replace seitennr=14 if page=="A_24"
replace seitennr=15 if page=="A_25"
replace seitennr=16 if page=="A_27"
replace seitennr=17 if page=="A_28"
replace seitennr=18 if page=="A_49a"
replace seitennr=19 if page=="D2_5"
replace seitennr=20 if page=="D2_18"
replace seitennr=21 if page=="D2_19"
replace seitennr=22 if page=="CO_18"
replace seitennr=23 if page=="A_51b"
replace seitennr=24 if page=="D2_11"
replace seitennr=25 if page=="D2_13"
replace seitennr=26 if page=="CO_7"
replace seitennr=27 if page=="N_9"
replace seitennr=28 if page=="N_10a"
replace seitennr=29 if page=="N_10b"
replace seitennr=30 if page=="A_22"
replace seitennr=31 if page=="A_38"
replace seitennr=32 if page=="A_41"
replace seitennr=33 if page=="A_1"
replace seitennr=34 if page=="A_5"
replace seitennr=35 if page=="A_34"
replace seitennr=36 if page=="A_32"
replace seitennr=37 if page=="A_9b"
replace seitennr=38 if page=="A_10"
replace seitennr=39 if page=="A_12a"
replace seitennr=40 if page=="A_11"
replace seitennr=41 if page=="A_12"
replace seitennr=42 if page=="C1_1"
replace seitennr=43 if page=="C1_2"
replace seitennr=44 if page=="C1_6"
replace seitennr=45 if page=="A_15"
replace seitennr=46 if page=="C2_0"
replace seitennr=47 if page=="CO_21"
replace seitennr=48 if page=="D3_23"
replace seitennr=49 if page=="D1_27"
replace seitennr=50 if page=="D1_28"
replace seitennr=51 if page=="B1_2"
replace seitennr=52 if page=="D1_24"
replace seitennr=53 if page=="D1_25"
replace seitennr=54 if page=="CO_19"
replace seitennr=55 if page=="A_42"
replace seitennr=56 if page=="D3_19"
replace seitennr=57 if page=="CO_8"
replace seitennr=58 if page=="CO_9"
replace seitennr=59 if page=="CO_9a1"
replace seitennr=60 if page=="CO_9a"
replace seitennr=61 if page=="CO_24"
replace seitennr=62 if page=="D3_13"
replace seitennr=63 if page=="D3_6"
replace seitennr=64 if page=="CO_20"
replace seitennr=65 if page=="CO_22"
replace seitennr=66 if page=="CO_23"
replace seitennr=67 if page=="D3_8"
replace seitennr=68 if page=="D3_9"
replace seitennr=69 if page=="D3_11"
replace seitennr=70 if page=="B2_7"
replace seitennr=71 if page=="A_56a"
replace seitennr=72 if page=="A_56"
replace seitennr=73 if page=="A_53"
replace seitennr=74 if page=="D3_2"
replace seitennr=75 if page=="CO_10"
replace seitennr=76 if page=="N_16"
replace seitennr=77 if page=="B2_5"
replace seitennr=78 if page=="D3_22"
replace seitennr=79 if page=="A_16"
replace seitennr=80 if page=="A_54"
replace seitennr=81 if page=="A_55"
replace seitennr=82 if page=="F1_15"
replace seitennr=83 if page=="F1_18"
replace seitennr=84 if page=="CO_11"
replace seitennr=85 if page=="CO_12"
replace seitennr=86 if page=="CO_13"
replace seitennr=87 if page=="CO_14"
replace seitennr=88 if page=="CO_16"
replace seitennr=89 if page=="CO_17"
replace seitennr=90 if page=="D1_20"
replace seitennr=91 if page=="A_57"
replace seitennr=92 if page=="end"
tab page if seitennr==.

label var seitennr "Fragebogenseite"
tab seitennr, miss
tab page if seitennr==.
*tab page seitennr


*__________maximaler Fragebogenfortschritt___________
sort participant_id id, stable
by participant_id: egen maxpage = max(seitennr)
label var maxpage "maximaler Fortschritt im Fragebogen"

*__________letzte Fragebogenseite___________
sort participant_id id, stable
by participant_id: gen last = seitennr if participant_id!=participant_id[_n+1]
by participant_id: egen lastpage = max(last)
label var lastpage "letzte gesehene Fragebogenseite"
drop last

*______Seitenaufrufe pro Seite pro Befragten im Verlauf der Befragung_________
sort participant_id seitennr, stable
by participant_id seitennr: gen visit=_N
label var visit "Anzahl des Seitenaufrufes im Verlauf der Befragung"


*_______überflüssige Variablen löschen_________
drop id timestamp

*************************************************************************
*************************************************************************
****** Datensatz umwandeln in ein breites Format mit aggregierten Daten **

*________Datensatz aggregieren____________________
// Datensatz reduzieren auf eine Zeile pro Befragten und Fragebogenseite
// !Achtung: bei mehrmaligem Laden einer Seite wird der Verbleib summiert!
list token seiteneing verwdauer if token=="coad2qres" & page=="index"
bysort participant_id page: gen allmiss=mi(verwdauer)
list token seiteneing verwdauer allmiss if token=="coad2qres" & page=="index"

*** Datensatz reduzieren
collapse (sum) verwdauer (first) token seitennr seiteneing (max) allmiss visit (mean) maxpage lastpage, by(participant_id page)

list token allmiss seiteneing verwdauer allmiss if token=="coad2qres" & page=="index"

//Korrektur des automatischen Ersetzens von fehlenden Werten mit 0 
replace verwdauer=. if  allmiss

list token allmiss seiteneing verwdauer allmiss if token=="coad2qres" & page=="index"


*________Anzahl der Besucher pro Seite___________
bysort seitennr: gen visitor= _N
label var visitor "Anzahl der Besucher pro Seite (ohne doppelte Besuche)"

*________Anzahl der Abbrecher pro Seite___________
bysort seitennr lastpage: egen abbrecher= count(participant_id) if seitennr==lastpage
label var abbrecher "Anzahl der Abbrecher pro Seite (mit lastpage)"

bysort seitennr: egen dropout= max(abbrecher)
label var dropout "Anzahl der Abbrecher pro Seite (mit lastpage) [Konstante]"

*________Abbruchquote_____________________________
bysort seitennr: gen dropoutrate= dropout/visitor
label var dropoutrate "Abbruchquote (Anz. Abbrecher im Verhältn. zu Seitenbesucher)"

*________Anzahl der besuchten Seiten pro Befragten___________
bysort participant_id: gen anzseiten= _N 
label var anzseiten "Anzahl der besuchten Seiten pro Befragten"

*________Durchschnittliche Bearbeitungsdauer___________
egen dauer_mn=mean(verwdauer)
label var dauer_mn "Verweildauer: arithmetisches Mittel"

egen dauer_med=median(verwdauer)
label var dauer_med "Verweildauer: Median"

egen dauer_min=min(verwdauer)
label var dauer_min "Verweildauer: Minimum"

egen dauer_max=max(verwdauer)
label var dauer_max "Verweildauer: Maximum"

egen dauer_sd=sd(verwdauer)
label var dauer_sd "Verweildauer: Standardabweichung"


*_______________________________________________________________
log using "${workdir}matrix_exp\results\sid-corona_abbrecher.smcl", replace 

*******************************************************************************
********************* Auswertungen aggregierter Datensatz**********************

*________Anzahl der Abbrecher und Abbruchquote pro Seite___________
table page, c(n abbrecher mean dropoutrate n dropoutrate) format(%9.4f)
//bysort page: tab dropoutrate

*________Seitenverweildauer pro Seite____________________
table page, c(mean verwdauer med verwdauer sd verwdauer n verwdauer) format(%6.2f)

tabstat verwdauer, statistics(mean median min max sd n) format(%10.2f)
//tab1 dauer_mn dauer_med dauer_min dauer_max dauer_sd

log close


*******************************************************************************
*******************************************************************************
*________Datensatz umwandeln: breites Format____
// jede Befragte eine Zeile, jede Seite eine Variable,  Verweildauer in den Zellen
*________überflüssige Variablen löschen___________
drop seiteneing page allmiss abbrecher visitor dropout dropoutrate
rename verwdauer p

reshape wide p visit, i(participant_id) j(seitennr)


*________gesamte Bearbeitungsdauer / Verweildauer pro Befragten________
egen dauer=rowtotal(p0-p92)
label var dauer "gesamte Bearbeitungsdauer"

order participant_id token dauer maxpage lastpage anzseiten dauer_mn dauer_med dauer_min dauer_max dauer_sd


*________Variablen beschriften______________________
*_______ [1] Seiten (Verweildauern mit page-ID)
label var p0 "Verweildauer auf index (in Sekunden)"
label var p1 "Verweildauer auf offer (in Sekunden)"
label var p2 "Verweildauer auf A_17 (in Sekunden)"
label var p3 "Verweildauer auf CO_1 (in Sekunden)"
label var p4 "Verweildauer auf D1_13 (in Sekunden)"
label var p5 "Verweildauer auf N_4 (in Sekunden)"
label var p6 "Verweildauer auf CO_2 (in Sekunden)"
label var p7 "Verweildauer auf N_9b (in Sekunden)"
label var p8 "Verweildauer auf CO_3 (in Sekunden)"
label var p9 "Verweildauer auf CO_4 (in Sekunden)"
label var p10 "Verweildauer auf D2_21 (in Sekunden)"
label var p11 "Verweildauer auf CO_5 (in Sekunden)"
label var p12 "Verweildauer auf CO_6 (in Sekunden)"
label var p13 "Verweildauer auf A_23 (in Sekunden)"
label var p14 "Verweildauer auf A_24 (in Sekunden)"
label var p15 "Verweildauer auf A_25 (in Sekunden)"
label var p16 "Verweildauer auf A_27 (in Sekunden)"
label var p17 "Verweildauer auf A_28 (in Sekunden)"
label var p18 "Verweildauer auf A_49a (in Sekunden)"
label var p19 "Verweildauer auf D2_5 (in Sekunden)"
label var p20 "Verweildauer auf D2_18 (in Sekunden)"
label var p21 "Verweildauer auf D2_19 (in Sekunden)"
label var p22 "Verweildauer auf CO_18 (in Sekunden)"
label var p23 "Verweildauer auf A_51b (in Sekunden)"
label var p24 "Verweildauer auf D2_11 (in Sekunden)"
label var p25 "Verweildauer auf D2_13 (in Sekunden)"
label var p26 "Verweildauer auf CO_7 (in Sekunden)"
label var p27 "Verweildauer auf N_9 (in Sekunden)"
label var p28 "Verweildauer auf N_10a (in Sekunden)"
label var p29 "Verweildauer auf N_10b (in Sekunden)"
label var p30 "Verweildauer auf A_22 (in Sekunden)"
label var p31 "Verweildauer auf A_38 (in Sekunden)"
label var p32 "Verweildauer auf A_41 (in Sekunden)"
label var p33 "Verweildauer auf A_1 (in Sekunden)"
label var p34 "Verweildauer auf A_5 (in Sekunden)"
label var p35 "Verweildauer auf A_34 (in Sekunden)"
label var p36 "Verweildauer auf A_32 (in Sekunden)"
label var p37 "Verweildauer auf A_9b (in Sekunden)"
label var p38 "Verweildauer auf A_10 (in Sekunden)"
label var p39 "Verweildauer auf A_12a (in Sekunden)"
label var p40 "Verweildauer auf A_11 (in Sekunden)"
label var p41 "Verweildauer auf A_12 (in Sekunden)"
label var p42 "Verweildauer auf C1_1 (in Sekunden)"
label var p43 "Verweildauer auf C1_2 (in Sekunden)"
label var p44 "Verweildauer auf C1_6 (in Sekunden)"
label var p45 "Verweildauer auf A_15 (in Sekunden)"
label var p46 "Verweildauer auf C2_0 (in Sekunden)"
label var p47 "Verweildauer auf CO_21 (in Sekunden)"
label var p48 "Verweildauer auf D3_23 (in Sekunden)"
label var p49 "Verweildauer auf D1_27 (in Sekunden)"
label var p50 "Verweildauer auf D1_28 (in Sekunden)"
label var p51 "Verweildauer auf B1_2 (in Sekunden)"
label var p52 "Verweildauer auf D1_24 (in Sekunden)"
label var p53 "Verweildauer auf D1_25 (in Sekunden)"
label var p54 "Verweildauer auf CO_19 (in Sekunden)"
label var p55 "Verweildauer auf A_42 (in Sekunden)"
label var p56 "Verweildauer auf D3_19 (in Sekunden)"
label var p57 "Verweildauer auf CO_8 (in Sekunden)"
label var p58 "Verweildauer auf CO_9 (in Sekunden)"
label var p59 "Verweildauer auf CO_9a1 (in Sekunden)"
label var p60 "Verweildauer auf CO_9a (in Sekunden)"
label var p61 "Verweildauer auf CO_24 (in Sekunden)"
label var p62 "Verweildauer auf D3_13 (in Sekunden)"
label var p63 "Verweildauer auf D3_6 (in Sekunden)"
label var p64 "Verweildauer auf CO_20 (in Sekunden)"
label var p65 "Verweildauer auf CO_22 (in Sekunden)"
label var p66 "Verweildauer auf CO_23 (in Sekunden)"
label var p67 "Verweildauer auf D3_8 (in Sekunden)"
label var p68 "Verweildauer auf D3_9 (in Sekunden)"
label var p69 "Verweildauer auf D3_11 (in Sekunden)"
label var p70 "Verweildauer auf B2_7 (in Sekunden)"
label var p71 "Verweildauer auf A_56a (in Sekunden)"
label var p72 "Verweildauer auf A_56 (in Sekunden)"
label var p73 "Verweildauer auf A_53 (in Sekunden)"
label var p74 "Verweildauer auf D3_2 (in Sekunden)"
label var p75 "Verweildauer auf CO_10 (in Sekunden)"
label var p76 "Verweildauer auf N_16 (in Sekunden)"
label var p77 "Verweildauer auf B2_5 (in Sekunden)"
label var p78 "Verweildauer auf D3_22 (in Sekunden)"
label var p79 "Verweildauer auf A_16 (in Sekunden)"
label var p80 "Verweildauer auf A_54 (in Sekunden)"
label var p81 "Verweildauer auf A_55 (in Sekunden)"
label var p82 "Verweildauer auf F1_15 (in Sekunden)"
label var p83 "Verweildauer auf F1_18 (in Sekunden)"
label var p84 "Verweildauer auf CO_11 (in Sekunden)"
label var p85 "Verweildauer auf CO_12 (in Sekunden)"
label var p86 "Verweildauer auf CO_13 (in Sekunden)"
label var p87 "Verweildauer auf CO_14 (in Sekunden)"
label var p88 "Verweildauer auf CO_16 (in Sekunden)"
label var p89 "Verweildauer auf CO_17 (in Sekunden)"
label var p90 "Verweildauer auf D1_20 (in Sekunden)"
label var p91 "Verweildauer auf A_57 (in Sekunden)"
label var p92 "Verweildauer auf end (in Sekunden)"

label define maxpagelb 0 "index" 1 "offer" 2 "A_17" 3 "CO_1" 4 "D1_13" 5 "N_4" 6 "CO_2" 7 "N_9b" 8 "CO_3" 9 "CO_4" 10 "D2_21" 11 "CO_5" 12 "CO_6" 13 "A_23" 14 "A_24" 15 "A_25" 16 "A_27" 17 "A_28" 18 "A_49a" 19 "D2_5" 20 "D2_18" 21 "D2_19" 22 "CO_18" 23 "A_51b" 24 "D2_11" 25 "D2_13" 26 "CO_7" 27 "N_9" 28 "N_10a" 29 "N_10b" 30 "A_22" 31 "A_38" 32 "A_41" 33 "A_1" 34 "A_5" 35 "A_34" 36 "A_32" 37 "A_9b" 38 "A_10" 39 "A_12a" 40 "A_11" 41 "A_12" 42 "C1_1" 43 "C1_2" 44 "C1_6" 45 "A_15" 46 "C2_0" 47 "CO_21" 48 "D3_23" 49 "D1_27" 50 "D1_28" 51 "B1_2" 52 "D1_24" 53 "D1_25" 54 "CO_19" 55 "A_42" 56 "D3_19" 57 "CO_8" 58 "CO_9" 59 "CO_9a1" 60 "CO_9a" 61 "CO_24" 62 "D3_13" 63 "D3_6" 64 "CO_20" 65 "CO_22" 66 "CO_23" 67 "D3_8" 68 "D3_9" 69 "D3_11" 70 "B2_7" 71 "A_56a" 72 "A_56" 73 "A_53" 74 "D3_2" 75 "CO_10" 76 "N_16" 77 "B2_5" 78 "D3_22" 79 "A_16" 80 "A_54" 81 "A_55" 82 "F1_15" 83 "F1_18" 84 "CO_11" 85 "CO_12" 86 "CO_13" 87 "CO_14" 88 "CO_16" 89 "CO_17" 90 "D1_20" 91 "A_57" 92 "end"

label val maxpage maxpagelb

// Befragtenspezifischer Mittelwert und Median der Verweildauer
egen speed_med=rowmedian(p0-p92)
egen speed_mn=rowmean(p0-p92)
label var speed_med "mittlere Seitenverweildauer (per resp.)"
label var speed_mn "durchschnittliche Seitenverweildauer (per resp.)"


*___________Datensatz speichern _______________
save "${data}history_collapsed.dta", replace