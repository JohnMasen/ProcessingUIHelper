public interface iDataProjector
{
  PDataPoint Project(PDataPoint data);
}

public class CartesianProjector implements iDataProjector
{
  PDataPoint Project(PDataPoint data)
  {
    PDataPoint result=new PDataPoint();
    result.value=data.value.copy();
    result.value.y=-result.value.y;
    result.rotation=data.rotation.copy();
    result.rotation.y=-result.rotation.y;
    return result;
  }
}

public class CircleProjector implements iDataProjector
{
  PDataPoint Project(PDataPoint data)
  {
    PDataPoint result=new PDataPoint();
    result.value.x=sin(data.value.x)*data.value.y;
    result.value.y=cos(data.value.x)*data.value.y;
    result.rotation.z=-data.value.x;
    return result;
  }
}