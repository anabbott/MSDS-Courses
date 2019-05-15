void displayMousePosition() {
  String title;
  // debugging code to get mouse position if needed
  fill(0, 0, 0);
  title = "X="+mouseX+" Y="+mouseY +"pointerTop " +pointerBarTop  ;
  
  if (selectedBar != null) {
    title = title + " ChartBar="+(int(selectedBar.x));
  }
  surface.setTitle(title);
}