String getDate(String timestamp, String datepart) {
  String returnval;
  //  tried using java data format but could not get it to recognize my dates as a date  

  String[] date = split(timestamp, ' ');  
  String datePart = date[0];
  String time = date[1];
  String[] dateYYMMDD = split(datePart, "/");
  int year = Integer.parseInt(dateYYMMDD[0]);
  int month = Integer.parseInt(dateYYMMDD[1]);
  int day = Integer.parseInt(dateYYMMDD[2]);
  String[] timeHHMMSS = split(time, ":");
  int hour = Integer.parseInt(timeHHMMSS[0]);
  int minute = Integer.parseInt(timeHHMMSS[1]);
  //  int second = Integer.parseInt(timeHHMMSS[2]);
  if (datepart.equals("dayhour")==true) {
    returnval = datePart+ " "+ hour+" hours"; 
    return returnval;
  } 
  if (datepart.equals("hour")==true) {
    return str(hour);
  } 
  if (datepart.equals("minute")==true) {
    return str(minute);
  } else return "00";
}