PShape gear, rack; //<>//
PFont font;
float angle = TWO_PI/360;
float dx, dy, targetX, targetY, dxHook, hookX, hookY, targetHookX, targetHookY, theta, rotation =0;
String displayVal;
import org.gicentre.utils.stat.*;
BarChart barChart;

int pointerOffset =0;
PVector selectedBar, pointerSelectedBar;
PVector screenPoint, pointerPoint;
float globalGDP[] = new float[12];

int screenWidth, screenHeight,textOffset;
String[] data;
String[] year;
float[] GDP;

float chartOriginX, chartOriginY, chartWidth, chartHeight, chartYrange, chartYAxisRange, barTop, pointerBarTop ;

void setup() {
  screenPoint = new PVector(mouseX, mouseY);
  font = createFont("Arial", 32);
  shapeMode(CENTER);
  size(1500, 1200);
  surface.setResizable(true);
  screenWidth = width;
  screenHeight = height;
  smooth();
  gear = loadShape("Gear24T24mmDia.svg");
  rack = loadShape("Rack24Tbeam.svg");
  loadData();
  chartYAxisRange = 30000;
  barchart1();//initialize the barchart
}



void draw() {
  displayMousePosition();
  screenPoint = new PVector(mouseX, mouseY);
  selectedBar = barChart.getScreenToData(screenPoint);

  background(255);
  textFont(createFont("Arial", 40), 40);

  barChart.setData(globalGDP);
  chartOriginX = 150;
  chartOriginY = 350;
  chartWidth = width-300;
  chartHeight = height-chartOriginY-50;


  chartYrange = chartHeight ;

  barChart.draw(chartOriginX, chartOriginY, chartWidth, chartHeight); 

  calcGearPosition();
  // 23 teeth per 256 linear pixels on rack, TWO_PI radians per 24 teeth on gear 
  rotation = (targetX*23.0/256.0)*(TWO_PI/24.0);

  // shift rack 8 pixels to align teeth, 53 pixel center to center vertical distance
  // void drawRack(PShape shapeName, float offset)
  drawRack(rack, 8);

  //void drawGear(PShape gearName, float rotation, float targetX) {
  drawGear(gear, rotation, targetX);

  if (selectedBar != null ) {
    displayVal = nfc(floor(globalGDP[(int(selectedBar.x))]), 0); // adds commas, removes decimal places
    
    if ((int(selectedBar.x) < 2)) {
      textOffset = 25;
    } else { 
        textOffset = -170;
      }
    text("$"+displayVal, targetHookX+textOffset, targetHookY -100);

    for (int i=0; i<= (int(selectedBar.x)); i++) {
      globalGDP[i] = constrain(globalGDP[i] + .1* GDP[i], 0, GDP[i]);
    }
  }
  if (mouseX < chartOriginX) {
    for (int i=0; i<globalGDP.length; i++) {
      globalGDP[i] = globalGDP[i] - 0.025*GDP[i];
    }
  }


  // Draw a title over the top of the chart.
  fill(0); 
  
  textSize(40); 
  text("GDP per capita ", 30, 250); 
  textSize(30); 
  text("(inflation adjusted $US)",  30, 280);
}