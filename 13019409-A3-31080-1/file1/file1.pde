import processing.sound.*;
import beads.*;
import java.util.Arrays; 

AudioIn firstm;
Amplitude firstamp;
AudioContext savedac;
PowerSpectrum savedps;
void setup()
{ 
  size(1000,800);
  //start the audioin
  firstm=new AudioIn(this,1);
  firstm.start();
  
  //put the audio in to amplitude for analyzing
  firstamp=new Amplitude(this);
  firstamp.input(firstm);
  
  //now audio context of selected file
  savedac = new AudioContext();
  //input the selected file
  selectInput("Select the saved audio file:", "function2Selected");
}

void draw()
{
  //start the analyzing function
  noStroke();
  //use fill(...10) to make the opacity set to 10 and create the rect to make delay function
  fill(0,0,0,10);
  rect (0,0,width,height);
  //analyze the AudioIn
  float diameter=map(firstamp.analyze(),0,0.1,100,width-50);
  fill(#17FF4F);
  //draw the circle in the middle and the diameter can change due to the AudioIn music
  ellipse(width/2,height/2,diameter,diameter);
  
  //change the stroke color same as the circle function
  stroke(#17FF4F);
  if(savedps == null) 
  {
    return;
  }
  //the function of line in the bottom 
  float[] savedfeatures = savedps.getFeatures();
  if(savedfeatures != null) 
  {  
    for(int i = 0; i < width; i++) 
    {
      int savedfeatureIndex = i * savedfeatures.length / width;
      int offheight = height - 1 - Math.min((int)(savedfeatures[savedfeatureIndex] * height), height - 1);
      //draw the lines
      line(i,height,i,offheight);
    }
  }  
}
//initializing of function2
void function2Selected(File selection) 
{
  Sample savedsample = SampleManager.sample(selection.getAbsolutePath());
  SamplePlayer player = new SamplePlayer(savedac, savedsample);
  Gain gain = new Gain(savedac, 2, 0.2);
  gain.addInput(player);
  savedac.out.addInput(gain);
  
  //analyzing methods
  ShortFrameSegmenter savedsfs = new ShortFrameSegmenter(savedac);
  savedsfs.addInput(savedac.out);
  //FFT may cause conflits between beads and sound
  //so use beads.FFT instead
  beads.FFT savedbeadfft = new beads.FFT();
  savedps = new PowerSpectrum();
  savedsfs.addListener(savedbeadfft);
  savedbeadfft.addListener(savedps);
  savedac.out.addDependent(savedsfs);
  //start the saved audiofile
  savedac.start();
}

//not used
void keyPressed()
{
 
}
