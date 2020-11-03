import processing.sound.*;
import beads.*;
import java.util.Arrays; 
import ddf.minim.*;
import ddf.minim.ugens.*;

//all the required image
PImage galaxyimage,savingimage,icon1,icon2,icon3,icon4,icon5,icon6,icon7;
//for import minim
Minim minim;
//record method
AudioInput keyin;
AudioOutput keyout;
AudioRecorder keyrecorder;
FilePlayer product;
//light
float [] wave1;
float [] wave2;
float [] wave3;
//set light time
int time =600;
//two arraylist for icon6 and icon7 class in createimage function
ArrayList<CreateIcon6>c6=new ArrayList<CreateIcon6>();
ArrayList<CreateIcon7>c7=new ArrayList<CreateIcon7>();
//boolean for clear buttons, when click button, the boolean will be true
boolean whetherclear=false;
//boolean for recording, when click button, the boolean will be true
boolean hasrecorded=false;
//boolean for buttons, when click button, the boolean will be true
boolean tofirstpage=false;
boolean tosecondpage=false;
boolean tothirdpage=false;
boolean toimageinputpage=false;
boolean toshowimagepage=false;
//boolean for 8 keys, when press the key, it will be true
boolean key1,key2,key3,key4,key5,key6,key7,key8=false;
//audioplayer for 8 different pitches
AudioPlayer player1,player2,player3,player4,player5,player6,player7,player8;
void setup()
{
  size(1200,780);
  getkeysound();
  //load all the project required image and resize them
  galaxyimage= loadImage("galaxybackground.png");
  galaxyimage.resize(1200,780);
  savingimage= loadImage("MyImage.jpg");
  savingimage.resize(1200,780);
  icon1=loadImage("icon1.png");
  icon1.resize(50,70);
  icon2=loadImage("icon2.png");
  icon2.resize(50,70);
  icon3=loadImage("icon3.png");
  icon3.resize(80,100);
  icon4=loadImage("icon4.png");
  icon4.resize(60,70);
  icon5=loadImage("icon5.png");
  icon5.resize(40,50);
  icon6=loadImage("icon6.png");
  icon6.resize(40,60);
  icon7=loadImage("icon7.png");
  icon7.resize(30,55);
  
  //contruction and initializing for recorder and save it as "myrecording.wav"
  keyin = minim.getLineIn(Minim.STEREO, 2048);
  keyrecorder = minim.createRecorder(keyin, "myrecording.wav");
  keyout = minim.getLineOut( Minim.STEREO );
  
  //array for three lines in light function
  wave1=new float[1201];
  wave2=new float[1201];
  wave3=new float[1201];
}
void draw()
{
  //image "galaxyimage" as background
  background(galaxyimage);
  piano();
  keycolour();
  drawicons();
  startbutton();
  endbutton();
  playbutton();
  firstbutton();
  secondbutton();
  thirdbutton();
  imageinputbutton();
  showimagebutton();
  quitbutton();
  //when click button, the boolean will be true, and will lead to next page;
  if(tofirstpage)
  firstpage();
  if(tosecondpage)
  secondpage();
  if(tothirdpage)
  thirdpage();
  if(toimageinputpage)
  imageinputpage();
  if(toshowimagepage)
  showimagepage();
  
}
//draw all the musical notes in main page
void drawicons()
{
  //only press the key, the image of each key still present due to the value of boolean
  image(icon3,90,110);
  if(key1)
  image(icon1,180,200);
  if(key2)
  image(icon2,250,300);
  if(key3)
  image(icon1,320,230);
  if(key4)
  image(icon2,410,150);
  if(key5)
  image(icon1,490,240);
  if(key6)
  image(icon2,600,320);
  if(key7)
  image(icon1,680,150);
  if(key8)
  image(icon2,760,100);
  
  //draw lines in the button of each musical notes
  strokeWeight(3);
  stroke(#F5EE14);
  line(170,270,240,270);
  line(240,370,310,370);
  line(310,300,380,300);
  line(400,220,470,220);
  line(480,310,550,310);
  line(590,390,660,390);
  line(670,220,740,220);
  line(750,170,820,170);
  stroke(0);
  
  //set each key to false, so that when one key is pressed, the boolean will be reset to false and the key can be pressed again
  //which is used for multi-press
  key1=false;
  key2=false;
  key3=false;
  key4=false;
  key5=false;
  key6=false;
  key7=false;
  key8=false;
}
//get each key's pitch
void getkeysound()
{
   //load each of 8 different .mp3 to player1-8
   minim = new Minim(this);
   player1 = minim.loadFile("1.mp3");
   player2 = minim.loadFile("2.mp3");
   player3 = minim.loadFile("3.mp3");
   player4 = minim.loadFile("4.mp3");
   player5 = minim.loadFile("5.mp3");
   player6 = minim.loadFile("6.mp3");
   player7 = minim.loadFile("7.mp3");
   player8 = minim.loadFile("8.mp3");
}
//draw piano
void piano()
{
  //draw piano keys (white)
  pushMatrix();
  strokeWeight(2);
  fill(255,255,255);
  for(int i=180;i<820;i=i+80)
  rect(i,600,80,150);
  popMatrix();
  
  //draw the frame of the piano
  pushMatrix();
  fill(#5A5555);
  beginShape();
  vertex(180,600);
  vertex(180,750);
  vertex(130,750);
  vertex(130,500);
  vertex(870,500);
  vertex(870,750);
  vertex(820,750);
  vertex(820,600);
  vertex(180,600);
  endShape();
  fill(255,255,255);
  popMatrix();
}
//all the functions of each key (not just the changing the key color)
void keycolour()
{
  if(keyPressed)
  {
    //use switch to have 8 different cases of each key
    switch(key)
    {
      case '1':
        //when pressed the key, draw each key in different data (black)
        drawkeycolour(180);
        //boolean key be true, and that imagea will present when press
        key1=true;
        //text for each key (do,re,mi...)
        addtext("Do",180);
        //use rewind(), otherwise each sound can only present once
        player1.rewind();
        //play the music of the key
        player1.play();
        break;
      case '2':
        drawkeycolour(260);
        key2=true;
        addtext("Re",260);
        player2.rewind();
        player2.play();
        break;
      case '3':
        drawkeycolour(340);
        key3=true;
        addtext("Me",340);
        player3.rewind();
        player3.play();
        break;
      case '4':
        drawkeycolour(420);
        key4=true;
        addtext("Fa",420);
        player4.rewind();
        player4.play();
        break;
      case '5':
        drawkeycolour(500);
        key5=true;
        addtext("So",500);
        player5.rewind();
        player5.play();
        break;
      case '6':
        drawkeycolour(580);
        key6=true;
        addtext("La",580);
        player6.rewind();
        player6.play();
        break;
      case '7':
        drawkeycolour(660);
        key7=true;
        addtext("Ti",660);
        player7.rewind();
        player7.play();
        break;
        case '8':
        drawkeycolour(740);
        key8=true;
        addtext("Do",740);
        player8.rewind();
        player8.play();
        break;
    }
  }
  fill(255,255,255);
}
//draw each key's color (black)
void drawkeycolour(float firstkey)
{
  fill(255,255,255);
  pushMatrix();
  fill(0);
  rect(firstkey,600,80,150);
  popMatrix();
  fill(255,255,255);
}
//add text(do,re,mi...) in mainpage, when press the key, the pitch text will present
void addtext(String whichkey,float firstkey)
{
  fill(255,255,255);
  text(whichkey,firstkey,50);
  fill(255,255,255);
}
//button for start recording
void startbutton()
{
  textSize(20);
  fill(#737474);
  rect(1100,20,80,40);
  fill(255,255,255);
  text("Start",1119,47);
  if(mousePressed)
  {
    if(mouseX>=1100 && mouseX<=1180 && mouseY>=20 && mouseY<=60)
    {
       println("now start to record");
       //if has not been recorded, then start to record
       if(hasrecorded== false)
       {
         //start to record
         keyrecorder.beginRecord();
       }
    }
  }
  fill(255,255,255);
}
//button for end recording
void endbutton()
{
  textSize(20);
  fill(#737474);
  rect(1100,80,80,40);
  fill(255,255,255);
  text("Stop",1120,107);
  if(mousePressed)
  {
    if(mouseX>=1100 && mouseX<=1180 && mouseY>=80 && mouseY<=120)
    {
       println("now stop recording");
       //determine whether it has finished recording
       if(hasrecorded== false)
       {
         //end recording
         keyrecorder.endRecord();
         //save file
         product = new FilePlayer(keyrecorder.save());
         //switch boolean to true
         hasrecorded=true;
       }
    }
  }
  fill(255,255,255);
}
//play the recorded audio
void playbutton()
{
  textSize(20);
  fill(#737474);
  rect(1100,140,80,40);
  fill(255,255,255);
  text("Play",1121,167);
  if(mousePressed)
  {
    if(mouseX>=1100 && mouseX<=1180 && mouseY>=140 && mouseY<=180)
    {
       println("Trun to test page");
       //determine whether it has finished recording
       if(hasrecorded== true)
       {
         //rewind() for play the audio many time
         product.rewind();
         //get output
         product.patch(keyout);
         //play the audio file
         product.play();
       }
    }
  }
  fill(255,255,255);
  textSize(35);
}
//the first button (light function)
void firstbutton()
{
  textSize(20);
  fill(#737474);
  rect(1100,200,80,40);
  fill(255,255,255);
  text("First",1120,227);
  if(mousePressed)
  {
    if(mouseX>=1100 && mouseX<=1180 && mouseY>=200 && mouseY<=240)
    {
       println("Trun to first page");
    }
  }
  fill(255,255,255);
  textSize(35);
}
//the second button (to file1)
void secondbutton()
{
  textSize(20);
  fill(#737474);
  rect(1100,260,80,40);
  fill(255,255,255);
  text("Second",1107,287);
  if(mousePressed)
  {
    if(mouseX>=1100 && mouseX<=1180 && mouseY>=260 && mouseY<=300)
    {
       println("Trun to second page");
    }
  }
  fill(255,255,255);
  textSize(35);
}
//the third button (to file2)
void thirdbutton()
{
  textSize(20);
  fill(#737474);
  rect(1100,320,80,40);
  fill(255,255,255);
  text("Third",1115,347);
  if(mousePressed)
  {
    if(mouseX>=1100 && mouseX<=1180 && mouseY>=320 && mouseY<=360)
    {
       println("Trun to third page");
    }
  }
  fill(255,255,255);
  textSize(35);
}
//creating image button
void imageinputbutton()
{
  textSize(20);
  fill(#737474);
  rect(1100,440,80,40);
  fill(255,255,255);
  text("Image",1112,467);
  if(mousePressed)
  {
    if(mouseX>=1100 && mouseX<=1180 && mouseY>=440 && mouseY<=480)
    {
       println("Trun to imagecreating page");
    }
  }
  fill(255,255,255);
  textSize(35);
}
//show the saved image button
void showimagebutton()
{
  textSize(20);
  fill(#737474);
  rect(1100,500,80,40);
  fill(255,255,255);
  text("Show",1115,527);
  if(mousePressed)
  {
    if(mouseX>=1100 && mouseX<=1180 && mouseY>=500 && mouseY<=540)
    {
       println("Trun to show image page");
    }
  }
  fill(255,255,255);
  textSize(35);
}
//quit the project button
void quitbutton()
{
  textSize(20);
  fill(#737474);
  rect(1100,560,80,40);
  fill(255,255,255);
  text("Quit",1120,587);
  if(mousePressed)
  {
    if(mouseX>=1100 && mouseX<=1180 && mouseY>=560 && mouseY<=600)
    {
       println("Quit");
    }
  }
  fill(255,255,255);
  textSize(35);
}
//to first page
void firstpage()
{
   noStroke();
   fill(0);
   rect(0,0,880,800);
   firstmusic();
}
//first page function
void firstmusic()
{
    stroke(#0A1FF5);
    //colorMode(HSB);
    background(0);
    wave1[0]=390;
    wave2[0]=390;
    wave1[0]=390;
    //set the first part of waves 
    for(int i=1; i<time;i++)
    {
      float r1=(int)random(3);
      if(r1==0)
      {
        wave1[i+1]=wave1[i];
      }
      if(r1==1)
      {
        wave1[i+1]=wave1[i]-1;
      }
      if(r1==2)
      {
        wave1[i+1]=wave1[i]+1;
      } 
    }
    //set the second part of waves 
    for(int i=1; i<time;i++)
    {
      float r2=(int)random(3);
      if(r2==0)
      {
        wave1[i+1]=wave1[i];
      }
      if(r2==1)
      {
        wave1[i+1]=wave1[i]-2;
      }
      if(r2==2)
      {
        wave1[i+1]=wave1[i]+2;
      } 
    }
    //set the third part of waves 
    for(int i=1; i<time;i++)
    {
      float r3=(int)random(3);
      if(r3==0)
      {
        wave1[i+1]=wave1[i];
      }
      if(r3==1)
      {
        wave1[i+1]=wave1[i]-3;
      }
      if(r3==2)
      {
        wave1[i+1]=wave1[i]+3;
      } 
    }
    //present the waves
    for(int i=0;i<time;i++)
    {
      strokeWeight(2050/(i+279));
      float d= dist(i,400,400,300);
      stroke(163,d+-123,253,d+238);
      point(i,wave1[i]+390);
      point(1200-i,wave1[i]+390);
      point(i,wave2[i]+390);
      point(1200-i,wave2[i]+390);
      point(i,wave3[i]+390);
      point(1200-i,wave3[i]+390);
    } 
    //show reminding text
    stroke(0);
    fill(255,255,255);
    textSize(30);
    text("Press R to return", 480,100);
}
//to second page
void secondpage()
{
   noStroke();
   fill(0);
   rect(0,0,880,800);
   secondmusic();
}
//second page function (most in mouseClick())
void secondmusic()
{
   background(0);
   stroke(0);
   fill(255,255,255);
   textSize(30);
   text("Press R to return", 480,100);
}
//to second page
void thirdpage()
{
   noStroke();
   fill(0);
   rect(0,0,880,800);
   thirdmusic();
}
//third page function (most in mouseClick())
void thirdmusic()
{
   background(0);
   stroke(0);
   fill(255,255,255);
   textSize(30);
   text("Press R to return", 480,100);
}
//to imagecreating page
void imageinputpage()
{
   noStroke();
   fill(0);
   rect(0,0,880,800);
   imageinputmusic();
   createaction();
   //if boolean is true, clear the page
   if(whetherclear)
   {
     imageinputmusic();
     //clear the two arraylists
     c6.clear();
     c7.clear();
     createaction();
   }
}
//draw the page
void imageinputmusic()
{
   background(255,255,255);
   stroke(0);
   fill(0);
   //reminding text
   textSize(30);
   text("press R to return", 850,700);
   
   //musical line
   strokeWeight(0.9);
   for(int i=150;i<560;i+=100)
   {
     line(50,i,1150,i);
     line(50,i+10,1150,i+10);
     line(50,i+20,1150,i+20);
     line(50,i+30,1150,i+30);
     line(50,i+40,1150,i+40);
   }
   //frames of two musical notes
   fill(0);
   rect(290,10,80,80);
   rect(420,10,80,80);
   fill(255,255,255);
   rect(295,15,70,70);
   rect(425,15,70,70);
   fill(0);
   stroke(0);
   text("L",320,120);
   text("R",450,120);
   
   //draw the two musical notes
   image(icon4,60,140);
   pushMatrix();
   scale(-1,1);
   image(icon5,-110,240);
   popMatrix();
   image(icon6,310,20);
   image(icon7,445,20);
   buttonclear();
}
//button for clear
void buttonclear()
{
  textSize(20);
  fill(#737474);
  rect(50,30,80,40);
  fill(255,255,255);
  text("Clear",65,57);
  if(mousePressed)
  {
    if(mouseX>=50 && mouseX<=130 && mouseY>=50 && mouseY<=90)
    {
       println("clear the page");
       //boolean to be true, so that the project will clear the page
       whetherclear=true;
    }
  }
  fill(255,255,255);
  textSize(35);
}
//the functions of creating page
void createaction()
{
  //traverse the arraylist and run each of the CreateIcon6/CreateIcon7 class
  for(CreateIcon6 c:c6)
  {
    c.run();
  }
  for(CreateIcon7 c:c7)
  {
    c.run();
  }
}
//create the class of CreateIcon6
class CreateIcon6
{
  float x;
  float y;
  //contructer of the class
  CreateIcon6(float x, float y)
  {
    this.x=x;
    this.y=y;
  }
  //run method for display the icon6
  void run()
  {
    pushMatrix();
    translate(x,y);
    image(icon6,0,0);
    popMatrix();
  }
}
//create the class of CreateIcon6
class CreateIcon7
{
  float x;
  float y;
  //contructer of the class
  CreateIcon7(float x, float y)
  {
    this.x=x;
    this.y=y;
  }
  //run method for display the icon6
  void run()
  {
    pushMatrix();
    translate(x,y);
    image(icon7,0,0);
    popMatrix();
  }
}
//to show image page
void showimagepage()
{
   noStroke();
   fill(0);
   rect(0,0,880,800);
   imagemusic();
}
//function of showing
void imagemusic()
{
   
   background(0);
   //display the saved image
   image(savingimage,0,0);
   stroke(0);
   fill(255,255,255);
   textSize(30);
   if(keyPressed)
   {
     //first function (vague the image)
     if(key=='v' || key=='V')
     {
       vague();
     }
     //second function (change the image color)
     if(key=='c' || key=='C')
     {
       changecolor((int)random(0,200));
     }
   }
}
//the vague function
void vague()
{ 
  for(int y=1;y<savingimage.height-1;y++)
  {
    for(int x=1;x<savingimage.width-1;x++)
    {
      int nx=randI(x-2,x+2);
      int ny=randI(y-2,y+2);
      set(x,y,get(nx,ny));
    }
  }
}
//random the values
int randI(int l,int h)
{
  int rand= floor(random(l,h+1));
  rand=constrain(rand,l,h);
  return rand;
}
//change the color
void changecolor(int cc)
{
   for(int y=0;y<savingimage.height;y++)
  {
    for(int x=0;x<savingimage.width;x++)
    {
      //get the color of each pixel
      color c=get(x,y);
      //change the color
      set(x,y,color(255-red(c)+cc,255-green(c)+cc,255-blue(c))+cc);
    }
  }
}


//---------------------------------------- Below is the key and mouse functions------------------------------------------------


//not used
void mousePressed()
{

}
//mouseclick functions
void mouseClicked()
{
  //first button fields
  if(mouseX>=1100 && mouseX<=1180 && mouseY>=200 && mouseY<=240)
  {
     //boolean to firstpage becomes true
     tofirstpage=true;
  }
  //second button fields
  if(mouseX>=1100 && mouseX<=1180 && mouseY>=260 && mouseY<=300)
  {
     //boolean to secondpage becomes true
     tosecondpage=true;
     //open the file1.pde
     launch("C:/Users/zhang/Desktop/13019409-A3-31080-1/file1/file1.pde");
  }
  //third button fields
  if(mouseX>=1100 && mouseX<=1180 && mouseY>=320 && mouseY<=360)
  {
     //boolean to thirdpage becomes true
     tothirdpage=true;
     //open the file2.pde
     launch("C:/Users/zhang/Desktop/13019409-A3-31080-1/file2/file2.pde");
  }
  //imageinput button fields
  if(mouseX>=1100 && mouseX<=1180 && mouseY>=440 && mouseY<=480)
  {
     //boolean to creating page becomes true
     toimageinputpage=true;
  }
  //showimage button fields
  if(mouseX>=1100 && mouseX<=1180 && mouseY>=500 && mouseY<=540)
  {
     //boolean to showing page becomes true
     toshowimagepage=true;
  }
  //quit button fields
  if(mouseX>=1100 && mouseX<=1180 && mouseY>=560 && mouseY<=600)
  {
     //exit the project
     exit();
  }
}
//mouseReleased function
void mouseReleased()
{
  if(toimageinputpage==true)
  {
    //when press the left mouse, draw the icon6 in the position of mouse
    if(mouseButton == LEFT)
    {
      c6.add(new CreateIcon6(mouseX,mouseY));
    }
    //when press the left mouse, draw the icon7 in the position of mouse
    if(mouseButton == RIGHT)
    {
      c7.add(new CreateIcon7(mouseX,mouseY));
    }
  }
}
//key pressed function
void keyPressed()
{
  //when press 'r' or 'R'
  if(key=='r'||key=='R')
  {
    //set all the boolean to false, which mean go to the main page
    tofirstpage=false;
    tosecondpage=false;
    tothirdpage=false;
    toimageinputpage=false;
    toshowimagepage=false;
  }
  //when press 's' or 'S'
  if(key=='s'||key=='S')
  {
    //save the image as "MyImage.jpg"
    saveFrame("MyImage.jpg");
    println("Image has been saved");
    //load the saved image again to show updates
    savingimage= loadImage("MyImage.jpg");
    //resize the savedimage
    savingimage.resize(1200,780);
  }
}
