
clear
local units = 30
local start = 1
local end   = 60

local time = `end' - `start' + 1
local obsv = `units' * `time'
set obs `obsv'

egen id	   = seq(), b(`time')  
egen t 	   = seq(), f(`start') t(`end') 	

sort  id t
xtset id t

lab var id "Panel variable"
lab var t  "Time  variable"

set seed 13082021

cap drop Y
cap drop D
cap drop cohort
cap drop effect
cap drop timing

gen Y 	   = 0		// outcome variable	
gen D 	   = 0		// intervention variable
gen cohort = .  	// total treatment variables
gen effect = .		// treatment effect size
gen timing = .		// when the treatment happens for each cohort


levelsof id, local(lvls)
foreach x of local lvls {
	local chrt = runiformint(0,5)	
	replace cohort = `chrt' if id==`x'
}


levelsof cohort , local(lvls)  //  let all cohorts be treated for now
foreach x of local lvls {
	
	// (a) effect
	
	local eff = runiformint(2,10)
		replace effect = `eff' if cohort==`x'
		
	// (b) timing	
	
	local timing = runiformint(`start' + 5,`end' - 5)	
	replace timing = `timing' if cohort==`x'
		replace D = 1 if cohort==`x' & t>= `timing' 
}

replace Y = id + t + cond(D==1, effect * (t - timing), 0)
