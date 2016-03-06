
public interface iDataGenerator
{
  PDataPoint getData();
}

public class SimpleSequenceDataGenerator implements iDataGenerator
{
  private float from=0;
  private float to=0;
  private float steps=1;
  PDataPoint data=new PDataPoint();
  float currentStep=0;
  
  public SimpleSequenceDataGenerator(float from, float to, float steps)
  {
    this.from=from;
    this.to=to;
    this.steps=steps;
  }
  
  public SimpleSequenceDataGenerator()
  {
    
  }
  
  public PDataPoint getData()
  {
    float v=map(currentStep++ % steps,0,steps,from,to);
    data.value.set(v,v,v);
    return data;
  }
}

public class SequenceDataGenerator implements iDataGenerator
{
    SimpleSequenceDataGenerator X=new SimpleSequenceDataGenerator();
    SimpleSequenceDataGenerator Y=new SimpleSequenceDataGenerator();
    SimpleSequenceDataGenerator Z=new SimpleSequenceDataGenerator();
    SimpleSequenceDataGenerator rotateX=new SimpleSequenceDataGenerator();
    SimpleSequenceDataGenerator rotateY=new SimpleSequenceDataGenerator();
    SimpleSequenceDataGenerator rotateZ=new SimpleSequenceDataGenerator();
    public PDataPoint getData()
    {
      PDataPoint result=new PDataPoint();
      result.value.x=X.getData().value.x;
      result.value.y=Y.getData().value.x;
      result.value.z=Z.getData().value.x;
      result.rotation.x=rotateX.getData().value.x;
      result.rotation.y=rotateY.getData().value.x;
      result.rotation.z=rotateZ.getData().value.x;
      return result;
    }
    
}