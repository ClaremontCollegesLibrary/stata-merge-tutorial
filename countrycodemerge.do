//Country Code Merge:
//Add 2019 GDP per capita data from World Bank Group
//to 2019 Penn World Table data.
//Export result as .dta and .xlsx files

frames reset

//IMPORT PENN WORLD TABLE DATA, SELECT 2019
//SAVE AS DTA

frame create pwt1001
frame change pwt1001

import excel "pwt1001.xlsx", clear firstrow sheet("Data")

keep if year==2019

rename countrycode CountryCode

save pwt1001_2019.dta, replace

//IMPORT WORLD BANK DATA
//SAVE AS DTA

frame create gdppc
frame change gdppc

import excel "API_NY.GDP.PCAP.CD_DS2_en_excel_v2_193.xls", clear firstrow cellrange(A4:BP270)
keep CountryName CountryCode BL
save gdppc2019.dta, replace

//MERGE PWT & WB DATA
//FILTER FOR 2019
frame change pwt1001
merge 1:1 CountryCode using gdppc2019, keep(match)

// SAVE MERGED DATA AS DTA
save merged_2019.dta, replace

//SAVE MERGED DATA IN EXCEL FORMAT
export excel using merged_2019.xlsx, firstrow(variables) replace
