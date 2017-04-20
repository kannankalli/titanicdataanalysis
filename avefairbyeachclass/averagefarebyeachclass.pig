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

-- grouping by passenger class 
GROUPBYEACHCLASS = group TITANIC by Pclass;

-- avergage fair based on group
AVEBYEACHCLASS = foreach GROUPBYEACHCLASS generate group, AVG(TITANIC.Fair);

-- dumping result AVEBYEACHCLASS
dump AVEBYEACHCLASS;

-- storing result to avebyeachclass
store AVEBYEACHCLASS into '/home/acadgild/Downloads/project/1_project_1/avebyeachclass';
