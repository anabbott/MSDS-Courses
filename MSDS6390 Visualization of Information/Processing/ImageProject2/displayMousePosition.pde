void displayMousePosition() {
  String title;
  color columnColor, rowColor, pointColor;
  PImage colStripe, rowStripe, pointShape;
  String colColors, rowColors, pointColors;
  int x,y;
  float avg;
  // debugging code to get mouse position if needed
  fill(0, 0, 0);
  x = mouseX;
  y = mouseY;
  colStripe = get(x, 0, 1, images[0].height);
  columnColor= getAverageColor(colStripe);
  avg = (int(red(columnColor))+ int(green(columnColor))+int(blue(columnColor)))/3.0 ;
  colColors = " /Col=(" + int(red(columnColor))+","+ int(green(columnColor))+","+ int(blue(columnColor))+")"+"_avg=" +round(avg) +" ";
  
  rowStripe = get(0,y, images[0].width,1);
  rowColor= getAverageColor(rowStripe);
   avg = (int(red(rowColor))+ int(green(rowColor))+int(blue(rowColor)))/3.0 ;
  rowColors = " /Row=(" + int(red(rowColor))+","+ int(green(rowColor))+","+ int(blue(rowColor)) +")"+"_avg=" +round(avg) +" ";
  
  pointShape = get(x,y, 2,2);
  pointColor= getAverageColor(pointShape);
   avg = (int(red(pointColor))+ int(green(pointColor))+int(blue(pointColor)))/3.0 ;
  pointColors = " /Point=(" + int(red(pointColor))+","+ int(green(pointColor))+","+ int(blue(pointColor)) +")"+"_avg=" +round(avg) +" ";
  
 title = "Rate="+ maxIter + " X="+mouseX+" Y="+mouseY + pointColors + rowColors + colColors ;
  surface.setTitle(title);
}


color getAverageColor(PImage img) {
  img.loadPixels();
  int r = 0, g = 0, b = 0;
  for (int i=0; i<img.pixels.length; i++) {
    color c = img.pixels[i];
    r += c>>16&0xFF;
    g += c>>8&0xFF;
    b += c&0xFF;
  }
  r /= img.pixels.length;
  g /= img.pixels.length;
  b /= img.pixels.length;
  return color(r, g, b);
}