*cd C:\Users\ajwalker\Documents\GitHub\jupyter-notebooks\antibiotics
cd "C:\Users\Alex\Documents\Google Drive\Github sync\antibiotics\ITSA"
clear

import delimited total_antibiotic_prescribing.csv
gen date =  date(month, "YMD")
format date %td

gen date2=month(date)
gen tm = mofd(date)
format tm %tmMonCCYY

tsset tm
local intervention = ym(2013, 06)

itsa items_per_star_pu i.date2, ///
trperiod(`intervention') figure(subtitle("") note("") msymbol(X i) ///
xtitle(Date) ytitle(items/1000 STAR-PU) ylabel(,format(%14.0fc)) ///
xlabel(#8,format(%tmMonCCYY)) graphregion(c(white)))
export delimited month _s_items_per_star_pu_pred using "pred_monthly.csv", replace

*graph export "ITSA-tamoxifen_all_01-2018.png", as(png) replace

/*
import delimited pca_totals.csv,clear
tostring year,replace
gen date =  date(year, "Y")
format date %td


gen tm = mofd(date)

format tm %ty
tsset year ,daily
local intervention = ym(2013, 01)

itsa items_per_starpu, ///
trperiod(2013) figure(subtitle("") note("") msymbol(X i) ///
xtitle(Date) ytitle(items/1000 STAR-PU) ylabel(,format(%14.0fc)) ///
xlabel(#8,format(%tmMonCCYY)) graphregion(c(white)))
*/

import delimited pca_totals.csv,clear
/*tostring year,replace
gen date =  date(year, "Y")
format date %td


gen tm = mofd(date)
*/
*drop year
*rename v2 year
format year %ty
tsset year
local intervention = ym(2013, 01)

itsa items_per_starpu, ///
trperiod(2013) figure(subtitle("") note("") msymbol(X i) ///
xtitle(Date) ytitle(items/1000 STAR-PU) ylabel(,format(%14.0fc)) ///
xlabel(#8,format(%ty)) yscale(range(0 1600)) graphregion(c(white)))
export delimited year _s_items_per_starpu_pred using "pred_long_term.csv", replace
