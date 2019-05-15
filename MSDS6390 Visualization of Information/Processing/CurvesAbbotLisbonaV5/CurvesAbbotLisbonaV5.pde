XML traffic;
int originMileMarker;
int destMileMarker;
String prevTimestamp = "";
String currentTimestamp = "";
float  meanSpeed = 0;
int    ttlCountCars = 0;
boolean processXML = false;
boolean newXML = false;
boolean pause = false;
int row, col ;
float dy;
float speedY = .1;
String[][] TimeStamp;
String[][] systemID;
String[][] direction;
String[][] OriginCrossStreet;
int[][] TravelTimeSec;
int[][] CountCars;
int maxCars = 0;
int[][] AvgSpeed;
Float[][] MeanSpeed;
int[][] MileMarker;
float baseLineY[][];
float baseLineX[][];
float carsY[][];
carCurve C = new carCurve();
speedCurve S = new speedCurve();

void setup() {
  size(2400, 1600);
  surface.setResizable(true);
  background(250);
  col = 0;
  row = 0;
  TimeStamp = new String[30][100];
  OriginCrossStreet = new String[30][100];
  TravelTimeSec = new int[30][100];
  CountCars = new int[30][100];
  AvgSpeed = new int[30][100];
  MeanSpeed = new Float[30][100];
  MileMarker = new int[30][100];
  baseLineY = new float[30][100];
  baseLineX = new float[30][100];
  carsY = new float[30][100];
}

void draw() {
  if (pause == false) {
    checkForNewData();   
    surface.setTitle(currentTimestamp);
  }
  // println("\ni j timestamp         mm cars spd time cross street");  // include this header if printing details
   background(250);
  for (int j=1; j<=col; j++) {
    fill(255, 50);
    rect(0,0,width, height);
    C = new carCurve(j, MileMarker, baseLineY, baseLineX, maxCars, CountCars, OriginCrossStreet);
    S = new speedCurve(j, MileMarker, baseLineY, baseLineX, AvgSpeed, OriginCrossStreet);
    C.render();
    S.render();
  }
}