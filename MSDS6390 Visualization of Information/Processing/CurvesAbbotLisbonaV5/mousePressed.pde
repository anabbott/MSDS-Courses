void mousePressed() {  // click the left button to pause and restart feed
  if (mouseButton == LEFT  ) {
    pause = !pause;
    println("pause =", pause);
  }
}                                  