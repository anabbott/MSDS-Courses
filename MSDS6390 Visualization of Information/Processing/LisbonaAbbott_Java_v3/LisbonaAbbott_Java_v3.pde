// Gear g, h,i; //<>//
float rotationRate = .025;
int[] toothcount = {12, 18, 24, 36, 72, 144};
int[] direction = {-1, 1};
int numGears = 100;
Gear[] grs = new Gear[numGears];
int dir;
int z_min = -4500;
int z_max = -500;
Engine e;



void setup() {
  fullScreen(P3D, 2); // the integer is the display number
  shapeMode(CENTER);
  frameRate(60);

  for (int i=0; i < grs.length; i++) {
    dir = direction[int(random(0, 1.99)) ];
    println(dir);
    if (i%3==0) {
      grs[i] = new metalGear(toothcount[int(random(0, toothcount.length))], int(random(width*-.25, width*1.25)), int(random(height*-.25, height*1.25)), dir);
    } else {
      grs[i] = new colorGear(toothcount[int(random(0, toothcount.length))], int(random(width*-.25, width*1.25)), int(random(height*-.25, height*1.25)), dir);
    }
  }
}


void draw() {
  clear();
  lights();
  directionalLight(0, 255, 0, 0, -1, 0);
  perspective();
  background(0);
  e = new Engine(grs);
}