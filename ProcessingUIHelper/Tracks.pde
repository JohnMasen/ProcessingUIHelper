
public class TrackGenerator
{
  
  iTrackDataGenerator generator;
  float steps=100,value=0;
  float currentStep=0;
  public TrackPoint getPosition()
  {
    return generator.calculateData(value);
  }
  
  public TrackPoint getPosition(float stepValue)
  {
    return generator.calculateData(stepValue);
  }
  
  public void reset()
  {
    value=0;
  }
  
  public void step(int stepCount)
  {
    currentStep=(currentStep+stepCount) % steps;
    value=currentStep*(1/steps);
    println("step",currentStep," : ",value);
  }
  
  public void step()
  {
    step(1);
  }
  
  public void drawTrack()
  {
    
  }
  
}

public interface iTrackDataGenerator
{
  TrackPoint calculateData(float stepValue);
}

public class SinTrackDataGenerator implements iTrackDataGenerator
{
  float frequency=0;
  float phaseAngle=0;
  float amplitude=0;
  
   public TrackPoint calculateData(float stepValue)
   {
     TrackPoint result=new TrackPoint();
     float arc=phaseAngle+stepValue*TWO_PI*frequency;
     result.position.x=cos(arc)*amplitude;
     result.position.y=sin(arc)*amplitude;
     result.rotation=arc;
     return result;
   }
   public SinTrackDataGenerator(float f,float p,float a)
   {
     frequency=f;
     phaseAngle=p;
     amplitude=a;
   }
   
   public SinTrackDataGenerator()
   {
     frequency=1;
     phaseAngle=0;
     amplitude=100;
   }
}
public class TrackPoint
{
  PVector position;
  float rotation;
  public TrackPoint()
  {
    position=new PVector();
    rotation=0;
  }
  
  public TrackPoint(PVector pos, float rotation)
  {
    position=pos;
    this.rotation=rotation;
  }
  
  public void translateTo(boolean enableRotation)
  {
    translate(position.x,position.y);
    if(enableRotation)
    {
      rotate(rotation); 
    }
    
  }
  
  public void translateTo()
  {
    translateTo(true);
  }
  
}