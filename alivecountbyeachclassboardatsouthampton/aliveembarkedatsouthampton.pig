-- set map reduce log to directory
set mapred.output.dir= '/home/acadgild/Downloads/log';

-- load input file into TITANIC relation

TITANIC = load '/home/acadgild/Downloads/TitanicData.txt' using PigStorage(',') as
(
PassengerId:long,
Survived:int,
Pclass:chararray,
Name:chararray,
Sex:chararray,
Age:int,
SibSp:chararray,
Parch:chararray,
Ticket:chararray,
Fair:float,
Cabin:chararray,
Embarked:chararray
);

-- filter by survived and embarked at Southanpton
SURVIVEDFROMSOUTH = filter TITANIC by Survived == 0 and Embarked == 'S' ;

-- group by class 
GROUPBYEACHCLASS = group SURVIVEDFROMSOUTH by Pclass;

-- counting by alive
ALIVECOUNTBYEACHCLASS = foreach GROUPBYEACHCLASS generate group,COUNT(SURVIVEDFROMSOUTH);

-- dumping ALIVECOUNTBYEACHCLASS 
dump ALIVECOUNTBYEACHCLASS;

-- store ALIVECOUNTBYEACHCLASS
store ALIVECOUNTBYEACHCLASS into '/home/acadgild/Downloads/project/1_project_1/alivecountbyeachclass';
