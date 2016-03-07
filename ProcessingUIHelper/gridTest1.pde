public class gridTest1 implements iTestScene
{
  GridLayout g;
  void setup()
  {
    size(500,500);
    g=new GridLayout();
    g.setColumns("1*,1*,1*,1*,1*,1*,1*,1*,1*,1*,1*,1*");
    g.setRows("1*,1*,1*,1*,1*,1*,1*,1*,1*,1*,1*,1*");
  }
  
  void draw()
  {
    g.drawChessboard(color(150),color(100,20,25));
  }
}