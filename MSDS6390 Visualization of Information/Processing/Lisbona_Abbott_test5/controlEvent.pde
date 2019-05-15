void controlEvent(ControlEvent theEvent) {
  println("got a control event from controller with id "+theEvent.getController().getId());

  switch(theEvent.getController().getId()) {
    case(1): // delay slider
    delayTime = int(theEvent.getController().getValue());
    println("DelayTime ", delayTime); 
    //  myColorRect = (int)(theEvent.getController().getValue());
    break;
    case(2): //fade
    //   myColorBackground = (int)(theEvent.getController().getValue());
    break;
    case(3):  // background color
    println(theEvent.getController().getStringValue());
    println("BackgroundColor ", cp5.getValue("BackgroundColor"));
    break;

    case(4): // run pause button
    println(theEvent.getController().getStringValue());

    if (paused) {
      theEvent.getController().setCaptionLabel("RUN");
      theEvent.getController().setColorBackground(color(0, 255, 0));
      if (j==TXDOTrecords.size()-1 || j==startRecord) { 
        theEvent.getController().setColorForeground(color(0, 255, 0));
        fill(int(cp5.getValue("BackgroundColor")));
        j=startRecord;
        incrementer = abs(incrementer);
      }
      rect(0, 0, width, height);
    } else {
      theEvent.getController().setCaptionLabel("PAUSED");
      theEvent.getController().setColorBackground(color(255, 0, 0));
      theEvent.getController().setColorForeground(color(255, 0, 0));
      incrementer = incrementer*-1;
    }

    paused = !paused;
    break;
  }
}