**** Matrix-Experiment: Corona-Befragung 2021/ Überbrückungshilfe
**** Seite A56/ A56a (Zeitbudget)
**** Seite D3_6
**** Auswertungen
*********************************************************************
*_______________ Überbrückungshilfe (SiD-Corona 2021)___________
global version "2021-04-21"
global workdir "P:\Zofar\0_matrix_exp\"	
global orig "P:\Zofar\SiD\SiD-Corona-2021\orig\\${version}\"
global data "${workdir}data\"
global results "${workdir}results\"


use "${data}Ueb_matrix-exp.dta", clear
cd "${results}"
cap log close

*______deskriptive Statistik___________
// Teilnehmer insgesamt
// Verteilung Zufallszuteilung 
// Mobilnutzer


// Balkendiagramm zeitmiss nach view_a56


// histogramm A56_dauer (nach view_a56)


// box plots der Antwortzeiten
graph hbox A56_dauer, over(conview) nooutsides ///
	title("Bearbeitungsdauer von A_56 nach Ansicht") ///
	note("Überbrückungshilfe") ///
	ytitle("Bearbeitungszeit in Minuten", size(small)) ///
	ylabel( , labsize(vsmall)) 
	

graph hbox sum_zeit_sem1 sum_zeit_sem2, over(conview) nooutsides ///
	title("Antworten zum Zeitbudget nach Ansicht") ///
	note("Überbrückungshilfe") ///
	ylabel( , labsize(vsmall)) legend(rows(2) size(tiny))
	
	
log using oMatEx-Ueb_results_`: di %tdCY-N-D daily("$S_DATE", "DMY")', replace
***************************************************************************
** Projekt/ Studie: prod_ueberbrueckungshilfe
** Zweck: Auswertung des Experiments zur Darstellung von offenen Matrizen
***************************************************************************
** Beschreibung Experiment:
** Erhebung der Verwendung von Stunden auf verschiedene Aktivitäten im aktuellen (bzw. letzten) Semester
**** zlvwo (zlvwo2): Lehrveranstaltungen
**** zseswo (zseswo2): Selbststudium
**** zerwo (zerwo2): Erwerbstätigkeit
**** zcarwo (zcarwo2): Pflege von Verwandten/Bekannten
**** zchiwo (zchiwo2): Kinderbetreuung
// "im letzten Semester" nur sichtbar, wenn HS-Semester (ssemhs)>1

** verschiedene Ansichten der offenen Matrix:
**** Seite A56 (Seitennr.: 79): Matrix / Carousel
**** Seite A56a (Seitennr.: 82): scroll down, zeilenweise
**** Seite A56b (Seitennr.: 81): Carousel spaltenweise
**** Seite A56c (Seitennr.: 80): scroll down, spaltenweise
**** mobile: Bildschirmbreite <768 
**** view_a56: Seitendarstellung nach Funktionalität: 0=Matrix-Ansicht, 1= Carousel, 2=scroll down
**** context_a56: Seitendarstellung nach Kontext: Gruppen: 0=Matrix, 1= zeilenweise, 2= spaltenweise 
**** conview_a56: Seitendarstellung unterschieden nach allen Gruppen: 0=Matrix, 1= Carousel, zeilenweise , 2= scroll down, zeilenweise, 3= Carousel, spaltenweise , 4= scroll down, spaltenweise


** [1.] für Befragungsabbruch:
**** a56max: maximaler Seitenfortschritt, 0= mind. bis 79, 1= 79 (A_56/Matrix/Carousel), 80 (A_56c/scroll down, spaltenweise), 81 (A_56b/ Carousel spaltenweise) oder 82 (A_56a/scroll down, zeilenweise) 
**** a56last: Seitenabbruch auf A_56/A_56a/A_56b/A_56c, 0= mind. bis 79, 1= Abbruch auf Seite 79 (A_56), 80 (A_56c), 81 (A_56b) oder 82 (A_56a) 
**** a56a_last: A56a als letzte Seite
**** a56a_max: A56a als maximale Seite
**** a56b_last: A56 als letzte Seite
**** a56b_max: A56 als maximale Seite

** [2.] für Item-Nonresponse:
****  zeitmiss: Anzahl der Missing-Werte bei den Variablen zlvwo - zchiwo (0-10) (wenn HS-Semester> 1 und Kinder='ja')
****  zeit1miss: Anzahl der Missing-Werte bei den Variablen zlvwo - zchiwo (nur 'dieses Semester')
****  zeit2miss: Anzahl der Missing-Werte bei den Variablen zlvwo2 - zchiwo2 (nur 'letztes Semester')
****  a56miss: Missing-Vorkommen dichotom, 0= keine Missings, 1=mind. 1 Missing für dieses und letztes Semester (zlvwo-zchiwo, zlvwo2-zchiwo2)
****  zeitmiss_pat: Item-Nonresponse nach Items, zur Kontrolle von Mustern 
****  --> 0= keine Missings, 1=Missing auf erstes Item, 2=Missing auf zweites Item…
****  zeitmiss_pat2: Item-Nonresponse nach Items, zur Kontrolle von Mustern (ohne 'keine Missings') 
****  --> 1=Missing auf erstes Item, 2=Missing auf zweites Item…
****  m2_zeitmiss: Anzahl Missing-Werte mit HS>1 (zwei Spalten), ohne Kinder (0-8) 


** [3.] für Bearbeitungszeit/ Verweildauer
**** p79: Seitenverweildauer auf p79 (A_56, Matrix-Ansicht/ Carousel-Ansicht)
**** p80: Seitenverweildauer auf p80 (A_56c, scroll down, spaltenweise)
**** p81: Seitenverweildauer auf p81 (A_56b, Carousel spaltenweise)
**** p82: Seitenverweildauer auf p82 (A_56a, scroll down, zeilenweise)
**** A56_dauer: Seitenverweildauer zusammengefasst von p79 bis p82


** ggf. Kontrollvariablen
**** vd1_20: Selbsteinschätzung digitaler Kompetenz
**** pbigintro, pbigextro, pbigtraum, pbigkrit, pbiggenau, pbigfaul, pbigruh, pbignerv, pbigkrea, pbignoku: Big Five
**** digflehr1 - digflehr6
**** pswskill, pswkraft, pswaufg: Selbstwirksamkeitserwartungen

** offene Matrix (Finanzen) --> nach Missing kontrollieren
**** feinelto1/ feinelto2
**** feinjobo1/ feinjobo2
**** feinbafo1/ feinbafo2
**** feinkredo1/ feinkredo2
**** feinandq1/ feinandq2


*________________________________________________________________
*________________ [0.] deskriptive Statistik ________________________
* Verteilung Zufallsvariable und Bildschirmbreite
tab split_zeit mobile_a56 


* Verteilung Antworten
tab1 split_zeit dkinja 


* Verteilung Hochschulsemester
tabstat ssemhs, statistics(n mean med sd min max) format(%9.2f)


* Verteilungen Zeitbudget
tabstat zlvwo zlvwo2 zseswo zseswo2 zerwo zerwo2 zcarwo zcarwo2 zchiwo zchiwo2, statistics(n mean med sd min max) format(%9.2f)


* Verteilung der Seitenansicht
table view_a56, contents(mean A56_dauer n A56_dauer) format(%9.2f)

*________________________________________________________________
*________________ [1.] Befragungsabbruch ________________________
// zentrale Frage: Hängt der Abbruch des Fragebogens mit der Darstellung zusammen?
// Befragungsabbruch nach 1. maxpage und nach 2. lastpage

*___Befragungsabbruch auf Seiten A56-A56c nach maxpage
tab a56max mobile_a56, col exp V nokey chi2
 
*___Befragungsabbruch auf Seiten A56-A56c nach lastpage
tab a56last mobile_a56, col exp V nokey chi2


*__________________________________
*___Befragungsabbruch auf Seiten A_56-A_56c nach maxpage mit Ansicht
tab view_a56 a56max, col exp V nokey chi2


*___Befragungsabbruch auf Seiten A_56-A_56c nach maxpage mit Kontext
tab context_a56 a56max, col exp V nokey chi2


*___Befragungsabbruch auf Seiten A_56-A_56c nach maxpage mit Ansicht- und Kontextgruppen
tab conview_a56 a56max, col exp V nokey chi2



*________________________________________________________________
*________________ [2.] Item-Nonresponse _________________________
// Fragen: Gibt es Unterschiede der Häufigkeit von Item-Nonresponse zwischen den Ansichten?
// Gibt es nonresponse-Muster je nach Bildschirmansicht (z.B. durch satisficing oder Unverständnis des Carousels)?
*_____DARSTELLUNG
*--- Anzahl von Item-Nonresponse (-9990) 
*___Anzahl der fehlenden Antworten (zwei Spalten, mit Kindern)
tab zeitmiss view_a56, exp V nokey
reg zeitmiss i.view_a56

reg zeitmiss i.view_a56 vd1_20

*_____KONTEXT
*--- Anzahl von Item-Nonresponse (-9990) 
*___Anzahl der fehlenden Antworten (zwei Spalten, mit Kindern)
tab zeitmiss context_a56, exp V nokey
reg zeitmiss i.context_a56

reg zeitmiss i.context_a56 vd1_20


*_____KONTEXT & DARSTELLUNG
*--- Anzahl von Item-Nonresponse (-9990) 
*___Anzahl der fehlenden Antworten (zwei Spalten, mit Kindern)
tab zeitmiss conview_a56, exp V nokey
reg zeitmiss i.conview_a56

reg zeitmiss i.conview_a56 vd1_20


*___Anzahl der fehlenden Antworten (zwei Spalten, ohne Kinderbetreuung)
tab m2_zeitmiss view_a56, exp V nokey
reg m2_zeitmiss i.view_a56



*___Anzahl der fehlenden Antworten auf den ersten Items (zlvwo, zseswo, zerwo, zcarwo, zchiwo)
tab zeit1miss view_a56, col exp V nokey
// ein großer Teil im Carousel hat 4 Missing-Werte (n=988) --> deutet darauf hin, dass im Carousel nicht weiter geklickt wurde, sondern die Seite verlassen wurde
// aber: noch mehr Personen (n=1.768) haben im Carousel mind. 1 mal weiter geklickt (mit 3 Missing-Werte, also zwei gültigen Werten) 

ologit zeit1miss i.view_a56

*ktau  zeit1miss view_a56
*spearman zeit1miss view_a56

/*
*___Anzahl der fehlenden Antworten auf den Items in zweiter Spalte (zlvwo2, zseswo2, zerwo2, zcarwo2, zchiwo2)
// werden nur eingeblendet wenn ssemhs>1 
tab zeit2miss view_a56, col exp V nokey
ktau  zeit2miss view_a56
spearman zeit2miss view_a56
*/

*--- Vorhandensein von Item-Nonresponse (-9990) 
// sowohl dieses Semester, als auch letztes Semester
tab a56miss view_a56, col exp V nokey


*---  Muster von Item-Nonresponse (-9990) 
// Muster bei Missing-Vorkommen nach Ansicht
// Missing sowohl auf "dieses Semester"-Items als auch auf "letztes Semester"-Items
// keine Missings (=0) eingeschlossen
tab zeitmiss_pat view_a56, col exp V nokey

*** Muster von Item-Nonresponse (-9990) 
// Muster bei Missing-Vorkommen nach Ansicht
// Missing sowohl auf "dieses Semester"-Items als auch auf "letztes Semester"-Items
// ohne keine Missings (=0)
tab zeitmiss_pat2 view_a56, col exp V nokey
spearman zeitmiss_pat2 view_a56
// Erwartungswerte liegen in Carousel-Ansicht bei Item2 und Item3 weit über dem beobachteten Wert --> Carousel nicht Auslöser für Item-Nonresponse?



*To Do: Balkendiagramm erstellen
*graph bar (count), over(zeitmiss_pat) over(view_a56) yla(, ang(ha)) bargap(-60)
*graph bar (count), over(zeitmiss_pat2) over(view_a56) yla(, ang(ha)) asyvars
*graph hbar (percent) zeitmiss_pat2 , over(view_a56)


*___________________________________________________________________
*________________ [3.] Verweildauer/ Bearbeitungszeit ______________
// Frage: Gibt es Unterschiede bei der Länge der Beantwortung der Fragen?

*-------------- Mittelwertvergleich zwischen Carousel vs. Matrix-Ansicht
*____ Bearbeitungsdauer (Matrix vs. Carousel, ohne scroll down)
ttest p79, by(mobile_a56)
// kein signifikanter Unterschied in der Bearbeitungszeit  
 
** Kontrolle der Missings bei Unterschieden in der Bearbeitungszeit  
ttest p79 if zeit1miss>=3 & zeit2miss>=3 & zeit1miss<=5 & zeit2miss<=5 , by(mobile_a56)
// im Schnitt verweilen Befragte mit Matrixansicht 28 Sekunden kürzer auf der Seite als Befragte mit mobilen Geräten (sign. ***)


*_____________________________________________________
*____ Bearbeitungsdauer der Frage (einschließlich scroll down)
ttest A56_dauer, by(mobile_a56)
// kein signifikanter Unterschied in der Bearbeitungszeit 

** Kontrolle der Missings bei Unterschieden in der Bearbeitungszeit (gar keine Missings vs. Missings vorhanden)
ttest A56_dauer if a56miss==0, by(mobile_a56)
// wenn keine Missings, sind Bearbeitungszeiten bei mobilen Nutzern höher, auf einem Signifikanzniveau von p<0,05
// im Schnitt benötigen Befragte mit mobiler Ansicht 15Sek. länger als Befragte mit Desktop-Ansicht, wenn alle Items beantwortet wurden

** Kontrolle der Missings bei Unterschieden in der Bearbeitungszeit (3 bis 5 Missings) 
ttest A56_dauer if zeit1miss>=3 & zeit2miss>=3 & zeit1miss<=5 & zeit2miss<=5 , by(mobile_a56)
// bei 3-5 Missing-Werten benötigen Mobilnutzer im Schnitt 12 Sek. mehr für die Bearbeitung (sign. *)


*_____________________________________________________
*-------------- Mittelwertvergleich zwischen Ansichten
*____ Bearbeitungsdauer (Matrix, Carousel vs. scroll down)
anova A56_dauer view_a56

table view_a56, contents(mean A56_dauer n A56_dauer) format(%9.2f)


** nur mit Fällen ohne Missings
anova A56_dauer view_a56 if a56miss==0

table view_a56 if a56miss==0, contents(mean A56_dauer n A56_dauer sd A56_dauer) format(%9.2f)


*_____________________________________________________
*-------------- Mittelwertvergleich zwischen Kontexten
*____ Bearbeitungsdauer (Matrix, zeilenweise vs. spaltenweise)
anova A56_dauer context_a56

table context_a56, contents(mean A56_dauer n A56_dauer) format(%9.2f)


** nur mit Fällen ohne Missings
anova A56_dauer context_a56 if a56miss==0

table context_a56 if a56miss==0, contents(mean A56_dauer n A56_dauer sd A56_dauer) format(%9.2f)


*_____________________________________________________
*-------------- Mittelwertvergleich zwischen Kontext- und Ansichtgruppen
*____ Bearbeitungsdauer der Matrixseite 
anova A56_dauer conview_a56

table conview_a56, contents(mean A56_dauer n A56_dauer) format(%9.2f)
// scroll down, zeilenweise benötigt mit Abstand mehr Bearbeitungszeit als alle anderen


** nur mit Fällen ohne Missings
anova conview_a56 view_a56 if a56miss==0

table conview_a56 if a56miss==0, contents(mean A56_dauer n A56_dauer sd A56_dauer) format(%9.2f)


*_______________________________________________________________________
*_______________________________________________________________________
*________________ [4.] unterschiedliche Angaben ________________________
// Frage: Gibt es Unterschiede bei den Antworten?
*-------------- Mittelwertvergleich zwischen mobiler und nicht-mobiler Ansicht
** Lehrveranstaltungen
ttest zlvwo, by(mobile_a56) 
// im Schnitt geben Befragte mit mobiler Ansicht +.8 (Std. pro Woche) an, sign.***

** Selbststudium
ttest zseswo, by(mobile_a56) 
// im Schnitt geben Befragte mit mobiler Ansicht -1.5 an, sign.***

** Erwerbstätigkeit
ttest zerwo, by(mobile_a56) 
// kein Unterschied

** Pflege von Verwandten/Bekannten
ttest zcarwo, by(mobile_a56) 
// im Schnitt geben Befragte mit mobiler Ansicht +.8 an, sign.***

** Kinderbetreuung
ttest zchiwo, by(mobile_a56) 
// im Schnitt geben Befragte mit mobiler Ansicht +12 (Std. pro Woche) an, nicht signifikant



*_____________________________________________________
*-------------- Varianzanalyse zwischen drei Ansichten
** Lehrveranstaltungen
oneway zlvwo view_a56, scheffe
table view_a56, contents(mean zlvwo n zlvwo sd zlvwo) format(%9.2f)


** Selbststudium
oneway zseswo view_a56, scheffe
table view_a56, contents(mean zseswo n zseswo sd zseswo) format(%9.2f)


** Erwerbstätigkeit
oneway zerwo view_a56, scheffe
table view_a56, contents(mean zerwo n zerwo sd zerwo) format(%9.2f)


** Pflege von Verwandten/Bekannten
oneway zcarwo view_a56, scheffe
table view_a56, contents(mean zcarwo n zcarwo sd zcarwo) format(%9.2f)


** Kinderbetreuung
oneway zchiwo view_a56, scheffe 
table view_a56, contents(mean zchiwo n zchiwo sd zchiwo) format(%9.2f)

*________________________________________________
*-------------- Varianzanalyse zwischen drei Kontextgruppen
** Lehrveranstaltungen
oneway zlvwo context_a56, scheffe
table context_a56, contents(mean zlvwo n zlvwo sd zlvwo) format(%9.2f)


** Selbststudium
oneway zseswo context_a56, scheffe
table context_a56, contents(mean zseswo n zseswo sd zseswo) format(%9.2f)


** Erwerbstätigkeit
oneway zerwo context_a56, scheffe
table context_a56, contents(mean zerwo n zerwo sd zerwo) format(%9.2f)


** Pflege von Verwandten/Bekannten
oneway zcarwo context_a56, scheffe
table context_a56, contents(mean zcarwo n zcarwo sd zcarwo) format(%9.2f)


** Kinderbetreuung
oneway zchiwo context_a56, scheffe 
table context_a56, contents(mean zchiwo n zchiwo sd zchiwo) format(%9.2f)



*________________________________________________
*-------------- Varianzanalyse zwischen Ansicht- und Kontextgruppen
** Lehrveranstaltungen
oneway zlvwo conview_a56, scheffe
table conview_a56, contents(mean zlvwo n zlvwo sd zlvwo) format(%9.2f)


** Selbststudium
oneway zseswo conview_a56, scheffe
table conview_a56, contents(mean zseswo n zseswo sd zseswo) format(%9.2f)


** Erwerbstätigkeit
oneway zerwo conview_a56, scheffe
table conview_a56, contents(mean zerwo n zerwo sd zerwo) format(%9.2f)


** Pflege von Verwandten/Bekannten
oneway zcarwo conview_a56, scheffe
table conview_a56, contents(mean zcarwo n zcarwo sd zcarwo) format(%9.2f)


** Kinderbetreuung
oneway zchiwo conview_a56, scheffe 
table conview_a56, contents(mean zchiwo n zchiwo sd zchiwo) format(%9.2f)


log close

// Regression mit Antworten (meaning of context)
// reg zchiwo view_a56 zlvwo zseswo zerwo scarwo

