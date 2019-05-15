class speedCurve {

  // fields
  int j;
  String[][] OriginCrossStreet;
  int[][] MileMarker;
  int[][] AvgSpeed;
  float baseLineY[][];
  float baseLineX[][];

  // cstrs
  speedCurve( ) {
  }

  speedCurve(int j, int[][] MileMarker, float[][] baseLineY, float[][] baseLineX, int[][] AvgSpeed, String[][] OriginCrossStreet) {
    this.j = j;
    this.MileMarker = MileMarker;
    this.baseLineY = baseLineY;
    this.baseLineX = baseLineX;
    this.AvgSpeed = AvgSpeed;
    this.OriginCrossStreet = OriginCrossStreet;
  }
  
  public void render() {
    beginShape();
    for (int i=1; i<=29; i++) {
      // access the arrays to plot curves in this section
      baseLineX[i][j] = map(MileMarker[i][j], 289, 370, width*.05, width*.9);
      baseLineY[i][j] = map(AvgSpeed[i][j], 0, 80, height*.80, height*.95);
      if (i==1 || i==29) {
        curveVertex(baseLineX[i][j], height-baseLineY[i][j]);
      }
      if (AvgSpeed[i][j]!=0) {
        stroke(0);
        strokeWeight(1);
        noFill();
        curveVertex(baseLineX[i][j], height-baseLineY[i][j]);
      }
    }
    newXML = false;  // stop screen draw till new data shows up
    endShape();
  }
}