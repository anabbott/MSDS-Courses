void checkForNewData() {
  // Doc describing data source
  // https://data.texas.gov/download/f6mt-vx3q/application%2Fpdf
  // Load RSS feed  
  
  try {
  traffic = loadXML("http://tti-i35-data.tamu.edu/data/awam/i35/i35_bluetooth_traveltimes_out.xml");
  } catch (Exception e) {
    println("xml error",e);
    return;
  }
  
  XML[] roads =  traffic.getChildren("match_summary");
  String timestamp;
  String systemID;
  String direction;

  
  int    obs = 0;
  String road;
  int    travelTimeSec;
  float  travelDistance ;
  int    countCars ;
  int    avgSpeed;
  String originCrossStreet ;
  String destCrossStreet;
   
  ttlCountCars = 0;
  
      timestamp = roads[1].getChild("timestamp").getContent();
      currentTimestamp = timestamp;
      
      if (currentTimestamp.equals(prevTimestamp)) { 
     //   println(currentTimestamp , "exiting Loop");
       
       } else {
        //println("newTimestamp",currentTimestamp);
         processXML = true;
         newXML = true;
         row = 0;
         col = col + 1;
       }
  
  if (processXML == true) {
    println(col," Found New Data at time=", timestamp);
      for (int i = 0; i < roads.length; i++) {  
      
          
          timestamp = roads[i].getChild("timestamp").getContent();
          systemID = roads[i].getChild("system_id").getContent();
          direction = roads[i].getChild("origin_direction").getContent();
          originCrossStreet    = roads[i].getChild("origin_cross_street").getContent();
          destCrossStreet    = roads[i].getChild("dest_cross_street").getContent();
             
            try {
            originMileMarker     = Integer.parseInt(originCrossStreet.substring(originCrossStreet.indexOf("(")+4,originCrossStreet.indexOf(")")));
            } catch (Exception e){
              originMileMarker = 0;
            }
           
                    
            try {
             destMileMarker     = Integer.parseInt(destCrossStreet.substring(destCrossStreet.indexOf("(")+4,destCrossStreet.indexOf(")")));
             } catch (Exception e){
               destMileMarker = 0;
            }
            
        if (systemID.equals("I35-Primary-WAC") && direction.equals("Northbound") && (destMileMarker > originMileMarker) && (destMileMarker > 290)) {  // just get cars on the primary route per the API recommendation
             row = row +1;
             road           = roads[i].getChild("origin_roadway").getContent();
             travelTimeSec  = constrain(roads[i].getChild("travel_time").getIntContent(),0,10000);
             travelDistance = roads[i].getChild("segment_length_miles").getFloatContent();
             countCars      = roads[i].getChild("summary_samples").getIntContent();
             avgSpeed       = constrain(roads[i].getChild("speed_mph").getIntContent(),0,100);
             ttlCountCars += countCars;
             meanSpeed += (countCars * avgSpeed); // weight the speed by the number of cars in this section of road
             obs ++;
             if (countCars > maxCars) {
               maxCars = countCars;
             }
           //  println(timestamp + " MM "+ originMileMarker + " Dest "+ destMileMarker + " Distance " + travelDistance + " TravelTime " + travelTimeSec + " cars="+countCars+" avgSpeed="+ avgSpeed +" "+ road + " " + originCrossStreet);
       
       // add values to lists
       
      // println(row, col,originMileMarker);
      
             TimeStamp[row][col] =timestamp;  
             OriginCrossStreet[row][col] =originCrossStreet;
             MileMarker[row][col] =originMileMarker;
             TravelTimeSec[row][col] = travelTimeSec;
             CountCars[row][col] =countCars;
             AvgSpeed[row][col] =avgSpeed;
                      
            } // if segment on I-35 Northbound
     } // for roads.length
      }
 processXML = false;
 prevTimestamp = currentTimestamp;
 meanSpeed = round(meanSpeed/ttlCountCars);  // divide by total number of cars to get weighted mean speed
  
}