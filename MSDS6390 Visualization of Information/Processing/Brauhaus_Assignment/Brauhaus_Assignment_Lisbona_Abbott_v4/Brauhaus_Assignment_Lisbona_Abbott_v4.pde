// Andrew Abbott, Randy Lisbona, homework 1

PImage img; //Image datatype, use loadImage to load it, loadPixels to populate pixels[] array
int xcoordinate;
                    
void setup(){
  size(100,100,P2D); // set an initial size
  surface.setResizable(true); // lets size be resizable
  img = loadImage("Herbert Bayer-Chromatic Twist 1970_1080.jpg"); // loads the image

//  int arraydimension = img.height * img.width; //not using this now but may need it
   print("Image size is ");
   print(img.width,img.height); //prints the width and height of the image
   colorMode(RGB,255);  // may not need this, it sets the range for each color from 0-255 
}

void mousePressed(){ // triggered on mouse release, use this to get corners of triangles and colors
     img.loadPixels();
     int col = img.pixels[mouseX + (mouseY*img.width)];// gets the color data for the mouse click coordinates
     int redval = round(red(col));
     int grnval = round(green(col));
     int bluval = round(blue(col));
     int alphaval = round(alpha(col));
     int hueval = round(hue(col));
     int brightval = round(brightness(col));
     int satval = round(saturation(col));

       // both left and right mouse do the same thing, I was using left for coordinates and right for color but it was easier to get them both
    if (mousePressed &&(mouseButton == LEFT)){
      xcoordinate = mouseX ;
    print("\nvertex("+ xcoordinate +","+ mouseY+") \tfill("+redval+","+ grnval+","+bluval+")");
    }
   
   if (mousePressed &&(mouseButton == RIGHT)){
      xcoordinate = mouseX ;
    print("\nvertex("+ xcoordinate +","+ mouseY+") \tfill("+redval+","+ grnval+","+bluval+")");
    }
}
  
void draw(){
  surface.setSize(2*img.width, img.height+125); //resets the window to fit the image
  image(img,0,0); //displays the image at position 0,0
  
  // setup some titles along the bottom of the image
  String title1 = "Original Image: Herbert Bayer, Chromatic Twist-1970";
  String title1a = "Size = "+img.width +"x"+img.height+" pixels";
  String title1b = "https://theartstack.com/artist/herbert-bayer/chromatic-twist?";
  String title2 = "Fake Version: Andrew Abbott, Randy Lisbona-2017";
  int titlerow = img.height + 50;
  int subtitlerow = img.height + 90;
  int titlecolRight = 100 + img.width;
  
  textSize(32);
  text(title1,100,titlerow);
  text(title2, titlecolRight, titlerow);
  textSize(24);
  text(title1a +"    Source: "+title1b,100, subtitlerow);

//can we load a script font so we can sign our fake?????

  
//Methodology, use mouse clicks to capture color and vertices, offset the fake version by the original image width in order to show the original and fake side by side.  

fill(212,214,211);//frame
rect(img.width+0,0,img.width+1086,1080);
fill(155,162,170);//gray areas
quad(img.width+18,13,img.width+24,1068,img.width+1072,1062,img.width+1072,18);
noStroke();

//top smudge, this is pretty subtle but there are definately some smudges
fill(173,66,244,13);
ellipseMode(CENTER);
ellipse(627+img.width,174,50,50);
ellipse(528+img.width,258,15,15);
triangle(img.width+943, 130, img.width+1029, 13, img.width+1068, 13);
triangle(img.width+999, 67, img.width+978, 13, img.width+1068, 13);


//left side <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
fill(242, 199, 42);//goldish
fill(223, 182, 28);//goldish
triangle(img.width+18, 13, img.width+442, 293, img.width+18, 190);

fill(11, 180, 63);//green
fill(76,174,39);//green
triangle(img.width+18, 190, img.width+547, 317, img.width+19, 369);

fill(90, 160, 112);//bluegreen 
fill(62, 149, 96);//bluegreen 
triangle(img.width+19, 369, img.width+652, 307, img.width+19, 543);

fill(97, 139, 132);//teal
fill(48,131,113);//teal
triangle(img.width+19, 543, img.width+759, 267, img.width+20, 720);

fill(67, 98, 93);//bluish
fill(24,87,102);//bluish
triangle(img.width+20, 720, img.width+872, 197, img.width+22, 895);

fill(14, 43, 113);//blue
fill(14, 47, 101);//blue
triangle(img.width+22, 895, img.width+971, 113, img.width+24, 1068);

//right side >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
fill(250, 198, 8);//golden
fill(223, 182, 28);//golden
triangle(img.width+24, 1068, img.width+1072, 13, img.width+1072, 190);

fill(232, 119, 5);//orange
fill(227,100,33);//orange
triangle(img.width+1072, 190, img.width+134, 976, img.width+1072, 365);

fill(216, 65, 4);//redorange
fill(223,54,35);//redorange
triangle(img.width+1072, 365, img.width+227, 915, img.width+1072, 540);

fill(188, 22, 4);//red
fill(179,25,27);//red
triangle(img.width+1072, 540, img.width+333, 868, img.width+1072, 714);

fill(65, 27, 103);//purple
fill(55,29,76);//purple
triangle(img.width+1072, 714, img.width+444, 845, img.width+1072, 888);

fill(39, 36, 142);//blue
fill(23,33,102);//blue
triangle(img.width+1072, 888, img.width+546, 852, img.width+1072, 1062);

}