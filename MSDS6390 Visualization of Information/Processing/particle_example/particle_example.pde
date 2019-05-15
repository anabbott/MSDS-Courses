float x, y;
float radius = 20;
float speedX, speedY;

void setup() {
  size(600, 600);
  x = width/2;
  y = 20;
  speedX = 1.3;
  speedY = 3.2;
}

void draw() {
  background(255);
  drawPoly(25, 6, 3, color(200, 200, 0));
  moveParticle();
  checkCollisions();
}