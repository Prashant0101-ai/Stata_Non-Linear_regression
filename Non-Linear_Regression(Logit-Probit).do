sysuse nlsw88, clear

*Description and summarize data
describe
summarize

*Explore the union variable
tab union

*Plot the union variable against age
tw (sc union age)
tw (sc union age) (lpoly union age)

*Logit regression model - simple
logit union age
predict phat
tw (sc union age) (sc phat age)
tw (fn y = logistic(.0085532*x+ -1.458568), range(-1000 1000) )

*Logit regression model - multiple
logit union age wage married collgrad 

*Marginals effects
margins, dydx(_all) 
margins, dydx(married) at(age==40 collgrad == 1 wage == 30) 

*Classification table
estat classification

*Table of regressions
reg union age wage married collgrad, robust
estimates store a1
logit union age wage married collgrad 
margins, dydx(_all)  post
estimates store a2
probit union age wage married collgrad
margins, dydx(_all)  post
estimates store a3

esttab a1 a2 a3 , b(3) se(3) star compress nogap s(N r2)  mtitles("LPM" "Logit" "Probit")

*Latent variable simulation
clear
set obs 1000
set seed 12345
gen x = rnormal()
su
kdensity x
gen e = rnormal()
gen ystar = 4*x + 1*e
gen y = (ystar>0)
tab y
probit y x

