class colorGear extends Gear {
  PShape gearSVG = super.gearSVG;

  colorGear() {
  }

  colorGear(int teeth, int x, int y, int direction) {
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
    fillcolor.x = random(0, 255);
    fillcolor.y = random(0, 255);
    fillcolor.z = random(0, 255);
    z= int(random(z_min, z_max));
  }


  void display() {
    rotation += direction*(frameCount%TWO_PI/teeth)*rotationRate;
    noStroke();
    pushMatrix();
    beginShape();
    translate(x, y, z);
    rotate(rotation);
    fill(fillcolor.x, fillcolor.y, fillcolor.z, 255);
    shape(gearSVG, 100, 100);
    endShape();
    popMatrix();
  }
}