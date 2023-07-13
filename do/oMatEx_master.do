**** Matrix-Experiment: Corona-Befragung 2021/ Überbrückungshilfe
**** Seite A56/ A56a (Zeitbudget)
**** Seite D3_6
**** Master-do
*********************************************************************
global workdir "P:\Zofar\0_matrix_exp\"	
global data "${workdir}data\"
global results "${workdir}results\"
global do "${workdir}do\"

*_______________ SiD-Corona (SiD-Corona 2020)___________
// Datenaufbereitung SiD-Corona 
do "${do}oMatEx-SiD-Corona_data.do"

save "${data}sid-corona_matrix-exp.dta", replace

*_______________ Überbrückungshilfe (SiD-Corona 2021)___________
// Datenaufbereitung Überbrückungshilfe
do "${do}oMatEx-Ueb_data.do"

save "${data}Ueb_matrix-exp.dta", replace

*_______________ Datensätze mergen _____________________
gen survey= 2
label define surveylb 1 "[1] SiD-Corona" 2 "[2] Überbrückungshilfe", replace
label val survey surveylb

append using "${data}sid-corona_matrix-exp.dta", gen(source) 

replace survey = 1 if source==1


*_______________ Gesamtaufbereitung _____________________
replace mobile_a56 = mobile if survey==1 & mobile_a56==.


*________________________________________________________
*___Summenindex der Variablen zlvwo - zcarwo
drop sum_zeit_sem1 sum_zeit_sem2
egen sum_zeit_sem1= rowtotal(zlvwo zseswo zerwo zcarwo) , missing
label var sum_zeit_sem1 "wöchentliches Zeitbudget in diesem Semester (ohne Kinder)"
egen sum_zeit_sem2= rowtotal(zlvwo2 zseswo2 zerwo2 zcarwo2) , missing
label var sum_zeit_sem2 "wöchentliches Zeitbudget im letzten Semester (ohne Kinder)"


mvdecode sf_a56b sf_a56, mv(-9995=.a \ -9992 =.b \ -9991 =.)


save "${data}oMatEx_merged.dta", replace

*******************************************************************
// gemeinsame Auswertungen
do "${do}oMatEx_analysen.do"
