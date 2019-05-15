class ColorRGB {
  color[] rgb = new color[25];
  int i;

  ColorRGB() {
    rgb[0]= color(0, 0, 0)       ;    
    rgb[1]= color(49, 3, 250);     
    rgb[2]= color(112, 5, 251);    
    rgb[3]= color(175, 7, 251);    
    rgb[4]= color(237, 9, 252);    
    rgb[5]= color(252, 11, 205);   
    rgb[6]= color(252, 13, 145);   
    rgb[7]= color(253, 15, 87);    
    rgb[8]= color(253, 17, 28);    
    rgb[9]= color(253, 68, 19);    
    rgb[10]= color(254, 128, 21);  
    rgb[11]= color(254, 188, 23);  
    rgb[12]= color(3, 255, 17);  
    rgb[13]= color(255, 246, 25);  
    rgb[14]= color(254, 188, 23);  
    rgb[15]= color(254, 128, 21);  
    rgb[16]= color(253, 68, 19);   
    rgb[17]= color(253, 17, 28);   
    rgb[18]= color(253, 15, 87);   
    rgb[19]= color(252, 13, 145);
    rgb[20]= color(252, 11, 205);  
    rgb[21]= color(237, 9, 252);   
    rgb[22]= color(175, 7, 251);   
    rgb[23]= color(112, 5, 251);   
    rgb[24]= color(49, 3, 250);
  }

  //constructor
  ColorRGB( int i) {
    this.i = i;
  }

  color index(int i) {   
    return rgb[i];
  }
}