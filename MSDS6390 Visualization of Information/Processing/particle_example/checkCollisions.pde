void checkCollisions(){
  if ((x > width - radius) || (x < radius)) {
    speedX = speedX * -1;
  }
  
  if ((y > height - radius) || (y < radius)) {
    speedY = speedY * -1;
  }
}