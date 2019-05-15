Arm[] a = new Arm[10];

void setup() {
  size(1000, 1000);
  background(255);
  fill(200, 65, 200, 65);
  strokeWeight(1);

  for (int i = 0; i < 10; i ++) {
    a[i] = new Arm();
  }
}

void draw() {
  background(255);
  translate(width/2, height/2);
  for (int i = 0; i < 10; i ++) {
    a[i].render();
    rotate(radians(36));
  }
}

class Arm {
  float[] a = {0, 0, 0, 0};
  float[] aInc = {0.1, 0.25, 0.4, 0.55};
  int numCircles = 4;
  int numSides = 10;
  float rot = TWO_PI/numSides;
  public void render() {
    pushMatrix();
    for (int i = 0; i < numCircles; i ++) {
      rotate( radians( a[i] += aInc[i] ) );
      float radCircle = i*50;
      beginShape();
      for (int j=0; j<numSides * i; j++) {
        float angle = j * rot;
        float x = cos(angle);
        float y = sin(angle);
        vertex(x * radCircle, y* radCircle);
      }
      endShape(CLOSE);
      translate(75, 0);
    }
    popMatrix();
  }
}