import controlP5.*; //<>// //<>//

ArrayList<TXDOTrecord> TXDOTrecords = new ArrayList<TXDOTrecord>();
ControlP5 cp5;
boolean toggleValue = false;
boolean paused = false;

ColorRGB getColor = new ColorRGB() ;   // declare a ColorRGB object named getColor

float mincars =1000;
float maxcars = 0;
float maxspeed = 0;
float minspeed = 1000;
int backColor=25;
float fade = 1;
int startRecord = 110;
int endRecord = 3036;
int j = startRecord;
int delayTime = 100;
int incrementer=1;
//color[] rgb = new color[25];
color PausedColor = color(255, 0, 0);
color RunColor = color(0, 0, 255);
PFont textFontTiny, textFontSmall, textFontMed, textFontLarge;
float hourofday;
int strokeColor;
int strokeOpacity;
int k;

void setup() {

  frameRate(240);  // tried moving this to draw, wouldn't go above 60, tried replacing it in draw with the slider control and was very slow
  // best response is to change the delay, but I'll make the slider more intuitive
  size(1500, 900, P3D);
  pixelDensity(displayDensity());
  surface.setLocation(0, 0);
  // surface.setResizable(true);
  cp5 = new ControlP5(this);
  fill(255, 0, 0);
  textFontTiny = createFont("Arial", 20, true); 
  textFontSmall = createFont("Arial", 25, true); // use true/false for smooth/no-smooth
  textFontMed = createFont("Arial", 32, true);
  textFontLarge = createFont("Arial Bold", 45);

  // create buttons and sliders

  cp5.addButton("Paused")
    .setPosition(width*.85, .05*height)
    //.setColor(new color(255,0,0))
    .setSize(150, 40)
    .setValue(0)
    .setFont(textFontSmall)
    .setCaptionLabel("PAUSED") 
    //.setColorForeground(color(255,0,0))
    .setColorBackground(color(255, 0, 0))
    .setId(4)
    ;

  cp5.addSlider("Delay_ms")  //delay(int(cp5.getValue("RefreshDelay_ms")));
    .setPosition(width*.85, .05*height+50)
    .setSize(int(width*.06), 50)
    .setFont(textFontTiny)
    .setRange(0, 100)
    .setValue(delayTime)
    .setColorForeground(color(255, 0, 0))
    .setColorBackground(color(0, 160, 100))
    .setColorActive(color(3, 42, 255))
    .setId(1)
    ;
  cp5.addSlider("Z scale")           //int(cp5.getValue("Fade"))
    .setPosition(width*.85, .05*height+110)
    .setSize(int(width*.06), 50)
    .setFont(textFontTiny)
    .setRange(0, 20)
    .setValue(15)
    .setColorForeground(color(255, 120, 0))
    .setColorBackground(color(34, 160, 100))
    .setColorActive(color(3, 42, 255))
    .setId(2)
    ;


  cp5.addSlider("BackgroundColor")           //int(cp5.getValue("Fade"))
    .setPosition(width*.85, .05*height+170)
    .setSize(int(width*.06), 50)
    .setFont(textFontTiny)
    .setRange(0, 225)
    .setValue(25)
    .setColorForeground(color(255, 0, 0))
    .setColorBackground(color(34, 160, 100))
    .setColorActive(color(0, 255, 255))
    .setId(3)
    ;

  opencsv("TXDOT.csv");
  curveDetail(7);
}

void draw() {
  delay(delayTime); 
  nextCurveIndex();

  if (!paused || ( j== startRecord)) {
    TXDOTrecords.get(j).updateLabels(j);
    for (int k = startRecord; k<=j; k++) {
      pushMatrix();
      translate(0, 0, (k-j)*int(cp5.getValue("Z scale")));
      hourofday = float(getDate(TXDOTrecords.get(k).timestamp, "hour"));
      strokeColor = getColor.index(int(hourofday));
      strokeOpacity =  255-int(cp5.getValue("Fade"))*(k-j);
      TXDOTrecords.get(k).countCarsCurve(k);
      TXDOTrecords.get(k).avgSpeedCurve(k);
      popMatrix();
    }
    TXDOTrecords.get(j).clock(j);
  }
}