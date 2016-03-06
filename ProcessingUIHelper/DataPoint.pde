public class PDataPoint
{
  PVector value=new PVector() ;
  PVector rotation=new PVector();
  public void translateTo()
  {
    translateTo(false);
  }
  public void translateTo(boolean applyNormal)
  {
    translate(value.x,value.y);
    if (applyNormal)
    {
      rotate(rotation.z);
    }
  }
  public void translateTo3D()
  {
    translateTo3D(false);
  }
  
  public void translateTo3D(boolean applyNormal)
  {
    translate(value.x,value.y,value.z);
    if (applyNormal)
    {
      rotateX(rotation.x);
      rotateY(rotation.y);
      rotateZ(rotation.z);
    }
  }
  
}