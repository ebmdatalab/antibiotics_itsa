cd "C:\Users\ajwalker\Documents\GitHub\antibiotics_itsa"
clear

import delimited total_antibiotic_prescribing.csv

gen date =  date(month, "YMD")
format date %td
gen date2=month(date)
gen tm = mofd(date)
format tm %tmMonCCYY

tsset tm
local intervention = ym(2013, 06)

itsa items_per_star_pu i.date2,trperiod(`intervention')
est store full
outreg2 full using itsa_monthly, replace ci dec(2) sideway noaster noparen nonotes
export delimited month _s_items_per_star_pu_pred using "pred_monthly.csv", replace

import delimited pca_totals.csv,clear

format year %ty
tsset year

itsa items_per_starpu, trperiod(2013)
est store full
outreg2 full using itsa_long_term, replace ci dec(2) sideway noaster noparen nonotes
export delimited year _s_items_per_starpu_pred using "pred_long_term.csv", replace

exit, STATA clear
