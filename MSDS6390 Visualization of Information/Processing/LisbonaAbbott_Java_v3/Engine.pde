class Engine {

  Gear[] gears;

  Engine() {
  }
  Engine(Gear[] gears) {
    this.gears = gears;
    for (int i=0; i < gears.length; i++) {
      gears[i].display();
    }
  }
}