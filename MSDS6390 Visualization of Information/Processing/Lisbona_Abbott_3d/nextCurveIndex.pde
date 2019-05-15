void nextCurveIndex() {
  if ( paused == false) {
    j =j + incrementer;


    if (j>=TXDOTrecords.size()-1 || j<=startRecord) { 
      incrementer = incrementer*-1; 
      paused = true;
      //    j=j+ incrementer;
      cp5.getController("Paused").setCaptionLabel("PAUSED");
      cp5.getController("Paused").setColorBackground(color(255, 0, 0));
      cp5.getController("Paused").setColorForeground(color(255, 0, 0));

      println("current value j=", j, " incrementer = ", incrementer);
    }
  }
}