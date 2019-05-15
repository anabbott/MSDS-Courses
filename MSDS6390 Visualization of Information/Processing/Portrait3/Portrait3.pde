
// MSDS 6390 Visualization of information
// Portrait 2, Randy Lisbona Andrew Abbott 5/25/2017

float pppmouseX, pppmouseY, ppmouseX, ppmouseY;
float pppX, pppY, ppX, ppY,pX,pY;

float X,Y;
float easing = .50; // factor to smooth lines, takes out mouse shakes

PImage img;
boolean ctrl;


String option1 = "ctrl-s                  = Save Image\n";
String option2 = "ctrl-leftMouse    = Eraser\n";
String option3 = "ctrl-c                  = Clear Canvas\n";
String option4 = "UP                     = Increase StrokeWeight\n";
String option5 = "DOWN               = Decrease StrokeWeight";
String menutext = option1 + option2 + option3 + option4 + option5;
boolean mouseReset = false;

int strokeDim = 2;
String strokeSize = "StrokeWeight";
PFont font;


void setup() {
 //  background(52,73,40);  // dollar bill green, still pondering how to shade it using this
  background(255);
  size(1000,1500);
  surface.setResizable(true);
  img = loadImage("profile2.jpg");
  img.resize(861, 812);
  surface.setSize(img.width*2,img.height + 200);  // this could be more dynamic, basically just doubling the width
//  background(img);  //can't load it as a background unless it fills the frame.

//  println("Left mouse draws when on photo, erases when in portrait area");
//  println("Right click mouse to save a snapshot of the screen to sketch folder");
//font = loadFont("ArialMT-48.vlw");
font = createFont("Arial",32);
strokeSize = "StrokeWeight =" + strokeDim;

}


void draw() {
  image(img,0,0);  
  fill(255);
  noStroke(); // clear menu area
   rect(0,img.height,img.width,img.height + 200);
   
  fill(0,0,0);
   textFont(font);
   textSize(26);
    text(strokeSize,575,1690);
    text(menutext,10,img.height +10,img.width,img.height+100);
    text(mouseX % img.width,10,img.height -10 );
    text(mouseY,10+100,img.height -10);
  fill(255);
  if(mouseX < img.width) {
    cursor(ARROW);
  }
    strokeWeight(strokeDim+2);
    stroke(255);
    line(800,1680 ,1000,1680);
    stroke(0);
    strokeWeight(strokeDim);
    line(800,1680,1000,1680);
    
  if(mousePressed == false && mouseX < img.width - strokeDim && mouseY  < img.height - strokeDim){ // draw while mousepressed in photo area
       strokeWeight(1);
       noFill();
       ellipse(mouseX, mouseY,strokeDim,strokeDim);
    
  }
  if(mouseReset == true && mousePressed && mouseX < img.width - strokeDim && mouseY < img.height - strokeDim){ // draw while mousepressed in photo area
    
    stroke(0);
    strokeWeight(strokeDim);
       
    beginShape();  //mouse path in photo area
     curveVertex(pppX,pppY);
     curveVertex(ppX,ppY);
     curveVertex(pX,pY);
     curveVertex(X,Y);

    endShape();
 
    //  smoothed drawing in portrait area

    beginShape();
     curveVertex(pppX+img.width,pppY);
     curveVertex(ppX+img.width,ppY);
     curveVertex(pX+img.width,pY);
     curveVertex(X+img.width,Y);
    endShape();

          
  } // if mousepressed in photo area
  
 if(mouseReset == true && mousePressed && mouseX > img.width && mouseY < img.height ){ 
 
   if (ctrl == true){   // erase while mousepressed in self portrait area
     cursor(HAND);
     stroke(255);
     strokeWeight(20);  // could use keyboard commands to change this size, would be nice to show size of eraser but haven't figured that out.
   }
   else {
     cursor(ARROW);
     stroke(0);
     strokeWeight(strokeDim);
   }
       
    beginShape();  // portrait side
     curveVertex(pppX,pppY);
     curveVertex(ppX,ppY);
     curveVertex(pX,pY);
     curveVertex(X,Y);
    endShape();
            
  } // if mousepressed in Self Portrait area 
    //otherwise keep track of mouse position
    // smoothing function to smooth lines drawn with shaky hands
    float targetX = mouseX;
    float dx = targetX - X;
    X += dx * easing;
  
    float targetY = mouseY;
    float dy = targetY - Y;
    Y += dy * easing;
  // calculate points to use in drawing smooth lines  
    pppX = ppX;
    pppY = ppY;
    ppX = pX;
    ppY = pY;
    pX = X;
    pY = Y;
  // calculate points of actual mouse path.  
/*  pppmouseX = ppmouseX;
  pppmouseY = ppmouseY;
  ppmouseX = pmouseX;
  ppmouseY = pmouseY;*/
}

void keyPressed(){     
      //    println("keycode",keyCode,"key", key);

  if (keyPressed) {
       //if (key == CODED){
         if (keyCode == 83) { // ctrl-s save it
             PImage imgCrop = get(0,0,img.width*2,img.height);
             imgCrop.loadPixels();
             imgCrop.save("save-#####.jpg"); 
             saveFrame("Image-######.jpg");  
             println("Framed Saved");     
         }
         
         if (keyCode == 67) {  // ctrl-c clear drawing area
           fill(255);
           rect(img.width,0,img.width*2,img.height);
         }
         
         if (keyCode == 17){ // ctrl pressed
             ctrl = true;
          } else if (keyCode == UP) {  // UP increase strokeWeight
       //       println("keycode UP",keyCode);
              strokeDim = strokeDim + 1;
          } else if (keyCode == DOWN) { // DOWN increase strokeWeight
             strokeDim = strokeDim - 1;
          }  
           if (strokeDim == 0) { 
               strokeDim = 1;
           } 
            strokeSize = "StrokeWeight =" + strokeDim;
       }
}


void keyReleased(){
       ctrl = false;
       //  println("keycode",keyCode,ctrl);
}

void mouseReleased(){
    mouseReset = false;
    cursor(ARROW);
}


void mousePressed() {
    pppX = mouseX;
    pppY = mouseY;
    ppX =  mouseX;
    ppY =  mouseY;
    pX =   mouseX;
    pY =   mouseY;
    mouseReset = true;
}