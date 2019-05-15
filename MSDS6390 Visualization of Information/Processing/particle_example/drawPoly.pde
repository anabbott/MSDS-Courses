void drawPoly(float radius, int sides, float strokeWt, color fillCol) {
  float theta = 0, x2 = 0, y2 = 0;
  strokeWeight(strokeWt);
  float rotAmount = TWO_PI/sides;
  fill(fillCol);

  beginShape();
  for (int i = 1; i <= sides; i++) {
    x2 = x + cos(theta) * radius;
    y2 = y + sin(theta) * radius;
    vertex(x2, y2);
    theta += rotAmount;
  }
    endShape(CLOSE);
  }