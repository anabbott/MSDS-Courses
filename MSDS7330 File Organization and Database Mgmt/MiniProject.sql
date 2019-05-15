create database baseball_salaries;

use baseball_salaries;

create table PlayerInfo
	(Team_name varchar(30),
    Player_Name varchar(30),
    Salary numeric(12,2),
    Position varchar(20)
    );
    
LOAD DATA LOCAL INFILE 'C:/Users/Abbott/Desktop/baseball_salaries_2003_2_2_2.txt' 
INTO TABLE PlayerInfo
FIELDS TERMINATED BY ':'
LINES TERMINATED BY '\n' 
IGNORE 3 
LINES(Team_Name,Player_Name,Salary,Position);

create table AvgSalaries
(Position varchar(30),
AvgSalary numeric (12,2)
);

Insert into AvgSalaries(    
select Position,
avg(Salary) as AvgSalary
 from playerinfo
 group by Position)