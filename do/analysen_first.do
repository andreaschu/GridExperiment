**** Matrix-Experiment: Corona-Sonderbefragung 2020
**** Seite A56/ A56a (Zeitbudget)
**** Auswertungen

use "${data}sid-corona_matrix-exp.dta", clear
cd "${results}"
cap log close

*______deskriptive Statistik___________
// Teilnehmer insgesamt
// Verteilung Zufallszuteilung 
// Mobilnutzer


// Balkendiagramm zeitmiss nach view_a56

// box plots der Antwortzeiten
// box plots der missing-angaben

// histogramm A56_dauer (nach view_a56)


log using oMatEx-SiD-Corona_results__`: di %tdCY-N-D daily("$S_DATE", "DMY")', replace
***************************************************************************
** Projekt/ Studie: prod_corona-sid
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
**** Seite A56 (Seitennr.: 72): Matrix / Carousel
**** Seite A56a (Seitennr.: 71): scroll down
**** mobile: Bildschirmbreite <768 
**** view_a56: Ansicht der Seite: 0=Matrix-Ansicht, 1= Carousel, 2=scroll down

** [1.] für Befragungsabbruch:
**** a56max: maximaler Seitenfortschritt, 0= mind. bis 71, 1= 71 (A56a/scroll down) oder 72 (A56/Matrix/Carousel)
**** a56last: Seitenabbruch auf A56/A56a, 0= mind. bis 71, 1= Abbruch auf Seite 71 (A56a) oder 72 (A56) 
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
**** p72: Seitenverweildauer auf p72 (A56, Matrix-Ansicht/ Carousel-Ansicht)
**** p71: Seitenverweildauer auf p71 (A56a, scroll down-Ansicht)
**** A56_dauer: Seitenverweildauer zusammengefasst von p71 und p72


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
* Verteilung Zufallsvariable
tab mobile s_split_zeit1

* Verteilung Antworten
tab1 s_split_zeit1 dkinja 

tabstat ssemhs zlvwo zlvwo2 zseswo zseswo2 zerwo zerwo2 zcarwo zcarwo2 zchiwo zchiwo2, statistics(n mean med sd min max) format(%9.2f)

* Verteilung der Seitenansicht
table view_a56, contents(mean A56_dauer n A56_dauer) format(%9.2f)

*________________________________________________________________
*________________ [1.] Befragungsabbruch ________________________
// zentrale Frage: Hängt der Abbruch des Fragebogens mit der Darstellung zusammen?
// Befragungsabbruch nach 1. maxpage und nach 2. lastpage

*___Befragungsabbruch auf Seiten A56/A56a nach maxpage
tab a56max mobile, col exp V nokey chi2
 
*___Befragungsabbruch auf Seiten A56/A56a nach lastpage
tab a56last mobile, col exp V nokey chi2


*--------- getrennte Berechnungen nach Seiten A56 (scroll down) und A56a (Matrix/ Carousel)
*--- Seite A56a
*___Befragungsabbruch auf Seite A56a nach maxpage
tab a56a_max mobile, col exp V nokey chi2

*___Befragungsabbruch auf Seite A56a nach lastpage
tab a56a_last mobile, col exp V nokey chi2

*--- Seite A56
*___Befragungsabbruch auf Seite A56 nach maxpage
tab a56b_max mobile, col exp V nokey chi2

*___Befragungsabbruch auf Seite A56 nach lastpage
tab a56b_last mobile, col exp V nokey chi2

*___Befragungsabbruch auf Seiten A56/A56a nach maxpage mit Ansicht
tab view_a56 a56max, col exp V nokey chi2



*________________________________________________________________
*________________ [2.] Item-Nonresponse _________________________
// Fragen: Gibt es Unterschiede der Häufigkeit von Item-Nonresponse zwischen den Ansichten?
// Gibt es nonresponse-Muster je nach Bildschirmansicht (z.B. durch satisficing oder Unverständnis des Carousels)?

*--- Anzahl von Item-Nonresponse (-9990) 
*___Anzahl der fehlenden Antworten (zwei Spalten, mit Kindern)
tab zeitmiss view_a56, exp V nokey
reg zeitmiss i.view_a56

reg zeitmiss i.view_a56 vd1_20 A56_dauer


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
*____ Bearbeitungsdauer der Matrixseite (Matrix vs. Carousel, ohne scroll down)
ttest p72, by(mobile)
// im Schnitt verweilen Befragte mit mobiler Ansicht (nur Carousel) 21 Sekunden kürzer auf der Seite 
// als Befragte mit Matrix-Ansicht
// Ergebnis von hohen Missing-Vorkommen beeinflusst --> Kontrolle der Missingwerte
 
 
** Kontrolle der Missings bei Unterschieden in der Bearbeitungszeit  
*ttest p72 if zeit1miss>=3 & zeit2miss>=3 & zeit1miss<=5 & zeit2miss<=5 , by(mobile)
// nur bei 3-5 Missing-Werten gibt es einen starken Unterschied in der Bearbeitungszeit (16 Sek.), sign. ***
// Befragte mit mobiler Ansicht benötigen im Schnitt 16 Sek. länger als mit Desktop-Ansicht

// --> Kontrollieren ob Missing-Vorkommen durch Satisficing erklärt werden kann
// beim Satisficing müssten die Antwortzeiten bei gleicher Anzahl von Missings bei mobilen Geräten kürzer sein als bei Desktop-Ansicht

*____ Bearbeitungsdauer der Matrixseite (einschließlich scroll down)
ttest A56_dauer, by(mobile)
// im Schnitt verweilen Befragte mit mobiler Ansicht 9 Sekunden kürzer auf der Seite als Befragte mit Matrix-Ansicht

** Kontrolle der Missings bei Unterschieden in der Bearbeitungszeit (gar keine Missings vs. Missings vorhanden)
ttest A56_dauer if a56miss==0, by(mobile)
// wenn keine Missings, sind Bearbeitungszeiten bei mobilen Nutzern höher, auf einem Signifikanzniveau von p<0,005
// im Schnitt benötigen Befragte mit mobiler Ansicht 11Sek. länger als Befragte mit Desktop-Ansicht, wenn alle Items beantwortet wurden

** Kontrolle der Missings bei Unterschieden in der Bearbeitungszeit (3 bis 5 Missings) 
*ttest A56_dauer if zeit1miss>=3 & zeit2miss>=3 & zeit1miss<=5 & zeit2miss<=5 , by(mobile)
// nur bei 3-5 Missing-Werten gibt es einen starken Unterschied in der Bearbeitungszeit (15 Sek.), sign. ***

*-------------- Mittelwertvergleich zwischen Ansichten
*____ Bearbeitungsdauer der Matrixseite (Matrix, Carousel vs. scroll down)
anova A56_dauer view_a56

table view_a56, contents(mean A56_dauer n A56_dauer) format(%9.2f)

** nur mit Fällen ohne Missings
anova A56_dauer view_a56 if a56miss==0

table view_a56 if a56miss==0, contents(mean A56_dauer n A56_dauer sd A56_dauer) format(%9.2f)
// Abstand Carousel - Matrix: +16.15
// Abstand Carousel - scroll down: +7.18
// Abstand scroll down - Matrix: +9.03 


*_______________________________________________________________________
*________________ [4.] unterschiedliche Angaben ________________________
// Frage: Gibt es Unterschiede bei den Antworten?
*-------------- Mittelwertvergleich zwischen mobiler und nicht-mobiler Ansicht
** Lehrveranstaltungen
ttest zlvwo, by(mobile) 
// im Schnitt geben Befragte mit mobiler Ansicht +3,2 (Std. pro Woche) an, sign.***
// Überbewertung des Aufwandes für Lehrveranstaltungen ohne Kontext?

** Selbststudium
ttest zseswo, by(mobile) 
// im Schnitt geben Befragte mit mobiler Ansicht -.5 an, sign.*

** Erwerbstätigkeit
ttest zerwo, by(mobile) 
// im Schnitt geben Befragte mit mobiler Ansicht +.8 an, sign.***

** Pflege von Verwandten/Bekannten
ttest zcarwo, by(mobile) 
// im Schnitt geben Befragte mit mobiler Ansicht +.3 an, sign.*

** Kinderbetreuung
ttest zchiwo, by(mobile) 
// im Schnitt geben Befragte mit mobiler Ansicht +14 (Std. pro Woche) an, sign.***
// starker Unterschied, muss erklärt werden (Selektive Auswahl? Benutzen Eltern stärker mobile Geräte zur Beantwortung? Messfehler?)


log close

*_______________________________________________________________________
*________________ [4.] unterschiedliche Angaben ________________________
// Frage: Gibt es Unterschiede bei den Antworten?
*-------------- Varianzanalyse zwischen drei Ansichten
** Lehrveranstaltungen
*anova zlvwo view_a56 
oneway zlvwo view_a56, scheffe
table view_a56, contents(mean zlvwo n zlvwo sd zlvwo) format(%9.2f)


** Selbststudium
*anova zseswo view_a56 
oneway zseswo view_a56, scheffe
table view_a56, contents(mean zseswo n zseswo sd zseswo) format(%9.2f)

** Erwerbstätigkeit
*anova zerwo view_a56
oneway zerwo view_a56, scheffe
table view_a56, contents(mean zerwo n zerwo sd zerwo) format(%9.2f)

** Pflege von Verwandten/Bekannten
*anova zcarwo view_a56
oneway zcarwo view_a56, scheffe
table view_a56, contents(mean zcarwo n zcarwo sd zcarwo) format(%9.2f)

** Kinderbetreuung
*anova zchiwo view_a56 
oneway zchiwo view_a56, scheffe 
table view_a56, contents(mean zchiwo n zchiwo sd zchiwo) format(%9.2f)


// Regression mit Antworten (meaning of context)
// reg zchiwo view_a56 zlvwo zseswo zerwo scarwo

