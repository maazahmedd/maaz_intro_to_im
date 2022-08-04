int centerX;
int centerY;
float speedX, speedY;
int radius = 5;
int directionX = 1;

void setup() {
  size(640, 480);
  centerX = width/2;
  centerY = height/2;
  speedX = 10;
  speedY = 5;
}

void draw() {
  //background(255);
  speedX = map(mouseX, 0, width, 2, 12);
  centerX += speedX*directionX;
  centerY += speedY;
  
  ellipse(centerX, centerY, radius*2, radius*2);
  
  if (centerX > width - radius){
    directionX *= -1;
    centerX = width-radius;
    speedX*=-1;
  }
  else if (centerX <= 0 + radius){
    directionX *= -1;
    centerX = 0+radius;
  }
  
  if (centerY >= height - radius){
    speedY *= -1;
  }
  else if (centerY <= 0 + radius){
    speedY *= -1;
  }
}
