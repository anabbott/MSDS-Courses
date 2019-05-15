/* Design and Analysis, 2nd ed. by S. Lohr 
   Copyright 2009 by Sharon Lohr */

filename agstrat 'C:\Users\Mahesh\Desktop\agstrat.csv';

options ls=90  nodate; 
data agstrat;
   infile agstrat delimiter= ',' firstobs = 2;
   input county $ state $ acres92 acres87 acres82 farms92
                          farms87 farms82 largef92 largef87
                          largef82 smallf92 smallf87 smallf82 
                          region $ rn strwt;
   if acres92 < 200000 then lt200k = 1;
      else if acres92 >= 200000 then lt200k = 0; /*  counties with fewer than 200000 acres in farms */
   if acres92 = -99 then acres92 =  . ;  /* check for missing values */
   if acres92 = -99 then lt200k =  . ;  

proc sort data=agstrat;
  by region;

  /* creates pretty boxplots if you have SAS for Windows */
proc boxplot data = agstrat;
   plot acres92 * region;
run;

/* Create dataset containing strata totals. */

data strattot;
   input region $  _total_;
   cards;
NE 220
NC 1054
S  1382
W  422
;
proc print data=strattot;

/* Important:  You need BOTH the weight statement AND the stratum statement! 
   If you omit the weight statement, SAS assigns weight 1 to every observation;
   if you have disproportionate allocation, estimates of the mean will be biased.
   If you omit the stratum statement, the variances will be wrong. 
   Try it without one of these statements and see what happens. */


proc surveymeans data=agstrat total = strattot nobs mean sum clm clsum ; 
   stratum region ;
   var acres92 ;
   weight strwt;
run;

/* We can also add more variables and list the details of the stratification. */

proc surveymeans data=agstrat total = strattot nobs mean  clm sum clsum ; 
   class lt200k;
   stratum region /list;
   var acres92 lt200k;
   weight strwt;
run;




