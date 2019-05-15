A = load 's3://mimiproject3/inputfiles/Syslog-Sample' as (month:chararray, day:chararray, time:chararray); 
B = group A by (month, day, time);
C = foreach B generate flatten(group) as (month, day,time),
COUNT(month, day, time);
store C into 's3://mimiproject3/outputfiles/MyPigOutput';