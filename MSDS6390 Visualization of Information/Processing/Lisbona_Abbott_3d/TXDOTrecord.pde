class TXDOTrecord { //<>//
  String timestamp;
  int recnum;
  int sampleSize;
  int[] segment;
  int[] originMileMarker;
  float[] avgSpeed;
  float[] countCars;
  float x, y, y_offset=0;
  int startCurve, endCurve, currentCurve;
  int displayCurveCount = 10;
  String speedtext;
  String[] crossStreet;
  String mystring;
  float hourofday;
  float minuteofday;
  float colorscale;
  float uiWidth = .85;


  TXDOTrecord() {
  }

  TXDOTrecord(String timestamp, int recnum, int sampleSize, int[] segment, int[] originMileMarker, float[] avgSpeed, float[] countCars, String[] crossStreet) {
    this.timestamp         = timestamp;
    this.recnum            = recnum;
    this.sampleSize        = sampleSize;
    this.segment           = segment;
    this.originMileMarker  = originMileMarker;
    this.crossStreet       = crossStreet;
    this.avgSpeed          = new float[avgSpeed.length];   // correct way to create a copy of the arrays being passed in
    this.countCars         = new float[countCars.length];
    for (int i=0; i< avgSpeed.length; i++) {
      this.avgSpeed[i] = avgSpeed[i];
      this.countCars[i] = countCars[i];
      this.crossStreet[i] = crossStreet[i];
    }
  }

  void updateLabels(int i) {
    // show in title
    surface.setTitle("FrameRate="+int(frameRate/10)*10 +" "+TXDOTrecords.get(i).recnum +" "+TXDOTrecords.get(i).timestamp);
    clear();
    background(cp5.getValue("BackgroundColor"));
    fill(255);
    rect(0, 0, width, height*.05);   
    // display the current speed across top of chart
    for (int j = 1; j<=29; j++) {
      if (int(TXDOTrecords.get(i).avgSpeed[j]) >0) {
        x = map(TXDOTrecords.get(i).originMileMarker[j], 289, 370, width*.025, width*uiWidth);
        textSize(20);
        textFont(textFontSmall);   
        pushMatrix();
        translate(x, .02* height);
        rotate(HALF_PI);   
        if (TXDOTrecords.get(i).avgSpeed[j] > 75) {
          fill(255, 0, 0); //red if speeding
        } else {
          fill(0); // black if within speed limit
        }
        speedtext = str(int(TXDOTrecords.get(i).avgSpeed[j]));
        text(speedtext, 0, 0);  // current speed
        noFill();
        popMatrix();


        // plot the divider vertical mile lines
        stroke(170, 180, 200);
        strokeWeight(1);
        line(x, .05*height, x, .84*height);
        fill(255);
        textFont(textFontTiny);
        textSize(15);

        pushMatrix(); // display the cross streets          
        translate(x, .85* height );
        rotate(HALF_PI/2);
        text(TXDOTrecords.get(i).crossStreet[j], 0, 0);
        popMatrix();
      }
    }

    // box on top of current date hour so it doesn't overright the value
    noStroke();
    //fill(backColor);
    //rect(width*.02, height*.05, width*.125, height*.04);

    // day and hour label
    fill(0); //font color black
    textFont(textFontSmall); 
    textSize(25);
    fill(255);
    hourofday = float(getDate(TXDOTrecords.get(i).timestamp, "hour"));
    text(getDate(TXDOTrecords.get(i).timestamp, "dayhour"), width*.02, height*.08);

    // max and min speed, need to calc this ahead of time to scale the curves to fit the space
    text(int(maxspeed) + " MPH MaxSpeed", width*.02, 20+height*.1);
    text(int(minspeed) + " MPH MinSpeed", width*.02, -20+height*.4);

    text(int(mincars)+" Minimum Cars", width*.02, height*.8);//map(mincars,mincars, maxcars,0,height*.5));
    text(int(maxcars)+" Maximum Cars", width*.02, 20+height*.8-map(maxcars, mincars, maxcars, 0, height*.4)+10);
    // horizontal dividers
    stroke(170, 180, 200);
    line(0, height*.8-map(mincars, mincars, maxcars, 0, height*.4)+10, width*uiWidth, height*.8-map(mincars, mincars, maxcars, 0, height*.4)+10);
    line(0, height*.8-map(maxcars, mincars, maxcars, 0, height*.4), width*uiWidth, height*.8-map(maxcars, mincars, maxcars, 0, height*.4));

    // time bar
    noFill();
    hourofday = float(getDate(TXDOTrecords.get(i).timestamp, "hour"));
    colorscale = map(hourofday, 0, 24, 0, 255);
    stroke(getColor.index(int(hourofday)));
    fill(255);
    strokeWeight(6);
    x = map(TXDOTrecords.get(i).recnum, startRecord, TXDOTrecords.size(), width*.025, width*uiWidth);
    line(x, -10+height*.4, x, 10+height*.4);
    strokeWeight(1);
  }



  void avgSpeedCurve(int i) {
    noFill();
    strokeWeight(1);
    beginShape();    
    for (int j = 1; j<=29; j++) {
      if (int(TXDOTrecords.get(i).avgSpeed[j]) >0) {
        hourofday = float(getDate(TXDOTrecords.get(i).timestamp, "hour"));
        //stroke(rgb[int(hourofday)]);
        stroke(strokeColor, strokeOpacity);
        //    stroke(ColorRGB.index(int(hourofday)));
        x = map(TXDOTrecords.get(i).originMileMarker[j], 289, 370, width*.025, width*uiWidth);
        y = height*.4-map(TXDOTrecords.get(i).avgSpeed[j], minspeed, maxspeed, 0, height*.3);    
        if (j==1 || j==29) { 
          curveVertex(x, y);
        }
        curveVertex(x, y);
      }
    }
    endShape();
  } // countCarsCurve


  void countCarsCurve(int i) {
    noFill();
    stroke(strokeColor, strokeOpacity);
    strokeWeight(1);
    beginShape();         
    for (int j = 1; j<=29; j++) {
      if (TXDOTrecords.get(i).countCars[j] >0) {   //if cars > 0 
        if (TXDOTrecords.get(i).segment[j] <=3 ||TXDOTrecords.get(i).segment[j] >=8 ) {     
          x = map(TXDOTrecords.get(i).originMileMarker[j], 289, 370, width*.025, width*uiWidth);
          y = height*.8- map(TXDOTrecords.get(i).countCars[j], mincars, maxcars, 0, height*.4);
          if (j==1 || j==29) { 
            curveVertex(x, y);
          }
          curveVertex(x, y);
        }//if cars > 0
      }
    }
    endShape();
  } // countCarsCurve


  void printDump() {
    println("timestamp, recnum, samplesize, segment, milemarker works as expected");
    for (int i=0; i<TXDOTrecords.size(); i++ ) {
      print("\n", TXDOTrecords.get(i).timestamp +" "+TXDOTrecords.get(i).recnum+" "+TXDOTrecords.get(i).sampleSize); //this seems to get the timestamp
      for (int j=1; j<=29; j++) {
        print(", "+TXDOTrecords.get(i).segment[j]+"/"+TXDOTrecords.get(i).originMileMarker[j]+"/"+TXDOTrecords.get(i).avgSpeed[j]+"/"+TXDOTrecords.get(i).countCars[j]);
      }
    }
    println("\nTXDOTrecords=", TXDOTrecords.size());
  }


  void clock(int i) {
    stroke(10);
    smooth();
    fill(145);
    noStroke();
    hourofday = float(getDate(TXDOTrecords.get(i).timestamp, "hour"));
    minuteofday = float(getDate(TXDOTrecords.get(i).timestamp, "minute"));
    shapeMode(CENTER);
    pushMatrix();
    translate(width - (width*(1-uiWidth)/2), height*.4);
    ellipse(0, 0, 150, 150);

    float m = map(minuteofday, 0, 60, 0, TWO_PI) - HALF_PI;
    float h = map((hourofday+minuteofday/60) % 12, 0, 12, 0, TWO_PI) - HALF_PI;

    strokeWeight(6);
    stroke(getColor.index(int(hourofday)));
    line(0, 0, cos(h) * 50, sin(h) * 50 );

    stroke(255);
    strokeWeight(2);
    line(0, 0, cos(m) * 60, sin(m) * 60 );
    popMatrix();
    shapeMode(CORNER);
  }
} 