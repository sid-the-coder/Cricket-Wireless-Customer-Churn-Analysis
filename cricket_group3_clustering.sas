LIBNAME UTD 'H:\SAS-MXS180051'; run;

proc import datafile = 'H:\SAS-MXS180051\TestGroup3.csv'
 out = utd.cricketnew
 dbms = CSV
 ;
run;
proc fastclus data = utd.cricketnew 
maxclusters = 6 out = clus ;
var
DATA_USED_1MONTH		DATA_3MONTH_TO_DEACT		NUM_IVR_CALLS
AVG_IVR_DURATION	CALL_3MONTHS_TO_DEACT			CALLS_1MONTH
NUM_DROPPED_CALLS				tenure					total_drop_calls
hh_income;
run;
** steps: standard -- kmeans -- discrim *;

proc standard data=utd.cricketnew mean=0 std=1 out=standard;
var 
DATA_USED_1MONTH		DATA_3MONTH_TO_DEACT		NUM_IVR_CALLS
AVG_IVR_DURATION	CALL_3MONTHS_TO_DEACT			CALLS_1MONTH
NUM_DROPPED_CALLS				tenure					total_drop_calls
hh_income;
run;
proc fastclus data = work.standard 
maxclusters = 6 out = clus_final;
var
DATA_USED_1MONTH		DATA_3MONTH_TO_DEACT		NUM_IVR_CALLS
AVG_IVR_DURATION	CALL_3MONTHS_TO_DEACT			CALLS_1MONTH
NUM_DROPPED_CALLS				tenure					total_drop_calls
hh_income;
run;
proc import datafile = 'H:\SAS-MXS180051\TestGroup3.csv'
 out = utd.cricketnew
 dbms = CSV
 ;
run;
proc export data=clus_final dbms=CSV

outfile="H:\SAS-MXS180051\TestGroup3_clus_final.csv"

replace;

run;
