A = load 's3://mimiproject3/inputfiles/Syslog-Sample';
B = foreach A generate flatten(TOKENIZE((chararray)$0)) as word;
C = filter B by word matches '\\w+';
D = group C by word;
E = foreach D generate COUNT(C), group;
store E into 's3://mimiproject3/outputfiles/MyPigOutput';