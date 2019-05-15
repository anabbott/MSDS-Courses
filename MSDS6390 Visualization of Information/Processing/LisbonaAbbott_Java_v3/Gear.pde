abstract class Gear {
  PShape gearSVG;
  int teeth;
  int x, y, z, direction;
  PVector fillcolor = new PVector();
  float strokecolor;
  float rotation=0;

  Gear() {
  }

  abstract void display();
}