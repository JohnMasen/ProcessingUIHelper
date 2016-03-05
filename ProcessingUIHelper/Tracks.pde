public class TrackPoint
{
  PVector position;
  float normalAngel;
  public TrackPoint()
  {
    position=new PVector();
    normalAngel=0;
  }
  
  public TrackPoint(PVector pos, float na)
  {
    position=pos;
    normalAngel=na;
  }
  
}
public class TrackGenerator
{
  
  iTrackDataGenerator generator;
  float steps=100,value=0;
  
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
  
  public void step()
  {
    value=(value+1/steps)%1;
    println("step=",value);
  }
  
}

public interface iTrackDataGenerator
{
  TrackPoint calculateData(float stepValue);
}

public class SinTrackDataGenerator implements iTrackDataGenerator
{
  float r=100;
   public TrackPoint calculateData(float stepValue)
   {
     TrackPoint result=new TrackPoint();
     float arc=stepValue*TWO_PI;
     result.position.x=cos(arc)*r;
     result.position.y=sin(arc)*r;
     result.normalAngel=arc;
     return result;
   }
}