void opencsv(String csvFile) {

  String timestamp;
  String[] crossStreet;
  int[] tempsegment;
  int[] temporiginMileMarker;
  float[] temptotalSpeed;
  float[] temptotalCars;
  float[] tempcountCars;
  float[] tempavgSpeed;
  int timeStampSamples =0;
  String sampleStartTime ="";
  int recSetCount = 0;
  boolean firstPassDone=false;
  Table table;

  tempsegment = new int[30];  
  temporiginMileMarker = new int[30];
  tempavgSpeed = new float[30];
  temptotalSpeed = new float[30];
  temptotalCars = new float[30];
  tempcountCars = new float[30];
  crossStreet = new String[30];
  table = loadTable(csvFile, "header");

  println("TableRowCount=", table.getRowCount());

  // actual data has seconds but the data was saved into CSV files in small timespans and put back together using Excel, which stripped the seconds, so need to average the time over the number of samples, should be two samples per minute but sometimes there is just one.
  // AND I this belongs in a method, I tried to create a TXDOTrecords.load() but got completely lost in how to do it.

  for (TableRow row : table.rows() ) {
    timestamp    = row.getString("timestamp");

    // initialize the first sampleStartTime    
    if (sampleStartTime.equals("")) {
      timeStampSamples=0;
      recSetCount = 1;
      sampleStartTime = timestamp;
    }

    // if same timestamp, new set of records, increment sample counter each time we see road segment =1
    if ( sampleStartTime.equals(timestamp) && row.getInt("segment")== 1) {
      timeStampSamples ++;
    }

    // if new timestamp then write the previous averages to TXDOTrecords 
    if ( firstPassDone && !sampleStartTime.equals(timestamp) && row.getInt("segment")== 1) {      // coudn't figure out how to reference the timestamp in row+1 so I don't know I have new data till I'm in the next block of data so that is when I right the previous block
      TXDOTrecords.add(new TXDOTrecord(sampleStartTime, recSetCount, timeStampSamples, tempsegment, temporiginMileMarker, tempavgSpeed, tempcountCars, crossStreet));
      timeStampSamples = 1;
      sampleStartTime = timestamp; 
      recSetCount ++;

      // set the temp arrays to zeros
      for (int k=0; k<30; k++) {
        temptotalSpeed[k]=0.0;  //Need to zero this each time we get a new timestamp since we don't know how many records we will divide this by to get avgSpeed
        temptotalCars[k]=0.0;   //same here
      }
    }

    temporiginMileMarker[row.getInt("segment")] =  row.getInt("originMileMarker");
    crossStreet[row.getInt("segment")]          =  row.getString("originCrossStreet");
    tempsegment[row.getInt("segment")]          =  row.getInt("segment");
    temptotalSpeed[row.getInt("segment")]       += row.getInt("avgSpeed");                                  //Adds speed
    tempavgSpeed[row.getInt("segment")]         =  temptotalSpeed[row.getInt("segment")]/timeStampSamples;      //divide by samples to get avg speed
    temptotalCars[row.getInt("segment")]        += row.getInt("countCars");                                //for current timestamp, adds current segment cars to total cars for that segment
    tempcountCars[row.getInt("segment")]        =  temptotalCars[row.getInt("segment")]/timeStampSamples;      //averages cars based on number of samples in this timestamp
    if (tempcountCars[row.getInt("segment")] >0) {
      if (tempcountCars[row.getInt("segment")] > maxcars) { 
        maxcars = tempcountCars[row.getInt("segment")];
      }
      if (tempcountCars[row.getInt("segment")] < mincars) { 
        mincars = tempcountCars[row.getInt("segment")];
      }
    }
    if (tempavgSpeed[row.getInt("segment")] >0) {
      if (tempavgSpeed[row.getInt("segment")] > maxspeed) { 
        maxspeed = tempavgSpeed[row.getInt("segment")];
      }
      if (tempavgSpeed[row.getInt("segment")] < minspeed) { 
        minspeed = tempavgSpeed[row.getInt("segment")];
      }
    }
    // Makes sure we have all 29 segments before creating he first TXDOTrecords object 
    if ( !firstPassDone && row.getInt("segment") ==29) {
      firstPassDone = true;
    }
    //      } // temp if statement to limit number of elements in the objects
  }  //for tablerow
}