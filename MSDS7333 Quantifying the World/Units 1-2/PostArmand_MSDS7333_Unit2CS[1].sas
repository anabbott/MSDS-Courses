

/* Datalines are used to make the work more easily reproducible */

DATA CarMPG;
INPUT Auto $23. MPG CYLINDERS SIZE HP WEIGHT ACCEL ENG_TYPE;
DATALINES;
Buick Estate Wagon     16.9 8 350 155 4.36 14.9 1
Ford Country Sq. Wagon 15.5 8 351 142 4.054 14.3 1
Chevy Malibu Wagon     19.2 8 267 125 3.605 15 1
Chrys Lebaron Wagon    18.5 8 360 150 3.94 13 1
Chevette               30 4 98 68 2.155 16.5 0
Toyota Corona          27.5 4 134 95 2.56 14.2 0
Datsun 510             27.2 4 119 97 2.3 14.7 0
Dodge Omni             30.9 4 105 75 2.23 14.5 0
Audi 5000              20.3 5 131 103 2.83 15.9 0
Volvo 240 GL           17 6 163 125 3.14 13.6 0
Saab 99 GLE            21.6 4 121 115 2.795 15.7 0
Peugeot 694 SL         16.2 6 163 133 3.41 15.8 0
Buick Century Spec.    20.6 6 231 105 3.38 15.8 0
Mercury Zephyr         20.8 6 200 85 3.07 16.7 0
Dodge Aspen            18.6 6 225 110 3.62 18.7 0
AMC Concord D/L        18.1 6 258 120 3.41 15.1 0
Chevy Caprice Classic  17 8 305 130 3.84 15.4 1
Ford LTD               17.6 8 302 129 3.725 13.4 1
Mercury Grand Marquis  16.5 8 351 138 3.955 13.2 1
Dodge St Regis         18.2 8 318 135 3.83 15.2 1
Ford Mustang 4         26.5 4 140 88 2.585 14.4 0
Ford Mustang Ghia      21.9 6 171 109 2.91 16.6 1
Mazda GLC              34.1 4 86 65 1.975 15.2 0
Dodge Colt             35.1 4 98 80 1.915 14.4 0
AMC Spirit             27.4 4 121 80 2.67 15 0
VW Scirocco            31.5 4 89 71 1.99 14.9 0
Honda Accord           29.5 4 98 68 2.135 16.6 0
Buick Skylark          28.4 4 151 90 2.67 16 0
Chevy Citation         28.8 6 173 115 2.595 11.3 1
Olds Omega             26.8 6 173 115 2.7 12.9 1
Pontiac Phoenix        33.5 4 151 90 2.556 13.2 0
Plymouth Horizon       34.2 4 105 70 2.2 13.2 0
Datsun 210             31.8 4 85 65 2.02 19.2 0
Fiat Strada            37.3 4 91 69 2.13 14.7 0
VW Dasher              30.5 4 97 78 2.19 14.1 0
Datsun 810             22 6 146 97 2.815 14.5 0
BMW 320i               21.5 4 121 110 2.6 12.8 0
VW Rabbit              31.9 4 89 71 1.925 14 0
;
QUIT;


DATA CarMPG2;
INPUT Auto $23. MPG CYLINDERS SIZE HP WEIGHT ACCEL ENG_TYPE;
DATALINES;
Buick Estate Wagon     16.9 8 350 155 4.36 14.9 1
Ford Country Sq. Wagon 15.5 8 351 . 4.054 14.3 1
Chevy Malibu Wagon     19.2 8 267 125 3.605 15 1
Chrys Lebaron Wagon    18.5 8 360 150 3.94 13 1
Chevette               30 4 98 68 2.155 16.5 0
Toyota Corona          27.5 4 134 95 2.56 14.2 0
Datsun 510             27.2 4 119 97 2.3 14.7 0
Dodge Omni             30.9 4 105 75 2.23 14.5 .
Audi 5000              20.3 5 131 . 2.83 15.9 0
Volvo 240 GL           17 6 163 125 3.14 13.6 0
Saab 99 GLE            21.6 . 121 115 2.795 15.7 0
Peugeot 694 SL         16.2 6 . 133 3.41 15.8 0
Buick Century Spec.    20.6 . 231 105 3.38 15.8 0
Mercury Zephyr         20.8 6 200 85 . 16.7 0
Dodge Aspen            18.6 6 225 110 3.62 18.7 0
AMC Concord D/L        18.1 . 258 120 3.41 . 0
Chevy Caprice Classic  17 . 305 130 . 15.4 1
Ford LTD               17.6 8 302 129 3.725 . .
Mercury Grand Marquis  16.5 8 351 138 3.955 13.2 1
Dodge St Regis         18.2 8 318 135 3.83 . 1
Ford Mustang 4         26.5 4 140 . 2.585 14.4 0
Ford Mustang Ghia      21.9 6 171 . 2.91 16.6 1
Mazda GLC              34.1 4 86 65 . 15.2 0
Dodge Colt             35.1 4 98 80 1.915 14.4 0
AMC Spirit             27.4 4 121 . 2.67 15 0
VW Scirocco            31.5 4 89 71 1.99 14.9 0
Honda Accord           29.5 4 98 68 . 16.6 0
Buick Skylark          28.4 4 151 90 2.67 16 0
Chevy Citation         28.8 6 173 115 2.595 11.3 1
Olds Omega             26.8 6 173 115 2.7 12.9 1
Pontiac Phoenix        33.5 4 151 90 2.556 13.2 0
Plymouth Horizon       34.2 4 105 70 2.2 13.2 0
Datsun 210             31.8 4 85 65 2.02 19.2 .
Fiat Strada            37.3 4 91 69 2.13 14.7 0
VW Dasher              30.5 4 . 78 . 14.1 0
Datsun 810             22 6 . 97 2.815 14.5 0
BMW 320i               21.5 4 121 110 . . 0
VW Rabbit              31.9 4 89 71 1.925 14 0
;
RUN;


TITLE 'Predicting MPG';
PROC REG DATA = CarMPG2;
	MODEL MPG = CYLINDERS SIZE HP WEIGHT ACCEL ENG_TYPE;
RUN;
QUIT;



ODS SELECT MISSPATTERN;
PROC MI DATA = CarMPG2 NIMPUTE = 0;
	VAR MPG CYLINDERS SIZE HP WEIGHT ACCEL ENG_TYPE;
RUN;



PROC MI DATA = CarMPG2
	OUT = MIOUT SEED = 35399;
	VAR MPG CYLINDERS SIZE HP WEIGHT ACCEL ENG_TYPE;
RUN;



PROC REG DATA = miout OUTEST = outreg COVOUT;
     MODEL MPG = CYLINDERS SIZE HP WEIGHT ACCEL ENG_TYPE;
BY _Imputation_;
RUN;



PROC MIANALYZE DATA = outreg;
	MODELEFFECTS CYLINDERS SIZE HP WEIGHT ACCEL ENG_TYPE Intercept;
RUN;



