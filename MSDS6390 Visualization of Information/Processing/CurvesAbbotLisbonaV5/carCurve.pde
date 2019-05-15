class carCurve {

  // fields
  int j;
  String[][] OriginCrossStreet;
  int[][] CountCars;
  int maxCars = 0;
  int[][] MileMarker;
  float baseLineY[][];
  float baseLineX[][];

  // cstrs
  carCurve( ) {
  }

  carCurve(int j, int[][] MileMarker, float[][] baseLineY, float[][] baseLineX, int maxCars, int[][] CountCars, String[][] OriginCrossStreet) {
    this.j = j;
    this.MileMarker = MileMarker;
    this.baseLineY = baseLineY;
    this.baseLineX = baseLineX;
    this.maxCars = maxCars;
    this.CountCars = CountCars;
    this.OriginCrossStreet = OriginCrossStreet;
  }
  
  public void render() {
    beginShape();
    for (int i=1; i<=29; i++) {
      // access the arrays to plot curves in this section
      baseLineX[i][j] = map(MileMarker[i][j], 289, 370, width*.05, width*.9);
      baseLineY[i][j] = map(CountCars[i][j], 0, maxCars, height*.20, height*.85);
      if (i==1 || i==29) {
        curveVertex(baseLineX[i][j], height-baseLineY[i][j]);
      }
      if (CountCars[i][j]!=0) {
        stroke(0);
        strokeWeight(10);
        line(baseLineX[i][j], height*.80, baseLineX[i][j], height-baseLineY[i][j]);
        strokeWeight(1);
        noFill();
        curveVertex(baseLineX[i][j], height-baseLineY[i][j]);
        pushMatrix();
        fill(0);
        textSize(25);
        translate(baseLineX[i][j], .80* height +15);
        rotate(HALF_PI/2);
        text(OriginCrossStreet[i][j], 0, 0);
        popMatrix();
        noFill();
      }
    }
    newXML = false;  // stop screen draw till new data shows up
    endShape();
  }
}