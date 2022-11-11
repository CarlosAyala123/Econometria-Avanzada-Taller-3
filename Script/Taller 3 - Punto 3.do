clear all
cap log close
set more off
cls 

*Taller econometría
*Ejercicio 3

cd "E:\OneDrive - Universidad de los Andes\Econometría Avanzada\Taller3\punto3"

*1.a 

clear
mat mod_1a = J(1000,1,.)
forvalues i = 1(1)1000{
	set obs 1000
	set seed 1001`i'
	gen es = rnormal(0,1)
	gen x = rnormal(0,1)
	global beta = 10
	gen y = $beta*x + es
	
	quiet reg y x
	
	*intervalo 
	quiet matlist r(table)
	gen inf = r(table)[5,1]
	gen sup = r(table)[6,1]
	
	*entra o no en el intervalo 
	gen clasif = .
	replace clasif = 1 if inf <= $beta & sup >= $beta 
	replace clasif = 0 if clasif ==.
	quiet sum clasif
	
	matrix mod_1a[`i',1] = r(mean)
	
	drop es x y inf sup clasif
}
svmat mod_1a
sum mod_1a

tab mod_1a

* COn hc1
clear
mat mod_1arob = J(1000,1,.)
forvalues i = 1(1)1000{
	set obs 1000
	set seed 1001`i'
	gen es = rnormal(0,1)
	gen x = rnormal(0,1)
	global beta = 10
	gen y = $beta*x + es
	
	quiet reg y x, robust
	
	*intervalo 
	quiet matlist r(table)
	gen inf = r(table)[5,1]
	gen sup = r(table)[6,1]
	
	*entra o no en el intervalo 
	gen clasif = .
	replace clasif = 1 if inf <= $beta & sup >= $beta 
	replace clasif = 0 if clasif ==.
	quiet sum clasif
	
	matrix mod_1arob[`i',1] = r(mean)
	
	drop es x y inf sup clasif
}
svmat mod_1arob
sum mod_1arob

tab mod_1arob

********************************************************************
*1.b 

clear
mat mod_1b = J(10,1,.)
forvalues i = 1(1)10{
	set obs 10
	gen es = rnormal(0,1)
	gen x = rnormal(0,1)
	global beta = 10
	gen y = $beta*x + es
	
	quiet reg y x
	
	*intervalo 
	quiet matlist r(table)
	gen inf = r(table)[5,1]
	gen sup = r(table)[6,1]
	
	*entra o no en el intervalo 
	gen clasif = .
	replace clasif = 1 if inf <= $beta & sup >= $beta 
	replace clasif = 0 if clasif ==.
	quiet sum clasif
	
	matrix mod_1b[`i',1] = r(mean)
	
	drop es x y inf sup clasif
}
svmat mod_1b
sum mod_1b

tab mod_1b

* COn hc1
clear
mat mod_1brob = J(10,1,.)
forvalues i = 1(1)10{
	set obs 10
	gen es = rnormal(0,1)
	gen x = rnormal(0,1)
	global beta = 10
	gen y = $beta*x + es
	
	quiet reg y x, robust
	
	*intervalo 
	quiet matlist r(table)
	gen inf = r(table)[5,1]
	gen sup = r(table)[6,1]
	
	*entra o no en el intervalo 
	gen clasif = .
	replace clasif = 1 if inf <= $beta & sup >= $beta 
	replace clasif = 0 if clasif ==.
	quiet sum clasif
	
	matrix mod_1brob[`i',1] = r(mean)
	
	drop es x y inf sup clasif
}
svmat mod_1brob
sum mod_1brob

tab mod_1brob

******************************************************************
*1.c
* COn hc3
clear
mat mod_1c = J(1000,1,.)
forvalues i = 1(1)1000{
	set obs 1000
	gen es = rnormal(0,1)
	gen x = rnormal(0,1)
	global beta = 10
	gen y = $beta*x + es
	
	quiet reg y x, vce(hc3)
	
	*intervalo 
	quiet matlist r(table)
	gen inf = r(table)[5,1]
	gen sup = r(table)[6,1]
	
	*entra o no en el intervalo 
	gen clasif = .
	replace clasif = 1 if inf <= $beta & sup >= $beta 
	replace clasif = 0 if clasif ==.
	quiet sum clasif
	
	matrix mod_1c[`i',1] = r(mean)
	
	drop es x y inf sup clasif
}
svmat mod_1c
sum mod_1c

tab mod_1c

*****************************************************************************
*2.a
clear
mat mod_2a = J(1000,1,.)
forvalues i = 1(1)1000{
	set obs 1000
	set seed 1001`i'
	gen x = rnormal(0,1)
	gen es = rnormal(0,x^2)
	global beta = 10
	gen y = $beta*x + es
	
	quiet reg y x
	
	*intervalo 
	quiet matlist r(table)
	gen inf = r(table)[5,1]
	gen sup = r(table)[6,1]
	
	*entra o no en el intervalo 
	gen clasif = .
	replace clasif = 1 if inf <= $beta & sup >= $beta 
	replace clasif = 0 if clasif ==.
	quiet sum clasif
	
	matrix mod_2a[`i',1] = r(mean)
	
	drop es x y inf sup clasif
}
svmat mod_2a
sum mod_2a

tab mod_2a

* COn hc1
clear
mat mod_2arob = J(1000,1,.)
forvalues i = 1(1)1000{
	set obs 1000
	set seed 1001`i'
	gen x = rnormal(0,1)
	gen es = rnormal(0,x^2)
	global beta = 10
	gen y = $beta*x + es
	
	quiet reg y x, robust
	
	*intervalo 
	quiet matlist r(table)
	gen inf = r(table)[5,1]
	gen sup = r(table)[6,1]
	
	*entra o no en el intervalo 
	gen clasif = .
	replace clasif = 1 if inf <= $beta & sup >= $beta 
	replace clasif = 0 if clasif ==.
	quiet sum clasif
	
	matrix mod_2arob[`i',1] = r(mean)
	
	drop es x y inf sup clasif
}
svmat mod_2arob
sum mod_2arob

tab mod_2arob


* COn hc3
clear
mat mod_2hc3 = J(1000,1,.)
forvalues i = 1(1)1000{
	set obs 1000
	set seed 1001`i'
	gen x = rnormal(0,1)
	gen es = rnormal(0,x^2)
	global beta = 10
	gen y = $beta*x + es
	
	quiet reg y x, vce(hc3)
	
	*intervalo 
	quiet matlist r(table)
	gen inf = r(table)[5,1]
	gen sup = r(table)[6,1]
	
	*entra o no en el intervalo 
	gen clasif = .
	replace clasif = 1 if inf <= $beta & sup >= $beta 
	replace clasif = 0 if clasif ==.
	quiet sum clasif
	
	matrix mod_2hc3[`i',1] = r(mean)
	
	drop es x y inf sup clasif
}
svmat mod_2hc3
sum mod_2hc3

tab mod_2hc3

*********************************************************************
*2.b
clear
mat mod_2b = J(10,1,.)
forvalues i = 1(1)10{
	set obs 10
	gen x = rnormal(0,1)
	gen es = rnormal(0,x^2)
	global beta = 10
	gen y = $beta*x + es
	
	quiet reg y x
	
	*intervalo 
	quiet matlist r(table)
	gen inf = r(table)[5,1]
	gen sup = r(table)[6,1]
	
	*entra o no en el intervalo 
	gen clasif = .
	replace clasif = 1 if inf <= $beta & sup >= $beta 
	replace clasif = 0 if clasif ==.
	quiet sum clasif
	
	matrix mod_2b[`i',1] = r(mean)
	
	drop es x y inf sup clasif
}
svmat mod_2b
sum mod_2b

tab mod_2b

* COn hc1
clear
mat mod_2brob = J(10,1,.)
forvalues i = 1(1)10{
	set obs 10
	gen x = rnormal(0,1)
	gen es = rnormal(0,x^2)
	global beta = 10
	gen y = $beta*x + es
	
	quiet reg y x, robust
	
	*intervalo 
	quiet matlist r(table)
	gen inf = r(table)[5,1]
	gen sup = r(table)[6,1]
	
	*entra o no en el intervalo 
	gen clasif = .
	replace clasif = 1 if inf <= $beta & sup >= $beta 
	replace clasif = 0 if clasif ==.
	quiet sum clasif
	
	matrix mod_2brob[`i',1] = r(mean)
	
	drop es x y inf sup clasif
}
svmat mod_2brob
sum mod_2brob

tab mod_2brob


* COn hc3
clear
mat mod_2bhc3 = J(10,1,.)
forvalues i = 1(1)10{
	set obs 10
	gen x = rnormal(0,1)
	gen es = rnormal(0,x^2)
	global beta = 10
	gen y = $beta*x + es
	
	quiet reg y x, vce(hc3)
	
	*intervalo 
	quiet matlist r(table)
	gen inf = r(table)[5,1]
	gen sup = r(table)[6,1]
	
	*entra o no en el intervalo 
	gen clasif = .
	replace clasif = 1 if inf <= $beta & sup >= $beta 
	replace clasif = 0 if clasif ==.
	quiet sum clasif
	
	matrix mod_2bhc3[`i',1] = r(mean)
	
	drop es x y inf sup clasif
}
svmat mod_2bhc3
sum mod_2bhc3

tab mod_2bhc3

************************************************************************
*3.a
clear
mat mod_3a = J(100,1,.)
forvalues i = 1(1)100{
	set obs 100
	gen x = rnormal(0,1)
	gen es = rnormal(0,1)
	global beta = 10
	gen y = $beta*x + es
	
	expand 10 
	
	quiet reg y x
	
	*intervalo 
	quiet matlist r(table)
	gen inf = r(table)[5,1]
	gen sup = r(table)[6,1]
	
	*entra o no en el intervalo 
	gen clasif = .
	replace clasif = 1 if inf <= $beta & sup >= $beta 
	replace clasif = 0 if clasif ==.
	quiet sum clasif
	
	matrix mod_3a[`i',1] = r(mean)
	
	drop es x y inf sup clasif
}
svmat mod_3a
sum mod_3a

tab mod_3a

* COn hc1
clear
mat mod_3ahc1 = J(100,1,.)
forvalues i = 1(1)100{
	set obs 100
	gen x = rnormal(0,1)
	gen es = rnormal(0,1)
	global beta = 10
	gen y = $beta*x + es
	
	expand 10 
	
	quiet reg y x, robust
	
	*intervalo 
	quiet matlist r(table)
	gen inf = r(table)[5,1]
	gen sup = r(table)[6,1]
	
	*entra o no en el intervalo 
	gen clasif = .
	replace clasif = 1 if inf <= $beta & sup >= $beta 
	replace clasif = 0 if clasif ==.
	quiet sum clasif
	
	matrix mod_3ahc1[`i',1] = r(mean)
	
	drop es x y inf sup clasif
}
svmat mod_3ahc1
sum mod_3ahc1

tab mod_3ahc1

* COn hc3
clear
mat mod_3ahc3 = J(100,1,.)
forvalues i = 1(1)100{
	set obs 100
	gen x = rnormal(0,1)
	gen es = rnormal(0,1)
	global beta = 10
	gen y = $beta*x + es
	
	expand 10 
	
	quiet reg y x, vce(hc3)
	
	*intervalo 
	quiet matlist r(table)
	gen inf = r(table)[5,1]
	gen sup = r(table)[6,1]
	
	*entra o no en el intervalo 
	gen clasif = .
	replace clasif = 1 if inf <= $beta & sup >= $beta 
	replace clasif = 0 if clasif ==.
	quiet sum clasif
	
	matrix mod_3ahc3[`i',1] = r(mean)
	
	drop es x y inf sup clasif
}
svmat mod_3ahc3
sum mod_3ahc3

tab mod_3ahc3

*con Cluster

clear
mat mod_3aclu = J(100,1,.)
forvalues i = 1(1)100{
	set obs 100
	gen x = rnormal(0,1)
	gen es = rnormal(0,1)
	global beta = 10
	gen y = $beta*x + es
	
	expand 10 
	
	quiet reg y x, cluster(x)
	
	*intervalo 
	quiet matlist r(table)
	gen inf = r(table)[5,1]
	gen sup = r(table)[6,1]
	
	*entra o no en el intervalo 
	gen clasif = .
	replace clasif = 1 if inf <= $beta & sup >= $beta 
	replace clasif = 0 if clasif ==.
	quiet sum clasif
	
	matrix mod_3aclu[`i',1] = r(mean)
	
	drop es x y inf sup clasif
}
svmat mod_3aclu
sum mod_3aclu

tab mod_3aclu


**********************************************************************
*4.a


clear
mat mod_4a = J(1000,1,.)
forvalues i = 1(1)1000{
	set obs 1000
	gen es = rnormal(0,1)
	gen x = rnormal(0,1)
	global beta = 10
	gen y = $beta*x + es
	
	quiet reg y x, vce(bootstrap, rep(100))
	
	*intervalo 
	quiet matlist r(table)
	gen inf = r(table)[5,1]
	gen sup = r(table)[6,1]
	
	*entra o no en el intervalo 
	gen clasif = .
	replace clasif = 1 if inf <= $beta & sup >= $beta 
	replace clasif = 0 if clasif ==.
	quiet sum clasif
	
	matrix mod_4a[`i',1] = r(mean)
	
	drop es x y inf sup clasif
}
svmat mod_4a
sum mod_4a

tab mod_4a


*4.b 

clear
mat mod_4b = J(1000,1,.)
forvalues i = 1(1)1000{
	set obs 1000
	gen x = rnormal(0,1)
	gen es = rnormal(0,x^2)
	global beta = 10
	gen y = $beta*x + es
	
	quiet reg y x, vce(bootstrap, rep(100))
	
	*intervalo 
	quiet matlist r(table)
	gen inf = r(table)[5,1]
	gen sup = r(table)[6,1]
	
	*entra o no en el intervalo 
	gen clasif = .
	replace clasif = 1 if inf <= $beta & sup >= $beta 
	replace clasif = 0 if clasif ==.
	quiet sum clasif
	
	matrix mod_4b[`i',1] = r(mean)
	
	drop es x y inf sup clasif
}
svmat mod_4b
sum mod_4b

tab mod_4b

*4.c 

clear
mat mod_4c = J(100,1,.)
forvalues i = 1(1)100{
	set obs 100
	gen x = rnormal(0,1)
	gen es = rnormal(0,1)
	global beta = 10
	gen y = $beta*x + es
	
	expand 10 
	
	quiet reg y x, vce(bootstrap, rep(100))
	
	*intervalo 
	quiet matlist r(table)
	gen inf = r(table)[5,1]
	gen sup = r(table)[6,1]
	
	*entra o no en el intervalo 
	gen clasif = .
	replace clasif = 1 if inf <= $beta & sup >= $beta 
	replace clasif = 0 if clasif ==.
	quiet sum clasif
	
	matrix mod_4c[`i',1] = r(mean)
	
	drop es x y inf sup clasif
}
svmat mod_4c
sum mod_4c

tab mod_4c














