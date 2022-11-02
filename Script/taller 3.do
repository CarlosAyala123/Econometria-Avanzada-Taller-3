**** Taller 3 - Econometría Avanzada ****

cd "C:\Users\caaya\OneDrive - Universidad de los Andes\universidad\8 semestre\Econometría avanzada\Talleres\Econometria-Avanzada-Taller-3"

clear all
cls 

// Punto 1

gl punto "Punto 1"
gl data "Data\\${punto}"
gl out "Outputs\\${punto}"

***A.

use "${data}\planificación_DID.dta", clear
describe

global X distancia estrato pob_rural
global D D_s D_pa


**iii

forvalues t=0(1)1{
	foreach i in $D{
	mat balanceo_muestral_`i'_t`t'=J(3,4,.)
	mat rownames balanceo_muestral_`i'_t`t'= "distancia" "estrato" "pob_rural"
	mat colnames balanceo_muestral_`i'_t`t'= "Y1_mean" "Y0_mean" "Y1-Y0" "p-value"
	}
}


local tabla=1
local option replace
local grupo=1
foreach i in $D{
	forvalues t=0(1)1{
		local fila=1
		foreach j in $X{
			di "`j' en periodo `t' con tratamiento `i'"
			qui ttest `j' if post==`t', by(`i')
			scalar p1=r(mu_2)/1000
			scalar p2=r(mu_1)/1000
			mat balanceo_muestral_`i'_t`t'[`fila',1]= (r(mu_2), r(mu_1), r(mu_2)-r(mu_1), r(p))
			local fila=`fila'+1
		}
		mat balanceo_muestral_`i'_t`t'[3,1]=(p1, p2, p1-p2)
		frmttable using "$out\punto 1_a_iii.doc", s(balanceo_muestral_`i'_t`t') sd(3) ///
													 rt("Distancia centro medico"\"Estrato"\ ///
														"Poblacion del municipio") ///
													 t("Tabla 1.`tabla' - Balanceo Muestral grupo `grupo' en periodo `t'") ///
													 n("*Poblacion en miles") `option'
		local tabla=`tabla'+1
		local option addtable
	}
	local grupo=2
}


**v.

* Grupo 1

reg uso i.post#i.D_s distancia edad if Tipo==1, r










