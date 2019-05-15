void calcGearPosition() {
  float mouseXpos, mouseYpos;
  
  mouseXpos = constrain(mouseX, 50, chartOriginX + chartWidth-85);

  dx = (mouseXpos -targetX) * 0.9; 
  targetX = constrain(mouseXpos - dx, 50, chartOriginX + chartWidth-85);
  dxHook = dx * 1.25; 
  targetHookX = constrain(mouseXpos - dxHook, 50, chartOriginX + chartWidth-87);
  theta = atan2(250, abs((targetX-targetHookX)-width/2))-PI/2;
  hookY =  -250* sin(theta);
  hookX = -targetHookX* cos(theta);

  if (selectedBar != null && selectedBar.y >0) {
    barTop = chartOriginY + chartHeight- map(GDP[(int(selectedBar.x))], 0, chartYAxisRange, 20, chartHeight-22);
  } else if (mouseX < chartOriginX) {
    barTop = 200;
  }

  // add friction for the pointer
  if (barTop > targetHookY) {
    dy = (barTop -targetHookY ) *0.1; // slow when dropping
  } else {
    dy = (barTop -targetHookY ) *0.25; // fast when rising
  }
  
  targetHookY = targetHookY + dy;
  pointerPoint = new PVector(targetHookX, targetHookY);
  pointerSelectedBar = barChart.getScreenToData(pointerPoint);
  if (pointerSelectedBar != null) {
  pointerBarTop = chartOriginY + chartHeight- map(GDP[(int(pointerSelectedBar.x))], 0, chartYAxisRange, 20, chartHeight-22);
  println(pointerBarTop);
  } else {
    pointerBarTop = height;
  }
  
  targetHookY = constrain(targetHookY + dy,200,pointerBarTop); //makes sure it doesn't get lower than top of the bar it it pointing at
}

void drawGear(PShape gearName, float rotation, float targetX) {
  pushMatrix();

  translate(targetX, .08*height/2);
  rotate(rotation);
  shape(gearName, 0, 0);
  popMatrix();
  //draw pointer
  strokeWeight(5);
  // if (barTop < chartOriginY + chartHeight && selectedBar != null) {

  line(targetX, .08*height/2, targetHookX, targetHookY-5);
  // draw arrow
  strokeWeight(7);
  line(targetHookX - 20, targetHookY-5 -20, targetHookX, targetHookY-5);
  line(targetHookX + 20, targetHookY-5 -20, targetHookX, targetHookY-5);
  // }
}

void drawRack(PShape shapeName, float offset) {
  shape(shapeName, offset+width/2, .08*height/2+53);
}