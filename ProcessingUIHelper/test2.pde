public class test2 implements iTestScene
{
  GridLayout g;
  void setup()
  {
    g=new GridLayout(width,height);
    g.setColumns("1*,1*,1*");
    g.setRows("1*,1*,1*");
    frameRate(1);
  }
  
  void draw()
  {
    g.drawChessboard();
    fill(200);
    rect(0,0,width,height);
    g.boundToCells(1,1,0,0);
    fill(100);
    rect(0,0,width,height);
    g.unbound();
  }
  
  
}