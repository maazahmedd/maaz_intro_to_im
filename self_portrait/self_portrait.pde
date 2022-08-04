int centerX;
int centerY;
int faceCenter;
float faceWidth = 140;
float faceHeight = 175;

void setup() {
  size(640, 480);
  background(255, 255, 0);
  centerX = width / 2;
  centerY = height / 2;
}


void draw() {
  face();
  nose();
  hair();
  eyes();
  lips();
  body();
}

void face() {
  fill(247, 194, 168);
  noStroke();
  //ellipse(centerX, centerY - 45, faceWidth, faceHeight);
  rect(260, 140, 120, 90);
  arc(320, 230, 120, 70, 0, PI);
  ellipse(385, 180, 20, 25);
  ellipse(255, 180, 20, 25);
  noFill();
  stroke(255, 160, 180);
  ellipse(253, 180, 10, 15);
  ellipse(386, 180, 10, 15);
}

void nose() {
  stroke(0);
  strokeWeight(1);
  line(centerX, centerY - 55, centerX - 7, centerY - 35);
  line(centerX, centerY - 55, centerX + 7, centerY - 35);
  line(centerX - 7, centerY - 35, centerX, centerY - 33);
  line(centerX + 7, centerY - 35, centerX, centerY - 33);
}

void hair() {
  fill(0);
  arc(320, 140, 118, 50, PI, PI*2);
  triangle(260, 140, 360, 150, 379, 140);
  //the two lines below can be used to present another version of the hair
  //arc(290, 140, 60, 25, 0, PI);
  //arc(350, 140, 60, 25, 0, PI);
}

void eyes() {
  stroke(0);
  noFill();
  strokeWeight(2);
  arc(290, 170, 25, 10, PI, PI*2);
  arc(350, 170, 25, 10, PI, PI*2);
  strokeWeight(1);
  ellipse(290, 178, 25, 10);
  ellipse(350, 178, 25, 10);
  fill(0);
  circle(290, 178, 5);
  circle(350, 178, 5);
}

void lips() {
  noFill();
  arc(320, 230, 32, 15, 0, PI);
  //line(300, 230, 340, 230);
  //arc(320, 230, 32, 10, PI, 2*PI);
  fill(220, 133, 146);
  arc(320, 230, 32, 48, PI, 2*PI);
  fill(247, 194, 168);
  arc(320, 230, 32, 10, PI, 2*PI);
}

void body() {
  noStroke();
  fill(247, 194, 168);
  rect(300, 262, 40, 40);
  fill(0, 255, 255);
}
