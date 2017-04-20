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

-- died in titanic ship
DIED = filter TITANIC by Survived == 1;

-- grouping based on the class
GROUPBYEACHCLASS = group DIED by Pclass;

-- count male and female died in each class
COUNTMALEFEMALE = foreach GROUPBYEACHCLASS {
		MALE = filter DIED by Sex == 'male';
		FEMALE = filter DIED by Sex == 'female';
		generate group,COUNT(MALE),COUNT(FEMALE);
};

-- dumping COUNTMALEFEMALE

dump COUNTMALEFEMALE;

-- storing result COUNTMALEFEMALE
store COUNTMALEFEMALE into '/home/acadgild/Downloads/project/1_project_1/countmalefemalebyeachclass';
