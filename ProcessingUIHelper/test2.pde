public class test2 implements iTestScene
{
  GridLayout g;
  void setup()
  {
    g=new GridLayout(width,height);
    g.setColumns("1*,1*,1*");
    g.setRows("1*,1*,1*");
  }
  
  void draw()
  {
    g.drawChessboard();
  }
}