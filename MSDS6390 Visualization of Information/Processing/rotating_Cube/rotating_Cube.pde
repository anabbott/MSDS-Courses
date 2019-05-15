

void setup(){
 size(600,600,P3D);
 frameRate(120);
  fill(90,45,0);
  noStroke();
  frameRate(360);
}

void draw(){
  background(127);
  fill(255);
 // rect(0, 0, width, height);  
println(-frameCount%6000);
  translate(width/2,height/2,-frameCount%6000);
  rotateY(radians(frameCount));
  rotateX(radians(frameCount)/2);
 lightSpecular(255,255,255);
 directionalLight(204,204,204,0,0,-1);
 specular(255,255,255);
 box(200);
 
}