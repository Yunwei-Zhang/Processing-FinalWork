import processing.sound.*;
AudioIn mic;
Amplitude amp;

//number
int number=5000;
//biggest theta speed
float btspeed=PI/600;
//radius
float r1=100;
//range of r2
int rrange=120;
//radius
int r2=5;

PVector pv[]=new PVector[number];
boolean bv=true;
boolean bo=true;
//each point's color
color col[]=new color[number];
//each point's initail angle
float savedtheta[]=new float[number];
//change angle to numatic data
float savedmtheta[]=new float[number];
//speed of savedtheta
float saveddtheta[]=new float[number];
float savedeasing[]=new float[number];
//change radius to shuffle
int shuffle[]=new int[number];

void setup()
{
  colorMode(RGB,255,255,255);
  size(1500,960);
  //initilize all the data
  for(int i=0;i<number-1;i++)
  {
    col[i]=color(random(0,255),random(0,255),random(0,255));
    pv[i]=new PVector(random(width),random(height));
    savedtheta[i]=round(random(360));
    saveddtheta[i]=random(btspeed);
    savedmtheta[i]=savedtheta[i]/180*PI;
    shuffle[i]=round(random(-rrange,rrange));
    savedeasing[i]=random(0.02,0.3);
  }
  frameRate(60);
  
  mic=new AudioIn(this,1);
  mic.start();
  amp=new Amplitude(this);
  amp.input(mic);
}
void draw()
{
  //change opacity
  fill(25,25,25,25);
  rect(0,0,width,height);
  pushMatrix();
  noStroke();
  //analyze the AudioIn
  r1=map(amp.analyze(),0,0.1,100,width);
  //all the situations
  if(bv)
  {
    if(bo)
    {
      for(int i=0;i<number-1;i++)
      {
        savedmtheta[i]+=saveddtheta[i];
        pv[i].lerp(mouseX+cos(savedmtheta[i])*(shuffle[i]+r1),mouseY+sin(savedmtheta[i])*(shuffle[i]+r1),0,savedeasing[i]);
        fill(col[i]);
        ellipse(pv[i].x,pv[i].y,r2,r2);
      }
    }
    if(!bo)
    {
      for(int i=0;i<number-1;i++)
      {
        pv[i].lerp(mouseX+cos(savedmtheta[i])*(shuffle[i]+r1),mouseY+sin(savedmtheta[i])*(shuffle[i]+r1),0,savedeasing[i]);
        fill(col[i]);
        ellipse(pv[i].x,pv[i].y,r2,r2);
      }
    }
  }
  if(!bv)
  {
    if(bo)
    {
      for(int i=0;i<number-1;i++)
      {
        savedmtheta[i]+=saveddtheta[i];
        pv[i].lerp(mouseX+cos(savedmtheta[i])*shuffle[i],mouseY+sin(savedmtheta[i])*shuffle[i],0,savedeasing[i]);
        fill(col[i]);
        ellipse(pv[i].x,pv[i].y,r2,r2);
      }
    }
    if(!bo)
    {
      for(int i=0;i<number-1;i++)
      {
        pv[i].lerp(mouseX+cos(savedmtheta[i])*shuffle[i],mouseY+sin(savedmtheta[i])*shuffle[i],0,savedeasing[i]);
        fill(col[i]);
        ellipse(pv[i].x,pv[i].y,r2,r2);
      }
    }
  }
  popMatrix();
  fill(0);
  rect(0,0,width,15);
  fill(255);
}



//not used
void keyPressed()
{
  
}
//not used
void mouseWheel(MouseEvent event)
{

}
