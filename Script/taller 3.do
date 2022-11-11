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
local tipo=1
foreach i in $D{
	forvalues t=0(1)1{
		local fila=1
		foreach j in $X{
			di "`j' en periodo `t' con tratamiento `i'"
			qui ttest `j' if post==`t' & Tipo==`tipo', by(`i')
			scalar p1=r(mu_2)/1000
			scalar p2=r(mu_1)/1000
			mat balanceo_muestral_`i'_t`t'[`fila',1]= (r(mu_2), r(mu_1), r(mu_2)-r(mu_1), r(p))
			local fila=`fila'+1
		}
		mat balanceo_muestral_`i'_t`t'[3,1]=(p1, p2, p1-p2)
		frmttable using "$out\Punto_1_a_iii.doc", s(balanceo_muestral_`i'_t`t') sd(3) ///
													 rt("Distancia centro medico"\"Estrato"\ ///
														"Poblacion del municipio") ///
													 t("Tabla 1.`tabla' - Balanceo Muestral grupo `grupo' en periodo `t'") ///
													 n("*** p<0.01, ** p<0.05, * p<0.1" "Poblacion en miles") `option'
		local tabla=`tabla'+1
		local option addtable
	}
	local grupo=2
	local tipo=2
}


**v.

* Grupo 1

qui reg uso post##D_s if Tipo==1, vce(cluster id_mun)
outreg2 using "${out}\\Punto_1_a_v.doc", replace ctitle("Grupo 1")

qui reg uso post##D_pa if Tipo==2, vce(cluster id_mun)
outreg2 using "${out}\\Punto_1_a_v.doc", ctitle("Grupo 2")

qui reg uso post##D_po, vce(cluster id_mun)
outreg2 using "${out}\\Punto_1_a_v.doc", label ctitle("Efecto combinado") ///
        title("Tabla 1.5 - Efecto de tratamiento efectivo")



//B

*ii.

global P P_s P_pa

forvalues t=0(1)1{
	foreach i in $P{
	mat balanceo_muestral_`i'_t`t'=J(3,4,.)
	mat rownames balanceo_muestral_`i'_t`t'= "distancia" "estrato" "pob_rural"
	mat colnames balanceo_muestral_`i'_t`t'= "Y1_mean" "Y0_mean" "Y1-Y0" "p-value"
	}
}


local tabla=6
local option replace
local grupo=1
local tipo=1
foreach i in $P{
	forvalues t=0(1)1{
		local fila=1
		foreach j in $X{
			di "`j' en periodo `t' con tratamiento `i'"
			qui ttest `j' if post==`t' & Tipo==`tipo', by(`i')
			scalar p1=r(mu_2)/1000
			scalar p2=r(mu_1)/1000
			mat balanceo_muestral_`i'_t`t'[`fila',1]= (r(mu_2), r(mu_1), r(mu_2)-r(mu_1), r(p))
			local fila=`fila'+1
		}
		mat balanceo_muestral_`i'_t`t'[3,1]=(p1, p2, p1-p2)
		frmttable using "$out\Punto_1_b_ii.doc", s(balanceo_muestral_`i'_t`t') sd(3) ///
													 rt("Distancia centro medico"\"Estrato"\ ///
														"Poblacion del municipio") ///
													 t("Tabla 1.`tabla' - Balanceo Muestral grupo `grupo' en periodo `t'") ///
													 n("*** p<0.01, ** p<0.05, * p<0.1" "Poblacion en miles") `option'
		local tabla=`tabla'+1
		local option addtable
	}
	local grupo=2
	local tipo=2
}

*iii.

qui reg uso post##P_s if Tipo==1, vce(cluster id_mun)
outreg2 using "${out}\\Punto_1_b_iii.doc", replace ctitle("Grupo 1")

qui reg uso post##P_pa if Tipo==2, vce(cluster id_mun)
outreg2 using "${out}\\Punto_1_b_iii.doc", ctitle("Grupo 2")

qui reg uso post##P_po, vce(cluster id_mun)
outreg2 using "${out}\\Punto_1_b_iii.doc", label ctitle("Efecto combinado") ///
		title("Tabla 1.10 - Efecto de asignacion a tratamiento")

//C

**iii.

* Primera etapa

gen t_p_s = post*P_s
gen t_p_pa = post*P_pa
gen t_p_po = post*P_po

qui reg D_s post t_p_s if Tipo==1, vce(cluster id_mun)
outreg2 using "${out}\\Punto_1_c_iii_primera_etapa.doc", replace ctitle("Grupo 1")

qui reg D_pa post t_p_pa if Tipo==2
outreg2 using "${out}\\Punto_1_c_iii_primera_etapa.doc", ctitle("Grupo 2")

qui reg D_po post t_p_po
outreg2 using "${out}\\Punto_1_c_iii_primera_etapa.doc", label ctitle("Efecto combinado") ///
														 title("Tabla 1.11 - Primera Etapa")
					 													 
* Forma reducida

qui reg uso post##P_s if Tipo==1
outreg2 using "${out}\\Punto_1_c_iii_forma_reducida.doc", replace ctitle("Grupo 1")

qui reg uso post##P_pa if Tipo==2
outreg2 using "${out}\\Punto_1_c_iii_forma_reducida.doc", ctitle("Grupo 2")

qui reg uso post##P_po
outreg2 using "${out}\\Punto_1_c_iii_forma_reducida.doc", label ctitle("Efecto combinado") ///
														  title("Tabla 1.12 - Forma Reducida")

* Segunda etapa

qui xtivreg uso (D_s = P_s) if Tipo==1, re
outreg2 using "${out}\\Punto_1_c_iii_segunda_etapa.doc", replace ctitle("Grupo 1")

qui xtivreg uso (D_pa = P_pa) if Tipo==2, re
outreg2 using "${out}\\Punto_1_c_iii_segunda_etapa.doc", ctitle("Grupo 2")

qui xtivreg uso (D_po = P_po), re
outreg2 using "${out}\\Punto_1_c_iii_segunda_etapa.doc", label ctitle("Efecto combinado") ///
														 title("Tabla 1.13 - Segunda Etapa")

//D

*iv.

qui reg uso post##sexo##P_s if Tipo==1, vce(cluster id_mun)
outreg2 using "${out}\\Punto_1_d_iv.doc", replace ctitle("Grupo 1")

qui reg uso post##sexo##P_pa if Tipo==2, vce(cluster id_mun)
outreg2 using "${out}\\Punto_1_d_iv.doc", ctitle("Grupo 2")

qui reg uso post##sexo##P_po, vce(cluster id_mun)
outreg2 using "${out}\\Punto_1_d_iv.doc", label ctitle("Efecto combinado") ///
		title("Tabla 1.14 - Efecto del sexo del encuestador")





