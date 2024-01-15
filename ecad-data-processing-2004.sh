#!/bin/bash

################## HISTORICAL DATA PROCESSING #########################################

### Solar radiation
## Calculate daily avarage solar radiation in Mjouls from 3hourly interval input file
cdo -expr,'rs= SWDOWN * 0.0036 * 3.0' ../2004/wrf_monsoon_HIS_SWDOWN_2004.nc ../2004-ecad-input-files/wrf_monsoon_HIS_SWDOWN_2004_Mjouls.nc
cdo --timestat_date first -daymean ../2004-ecad-input-files/wrf_monsoon_HIS_SWDOWN_2004_Mjouls.nc ../2004-ecad-input-files/wrf_monsoon_HIS_SWDOWN_2004_Mj_dailyAvg.nc 

### Wind speed
##a. Merge netCDF files containing u10 and v10
cdo -O -merge  ../2004/wrf_monsoon_HIS_U10_2004.nc ../2004/wrf_monsoon_HIS_V10_2004.nc ../2004-ecad-input-files/wrf_monsoon_HIS_U10V10_2004.nc

##b. Calculate wind speed with u10 and v10
cdo -O -expr,'ws=sqrt(U10*U10+V10*V10)' -selname,U10,V10  ../2004-ecad-input-files/wrf_monsoon_HIS_U10V10_2004.nc ../2004-ecad-input-files/wrf_monsoon_HIS_WS_2004.nc

##c. Calculate daily avarage wind speed from 3hourly interval wind speed data
cdo --timestat_date first -daymean ../2004-ecad-input-files/wrf_monsoon_HIS_WS_2004.nc ../2004-ecad-input-files/wrf_monsoon_HIS_WS_2004_dailyAvg.nc

### Min and Max Temperature
##a. Daily maximum temperature with temstamp of the start of the day.
cdo --timestat_date first -expr,'tx=T2' -daymax ../2004/wrf_monsoon_HIS_T2_2004.nc ../2004-ecad-input-files/wrf_monsoon_HIS_T2_2004_dailyMaxi-first.nc

##b. Daily minimum temperature with temstamp of the start of the day.
cdo --timestat_date first -expr,'tn=T2' -daymin ../2004/wrf_monsoon_HIS_T2_2004.nc ../2004-ecad-input-files/wrf_monsoon_HIS_T2_2004_dailyMini-first.nc

###  Relative humidity
##a. Merge Q2, PSFC and T2
cdo -O -merge  ../2004/wrf_monsoon_HIS_Q2_2004.nc ../2004/wrf_monsoon_HIS_T2_2004.nc ../2004/wrf_monsoon_HIS_PSFC_2004.nc  ../2004-ecad-input-files/wrf_monsoon_HIS_Q2T2PSFC_2004.nc

##b. Calculate rh2 from 3 hourly input file. Value range is 1:100, any values outside range will be replaced with the nearest neighbour.
cdo setmisstonn -setvrange,1,100 -expr,'rh= ((Q2/(1.0+Q2)) / ( (379.90516 / PSFC) * exp( 17.2693882 * (T2 - 273.16) / (T2 - 35.86)) ) )*100.0' ../2004-ecad-input-files/wrf_monsoon_HIS_Q2T2PSFC_2004.nc ../2004-ecad-input-files/wrf_monsoon_HIS_RH2_2004.nc

##c. Calculate daily RH avarage from 3 hourly-interval rh2 file.
cdo --timestat_date first -daymean ../2004-ecad-input-files/wrf_monsoon_HIS_RH2_2004.nc ../2004-ecad-input-files/wrf_monsoon_HIS_RH2_2004_dailyAvg.nc

##c. Calculate terrain height/elevation file.
cdo --timestat_date first -expr,'elev=HGT' -daymean ../2004/wrf_monsoon_HIS_HGT_2004.nc ../2004-ecad-input-files/wrf_monsoon_HIS_HGT_2004_dailyAvg.nc



################## CCSM4/PGW DATA PROCESSING ##########################################

### Solar radiation
## Calculate daily avarage solar radiation from 3hourly interval input file

cdo -expr,'rs= SWDOWN * 0.0036 * 3.0' ../2004/wrf_monsoon_CCSM4_SWDOWN_2004.nc ../2004-ecad-input-files/wrf_monsoon_CCSM4_SWDOWN_2004_Mjouls.nc
cdo --timestat_date first -daymean ../2004-ecad-input-files/wrf_monsoon_CCSM4_SWDOWN_2004_Mjouls.nc ../2004-ecad-input-files/wrf_monsoon_CCSM4_SWDOWN_2004_Mj_dailyAvg.nc

### Wind speed
##a. Merge netCDF files containing u10 and v10
cdo -O -merge  ../2004/wrf_monsoon_CCSM4_U10_2004.nc ../2004/wrf_monsoon_CCSM4_V10_2004.nc ../2004-ecad-input-files/wrf_monsoon_CCSM4_U10V10_2004.nc

##b. Calculate wind speed with u10 and v10
cdo -O -expr,'ws=sqrt(U10*U10+V10*V10)' -selname,U10,V10  ../2004-ecad-input-files/wrf_monsoon_CCSM4_U10V10_2004.nc ../2004-ecad-input-files/wrf_monsoon_CCSM4_WS_2004.nc

##c. Calculate daily avarage wind speed from 3hourly interval wind speed data
cdo --timestat_date first -daymean ../2004-ecad-input-files/wrf_monsoon_CCSM4_WS_2004.nc ../2004-ecad-input-files/wrf_monsoon_CCSM4_WS_2004_dailyAvg.nc

### Min and Max Temperature
##a. Daily maximum temperature with temstamp of the start of the day.
cdo --timestat_date first -expr,'tx=T2' -daymax ../2004/wrf_monsoon_CCSM4_T2_2004.nc ../2004-ecad-input-files/wrf_monsoon_CCSM4_T2_2004_dailyMaxi-first.nc

##b. Daily minimum temperature with temstamp of the start of the day.
cdo --timestat_date first -expr,'tn=T2' -daymin ../2004/wrf_monsoon_CCSM4_T2_2004.nc ../2004-ecad-input-files/wrf_monsoon_CCSM4_T2_2004_dailyMini-first.nc

###  Relative humidity
##a. Merge Q2, PSFC and T2
cdo -O -merge  ../2004/wrf_monsoon_CCSM4_Q2_2004.nc ../2004/wrf_monsoon_CCSM4_T2_2004.nc ../2004/wrf_monsoon_CCSM4_PSFC_2004.nc  ../2004-ecad-input-files/wrf_monsoon_CCSM4_Q2T2PSFC_2004.nc

##b. Calculate rh2 from 3 hourly input file. Value range is 1:100, any values outside range will be replaced with the nearest neighbour.
cdo setmisstonn -setvrange,1,100 -expr,'rh= ((Q2/(1.0+Q2)) / ( (379.90516 / PSFC) * exp( 17.2693882 * (T2 - 273.16) / (T2 - 35.86)) ) )*100.0' ../2004-ecad-input-files/wrf_monsoon_CCSM4_Q2T2PSFC_2004.nc ../2004-ecad-input-files/wrf_monsoon_CCSM4_RH2_2004.nc

##c. Calculate daily RH avarage from 3 hourly-interval rh2 file.
cdo --timestat_date first -daymean ../2004-ecad-input-files/wrf_monsoon_CCSM4_RH2_2004.nc ../2004-ecad-input-files/wrf_monsoon_CCSM4_RH2_2004_dailyAvg.nc

##c. Calculate terrain height/elevation file.
cdo --timestat_date first -daymean ../2004/wrf_monsoon_CCSM4_HGT_2004.nc ../2004-ecad-input-files/wrf_monsoon_CCSM4_HGT_2004_dailyAvg.nc
