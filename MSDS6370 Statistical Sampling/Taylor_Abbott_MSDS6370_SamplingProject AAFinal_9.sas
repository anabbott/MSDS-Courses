/*
Celia Taylor and Andrew Abbott
MSDS6370 Project Summer 2017
data set https://data.cms.gov/Medicare-Inpatient/Inpatient-Prospective-Payment-System-IPPS-Provider/97k6-zzx3
*/

data incharges;
/*Andrew's directory path
infile '/folders/myfolders/sasuser.v94/inpatientChargesAddedDRG_5.csv' firstobs=2 dlm = ',' DSD;
*/
/*
 * Celia's directory path
 */
infile '/folders/myfolders/SASDATA/inpatientChargesAddedDRG_5FromAA.csv' firstobs=2 dlm = ',' DSD;
input DRGDef $ DRGDefNum ProvStreetAdd $ ProvCity $ ProvState $ ProvZipCode HospRefRegionDesc $ TotalDischarges AverageCovCharges AverageTotPayments AverageMedicarePayments Stratum ;
AverageProportionPaid = AverageMedicarePayments/AverageTotPayments;
output incharges;
run;

title "Descriptive Statistics - Inpatient Charges Population";
proc means data=incharges;
footnote "Figure 1 - Descriptive Statistics - Population Inpatient Charges - Total Discharges, DRG, Stratum, Average Proportion Paid";
run;

title "Select the Sample Proportionally";
proc surveyselect data=incharges method = srs out = propsample 
sampsize = (426,226,142,92,58,27) seed=91118;
strata Stratum;
footnote "Figure 2 - Sample Selected";
run;

title "Select the Sample with Neyman Allocation";
proc surveyselect data=incharges method = srs out = neymansample 
sampsize = (475,222,128,79,47,20) seed=91118;
strata Stratum;
footnote "Figure 3 - Sample Selected";
run;

data strsizes;
input Stratum _total_;
datalines;
1 71475
2 37914
3 23779
4 15545
5 9791
6 4561
;
run;

/*
 * CLSUM 100(1-α)% two-sided confidence limits for the SUM, 
 * where α is determined by the ALPHA= option; the default is α=0.05 
 *
 * CLM 100(1-α)% two-sided confidence limits for the MEAN, 
 * where α is determined by the ALPHA= option; the default is α=0.05
 */

title "Proportional allocation with CLM two-sided confidence limits for the MEAN and CLSUM for two-sided confidence limits for the SUM";
proc surveymeans data = propsample sum clsum total = strsizes mean CLM;
var AverageProportionPaid;
weight SamplingWeight;
strata Stratum / list;
footnote "Figure 4 - Population Inpatient Charges - Proportional Allocation Confidence Limits";
run;

title "Neyman allocation with CLM two-sided confidence limits for the MEAN and CLSUM for two-sided confidence limits for the SUM";
proc surveymeans data = neymansample sum clsum total = strsizes mean CLM;
var AverageProportionPaid;
weight SamplingWeight;
strata Stratum / list;
footnote "Figure 5 - Population Inpatient Charges - Neyman Allocation Confidence Limits";
run;

title "Proportional Cluster Sample with CLM two-sided confidence limits for the MEAN and CLSUM for two-sided confidence limits for the SUM";
proc surveymeans data = propsample sum clsum total = strsizes mean CLM;
var AverageProportionPaid;
weight SamplingWeight;
strata Stratum / list;
cluster DRGDefNum;
footnote "Figure 6 - Population Inpatient Charges - Proportional Cluster Design Confidence Limits";
run;

title "Neyman Cluster Sample with CLM two-sided confidence limits for the MEAN and CLSUM for two-sided confidence limits for the SUM";
proc surveymeans data = neymansample sum clsum total = strsizes mean CLM;
var AverageProportionPaid;
weight SamplingWeight;
strata Stratum / list;
cluster DRGDefNum;
footnote "Figure 7 - Population Inpatient Charges - Neyman Cluster Design Confidence Limits";
run;

proc surveyselect data=incharges method = srs out = propsample2 
sampsize = (426,226,142,92,58,27) seed=91119;
strata Stratum;
footnote "Surveyselect Seed 91119";
run;

proc surveyselect data=incharges method = srs out = propsample3
sampsize = (426,226,142,92,58,27) seed=91120;
strata Stratum;
footnote "Surveyselect Seed 91120";
run;

proc surveyselect data=incharges method = srs out = propsample4
sampsize = (426,226,142,92,58,27) seed=91121;
strata Stratum;
footnote "Surveyselect Seed 91121";
run;

proc surveyselect data=incharges method = srs out = propsample5
sampsize = (426,226,142,92,58,27) seed=91122;
strata Stratum;
footnote "Surveyselect Seed 91122";
run;

title "Proportional allocation with CLM two-sided confidence limits for the MEAN and CLSUM for two-sided confidence limits for the SUM";
proc surveymeans data = propsample sum clsum total = strsizes mean CLM;
var AverageProportionPaid;
weight SamplingWeight;
strata Stratum / list;
footnote "Figure 8 - Proportional Stratified - Seed=91118";
run;
title "Proportional allocation with CLM two-sided confidence limits for the MEAN and CLSUM for two-sided confidence limits for the SUM";
proc surveymeans data = propsample2 sum clsum total = strsizes mean CLM;
var AverageProportionPaid;
weight SamplingWeight;
strata Stratum / list;
footnote "Figure 9 - Proportional Stratified - Seed=91119";
run;
title "Proportional allocation with CLM two-sided confidence limits for the MEAN and CLSUM for two-sided confidence limits for the SUM";
proc surveymeans data = propsample3 sum clsum total = strsizes mean CLM;
var AverageProportionPaid;
weight SamplingWeight;
strata Stratum / list;
footnote "Figure 10 - Proportional Stratified - Seed=91120";
run;
title "Proportional allocation with CLM two-sided confidence limits for the MEAN and CLSUM for two-sided confidence limits for the SUM";
proc surveymeans data = propsample4 sum clsum total = strsizes mean CLM;
var AverageProportionPaid;
weight SamplingWeight;
strata Stratum / list;
footnote "Figure 11 - Proportional Stratified - Seed=91121";
run;
title "Proportional allocation with CLM two-sided confidence limits for the MEAN and CLSUM for two-sided confidence limits for the SUM";
proc surveymeans data = propsample5 sum clsum total = strsizes mean CLM;
var AverageProportionPaid;
weight SamplingWeight;
strata Stratum / list;
footnote "Figure 12 - Proportional Stratified - Seed=91122";
run;
title "Cluster Sample with CLM two-sided confidence limits for the MEAN and CLSUM for two-sided confidence limits for the SUM";
proc surveymeans data = propsample sum clsum total = strsizes mean CLM;
strata Stratum;
weight SamplingWeight;
cluster DRGDefNum;
var AverageProportionPaid;
footnote "Figure 13 - Proportional Clustered - Seed=91118";
run;
title "Cluster Sample with CLM two-sided confidence limits for the MEAN and CLSUM for two-sided confidence limits for the SUM";
proc surveymeans data = propsample2 sum clsum total = strsizes mean CLM;
strata Stratum;
weight SamplingWeight;
cluster DRGDefNum;
var AverageProportionPaid;
footnote "Figure 14 - Proportional Clustered - Seed=91119";
run;
title "Cluster Sample with CLM two-sided confidence limits for the MEAN and CLSUM for two-sided confidence limits for the SUM";
proc surveymeans data = propsample3 sum clsum total = strsizes mean CLM;
strata Stratum;
weight SamplingWeight;
cluster DRGDefNum;
var AverageProportionPaid;
footnote "Figure 15 - Proportional Clustered - Seed=91120";
run;
title "Cluster Sample with CLM two-sided confidence limits for the MEAN and CLSUM for two-sided confidence limits for the SUM";
proc surveymeans data = propsample4 sum clsum total = strsizes mean CLM;
strata Stratum;
weight SamplingWeight;
cluster DRGDefNum;
var AverageProportionPaid;
footnote "Figure 16 - Proportional Clustered - Seed=91121";
run;
title "Cluster Sample with CLM two-sided confidence limits for the MEAN and CLSUM for two-sided confidence limits for the SUM";
proc surveymeans data = propsample5 sum clsum total = strsizes mean CLM;
strata Stratum;
weight SamplingWeight;
cluster DRGDefNum;
var AverageProportionPaid;
footnote "Figure 17 - Proportional Clustered - Seed=91122";
run;