public interface iTestScene
{
  void setup();
  void draw();
}

/*
public class myTest implements iTestScene
{
  GridLayout g;
  void setup()
  {
    g=new GridLayout();
    g.setColumns("1*,1*,1*,1*,1*,1*,1*,1*,1*,1*,1*,1*");
    g.setRows("1*,1*,1*,1*,1*,1*,1*,1*,1*,1*,1*,1*");
  }
  
  void draw()
  {
    g.drawChessboard(color(150),color(100,20,25));
  }
}
*/