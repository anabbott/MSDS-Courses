import ddf.minim.*; //<>//
Minim minim;
AudioPlayer file = null;

PImage[] images = new PImage[5];
PImage displayImage;

boolean runLoop = true;

int canvasHeight = 1000; // sets max height
int canvasWidth = 1000; //  gets reset later to scale of max height using actual image width
float resizeFactor = 1;
 
int currentImage = 0;
int nextImage = 1;

int maxIter=20;  // smaller number = faster transition
int iter = 0;
int pixel = 0;
int pix;

int square = 1;
int displayX = 0;
int displayY = 0;
int pixelStart;
int pixelEnd;

void setup() {
//file = new SoundFile(this, "eric-mcclure-tendril.mp3");
minim = new Minim(this);
file = minim.loadFile("comma-king-smile-through-the-stars.mp3", 2048);

file.play();
  size(1200, 800);  // initial size, gets changed to size of images[0]
  surface.setResizable(true);

  for (int i=0; i<images.length; i++) {
    images[i] = loadImage("Class"+i+".JPG");
  }

  resizeFactor = float(canvasHeight)/images[0].height;
  canvasWidth = int(images[0].width * resizeFactor);
  canvasHeight = int(images[0].height * resizeFactor);
  println("resize", resizeFactor);
  println("Canvas", canvasWidth, canvasHeight);

  for (int i=0; i<images.length; i++) {
    images[i].resize(canvasWidth, canvasHeight);
    images[i].loadPixels();
    println("image", i, images[i].width, images[i].height, images[i].pixels.length); // verify the images are the same size
  }

  surface.setSize(canvasWidth, canvasHeight);
  displayImage = createImage(images[0].width, images[0].height, RGB);
   displayImage.loadPixels();
}

void mousePressed(){
 if (mouseButton == LEFT  ) {
   runLoop = true;
 }
 if (mouseButton == RIGHT) {
   runLoop = false;
 }
}

void mouseWheel(MouseEvent event){
 int e = event.getCount();
 maxIter = constrain(maxIter - e, 0,100);
 println(e);
  
}

void draw() {
  displayMousePosition();
  image(displayImage, 0, 0);
  
 if (runLoop == true) {
  if (mouseX < canvasWidth/4 & mouseY < canvasHeight/4) {
    square = 1;
    displayX = 0;
    displayY = 0;
  } else if (mouseX < canvasWidth/2 & mouseY < canvasHeight/4) {
    square = 2;
    displayX = canvasWidth/4;
    displayY = 0;
  } else if (mouseX < canvasWidth*3/4 & mouseY < canvasHeight/4) {
    square = 3;
    displayX = canvasWidth/2;
    displayY = 0;
  } else if (mouseX < canvasWidth & mouseY < canvasHeight/4) {
    square = 4;
    displayX = canvasWidth*3/4;
    displayY = 0;
  } else if (mouseX < canvasWidth/4 & mouseY < canvasHeight/2) {
    square = 5;
    displayX = 0;
    displayY = canvasHeight/4;
  } else if (mouseX < canvasWidth/2 & mouseY < canvasHeight/2) {
    square = 6;
    displayX = canvasWidth/4;
    displayY = canvasHeight/4;
  } else if (mouseX < canvasWidth*3/4 & mouseY < canvasHeight/2) {
    square = 7;
    displayX = canvasWidth/2;
    displayY = canvasHeight/4;
  } else if (mouseX < canvasWidth & mouseY < canvasHeight/2) {
    square = 8;
    displayX = canvasWidth*3/4;
    displayY = canvasHeight/4;
  } else if (mouseX < canvasWidth/4 & mouseY < canvasHeight*3/4) {
    square = 9;
    displayX = 0;
    displayY = canvasHeight/2;
  } else if (mouseX < canvasWidth/2 & mouseY < canvasHeight*3/4) {
    square = 10;
    displayX = canvasWidth/4;
    displayY = canvasHeight/2;
  } else if (mouseX < canvasWidth*3/4 & mouseY < canvasHeight*3/4) {
    square = 11;
    displayX = canvasWidth/2;
    displayY = canvasHeight/2;
  } else if (mouseX < canvasWidth & mouseY < canvasHeight*3/4) {
    square = 12;
    displayX = canvasWidth*3/4;
    displayY = canvasHeight/2;
  } else if (mouseX < canvasWidth/4 & mouseY < canvasHeight) {
    square = 13;
    displayX = 0;
    displayY = canvasHeight*3/4;
  } else if (mouseX < canvasWidth/2 & mouseY < canvasHeight) {
    square = 14;
    displayX = canvasWidth/4;
    displayY = canvasHeight*3/4;
  } else if (mouseX < canvasWidth*3/4 & mouseY < canvasHeight) {
    square = 15;
    displayX = canvasWidth/2;
    displayY = canvasHeight*3/4;
  } else if (mouseX < canvasWidth & mouseY < canvasHeight) {
    square = 16;
    displayX = canvasWidth*3/4;
    displayY = canvasHeight*3/4;
  } else {
    square = 1;
    displayX = 0;
    displayY = 0;
  }
 // println(square);  
  


  iter ++;
  pixelStart = displayX + canvasWidth * displayY;
  pixelEnd = (displayX + canvasWidth/4) + ((displayY + canvasHeight / 4) * canvasHeight);
  
  
  for (int line=0; line < canvasHeight/4; line++) {
    for (int pix=0; pix< canvasWidth/4; pix++) {
      //iterateColor(PImage sourceArrayName, PImage targetArrayName, int currentIter, int maxIter, int currentPixel) {
        pixel = pixelStart + pix + line * canvasWidth; 
        iterateColor( images[currentImage], images[nextImage], iter, maxIter, pixel) ;
      }
    }  // finish one pass through all pixels
  
  displayImage.updatePixels();  // this doesn't seem to update the display like I thought it would
 
  if (iter >= maxIter) {
    iter = 0;
    currentImage = currentImage +1;
    nextImage = currentImage + 1;
    currentImage = currentImage % images.length;
    nextImage = nextImage % images.length;
  }
  
  }
}


void iterateColor(PImage sourceArrayName, PImage targetArrayName, int currentIter, int maxIter, int currentPixel) {
  
  float r = (red(sourceArrayName.pixels[currentPixel])   +((red(targetArrayName.pixels[currentPixel])   - red(sourceArrayName.pixels[currentPixel])))   *currentIter/maxIter);
  float g = (green(sourceArrayName.pixels[currentPixel]) +((green(targetArrayName.pixels[currentPixel]) - green(sourceArrayName.pixels[currentPixel]))) *currentIter/maxIter);
  float b = (blue(sourceArrayName.pixels[currentPixel])  +((blue(targetArrayName.pixels[currentPixel])  - blue(sourceArrayName.pixels[currentPixel])))  *currentIter/maxIter);
  float a = (alpha(sourceArrayName.pixels[currentPixel]) +((alpha(targetArrayName.pixels[currentPixel]) - alpha(sourceArrayName.pixels[currentPixel]))) *currentIter/maxIter);
    

  displayImage.pixels[currentPixel] = color(r, g, b, a);  // assigns new image the intermediate pixel values
  
}    