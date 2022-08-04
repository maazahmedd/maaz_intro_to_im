import geomerative.*;
import processing.sound.*;
SoundFile file;

String audioName = "song.mp3";
String path;

RFont font; 
RPoint[] pnts, pnts2, pnts3, pnts4;
float xValue = 0;
float yValue = 0;
int i = 0;
int j = 0;
int k = 0;
int l = 0;
int r = 150;
boolean change = true;
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
  font = new RFont("Franklin Goth Ext Condensed.ttf", 150, RFont.LEFT);
  
  // getting the points along the multiple strings
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
    
  noFill();
}

void update(){
  stroke(r, r, 0, 75);
  // setting a different color for the third string
  if (i >= pnts.length && j >= pnts2.length && k < pnts3.length){
    stroke(50);
  }
  ellipse(xValue, yValue, diam, diam);
}
 
void draw(){
      // printing the first string on the canvas
      if (i < pnts.length){
        update();
        if (r >= 0 && change == true){
          r -= 1; 
        }
        else if(r == 225 && change == false){
          r -= 1; 
          change = true; 
        }
        else{
          r +=1;
          change = false; 
        }
        xValue =  pnts[i].x + xOffset;
        yValue = pnts[i].y + height/2 - 150;
        i++;
      }
      
      // printing the second string after the first one has been printed
      if (i >= pnts.length){
        if (j < pnts2.length){
        update();
        if (r >= 0 && change == true){
          r -= 1;  
        }
        else if (r == 225 && change == false){
          r -= 1; 
          change = true; 
        }
        else{
          r +=1;
          change = false; 
        }
        xValue =  pnts2[j].x + xOffset2;
        yValue = pnts2[j].y + height/2;
        j++;
        }
        
      // printing the 3rd string on the canvas after the first two have been printed
      if (i >= pnts.length && j >= pnts2.length){
        if (k < pnts3.length){
          update();
        if (r >= 0 && change == true){
          r -= 1;  
        }
        else if (r == 225 && change == false){
          r -= 1; 
          change = true; 
        }
        else {
          r +=1;
          change = false; 
        }
        xValue =  pnts3[k].x + xOffset3 + 60;
        yValue = pnts3[k].y + height/2;
        k++;
        }
        
      // printing the 4th string after the first 3 have been printed
      if (i >= pnts.length && j >= pnts2.length && k >= pnts3.length){
        if (l < pnts4.length){
          update();
        if (r >= 0 && change == true){
          r -= 1;  
        }
        else if (r == 225 && change == false){
          r -= 1; 
          change = true; 
        }
        else{
          r +=1;
          change = false; 
        }
        xValue =  pnts4[l].x + xOffset4;
        yValue = pnts4[l].y + height/2 + 150;
        l++;
        }
      }
      }
      }
        
}
