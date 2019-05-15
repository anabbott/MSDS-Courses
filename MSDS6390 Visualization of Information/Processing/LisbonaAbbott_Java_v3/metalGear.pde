class metalGear extends Gear { //<>//
  PShape gearSVG = super.gearSVG;
  //  PImage img = loadImage("metal.jpg");

  metalGear() {
  }

  metalGear(int teeth, int x, int y, int direction) {
    super();
    this.teeth = teeth;
    this.x = x;
    this.y = y;
    this.direction = direction;


    switch(teeth) {
    case 12:
      gearSVG = loadShape("Gear12.svg");
      break;
    case 18:
      gearSVG = loadShape("Gear18.svg");
      break;
    case 24:  
      gearSVG = loadShape("Gear24.svg");
      break;
    case 36:
      gearSVG = loadShape("Gear36.svg");
      break;
    case 72:
      gearSVG = loadShape("Gear72.svg");
      //gearSVG.setTexture(img); 
      break;
    case 144:
      gearSVG = loadShape("Gear144.svg");
      break;
    case 360:
      gearSVG = loadShape("Gear360.svg");
      break;
    }

    gearSVG.disableStyle();

    strokecolor =(random(50, 100));
    fillcolor.x = random(20, 100);
    z= int(random(z_min, z_max));
  }


  void display() {
    rotation += direction*(frameCount%TWO_PI/teeth)*rotationRate;
    noStroke();
    pushMatrix();
    beginShape();
    // texture(img);
    translate(x, y, z);
    rotate(rotation);
    fill(fillcolor.x);
    shape(gearSVG, 0, 0);
    endShape();
    popMatrix();
  }
}