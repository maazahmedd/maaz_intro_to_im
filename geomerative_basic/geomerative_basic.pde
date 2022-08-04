import geomerative.*;
import processing.sound.*;
SoundFile file;

String audioName = "song.mp3";
String path;

RFont font; 
RPoint[] pnts, pnts2, pnts3, pnts4;
float xValue = 0;
float yValue = 0;
int a = 175;
int i = 0;
int j = 0;
int k = 0;
int l = 0;
int r = 255;
boolean b = true;
float xOffset = 0;
float xOffset2 = 0;
float xOffset3 = 0;
float xOffset4 = 0;
float diam = 20;
 
void setup(){
  frameRate(120);
  background(255);
  size (800, 800);
  path = sketchPath(audioName);
  file = new SoundFile(this, path);
  file.loop();
  RG.init(this);
  // set the font, the size, and left, center, or right adjusted
  font = new RFont("Franklin Goth Ext Condensed.ttf", 150, RFont.LEFT);
  
  // get the points along a String
  RCommand.setSegmentLength(1);
  RCommand.setSegmentator(RCommand.UNIFORMLENGTH);
  RGroup grp, grp2, grp3, grp4;
  grp = font.toGroup("This took me");
  grp = grp.toPolygonGroup();
  pnts = grp.getPoints();
  
  xOffset = width - grp.getBottomRight().x - grp.getBottomLeft().x;
  xOffset = xOffset/2;
  
  grp2 = font.toGroup("2 hours");
  grp2 = grp2.toPolygonGroup();
  pnts2 = grp2.getPoints();
  
  xOffset2 = width - grp2.getBottomRight().x - grp2.getBottomLeft().x;
  xOffset2 = xOffset2/2;
  
  grp3 = font.toGroup("--------");
  grp3 = grp3.toPolygonGroup();
  pnts3 = grp3.getPoints();
  
  xOffset3 = width - grp3.getBottomRight().x - grp3.getBottomLeft().x;
  xOffset3 = xOffset3/2;
  
  grp4 = font.toGroup("days");
  grp4 = grp4.toPolygonGroup();
  pnts4 = grp4.getPoints();
  
  xOffset4 = width - grp4.getBottomRight().x - grp4.getBottomLeft().x;
  xOffset4 = xOffset4/2;
  
  
  //System.out.println(pnts);
    
  noFill();
  //noLoop();
  //stroke(255, 0, 0, 75);
}

void update () {
  //stroke(random(0,255), random(0,255), random(0,255));
  stroke(r, r, 0, 75);
  if (i >= pnts.length && j >= pnts2.length && k < pnts3.length){
    stroke(50);
  }
  //noStroke();
  //fill(255, 0, 0)
  ellipse(xValue, yValue, diam, diam);
}
 
void draw() {
  //pushMatrix();
  //translate(width/2, height/2);
  //if ( millis() > previousTime + timePassed){
  //   previousTime= millis();
     //println("it works");
    //if ( i <pnts.length ){
      if (i < pnts.length){
        update();
        if (r >= 0 && b == true){
          r -= 1; 
          b = true; 
        }
        else if (r == 225 && b == false){
          r -= 1; 
          b = true; 
        }
        else {
          r +=1;
          b = false; 
        }
        //float diam = random(5,15);
        xValue =  pnts[i].x + xOffset;
        yValue = pnts[i].y + height/2 - 150;
        i++;
      }
      
      if (i >= pnts.length){
        if (j < pnts2.length){
        update();
        if (r >= 0 && b == true){
          r -= 1; 
          b = true; 
        }
        else if (r == 225 && b == false){
          r -= 1; 
          b = true; 
        }
        else {
          r +=1;
          b = false; 
        }
        //float diam = random(5,15);
        xValue =  pnts2[j].x + xOffset2;
        yValue = pnts2[j].y + height/2;
        j++;
        }
        
      if (i >= pnts.length && j >= pnts2.length){
        if (k < pnts3.length){
          update();
        if (r >= 0 && b == true){
          r -= 1; 
          b = true; 
        }
        else if (r == 225 && b == false){
          r -= 1; 
          b = true; 
        }
        else {
          r +=1;
          b = false; 
        }
        //float diam = random(5,15);
        xValue =  pnts3[k].x + xOffset3 + 60;
        yValue = pnts3[k].y + height/2;
        k++;
        }
        
      if (i >= pnts.length && j >= pnts2.length && k >= pnts3.length){
        if (l < pnts4.length){
          update();
        if (r >= 0 && b == true){
          r -= 1; 
          b = true; 
        }
        else if (r == 225 && b == false){
          r -= 1; 
          b = true; 
        }
        else {
          r +=1;
          b = false; 
        }
        xValue =  pnts4[l].x + xOffset4;
        yValue = pnts4[l].y + height/2 + 150;
        l++;
        }
      }
      }
      }
        
}
 
void mousePressed(){
  xValue-=1;
  update();
}
