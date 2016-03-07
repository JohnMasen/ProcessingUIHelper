public class test2 implements iTestScene
{
  GridLayout g,workspace;
  void setup()
  {
    g=new GridLayout(width,height);
    g.setColumns("1*,1*,1*,1*");
    g.setRows("1*,1*,1*,2*");
    workspace=new GridLayout(g,2,2,1,1);
    frameRate(1);
    //ellipseMode(CENTER); 
  }
  
  void draw()
  {
    g.drawChessboard(color(200),color(255));
    noFill();
    ellipse(width/2,height/2,50,50);
    workspace.project(100,100);
    fill(100);
    ellipse(width/2,height/2,100,100);
    workspace.unProject();
  }
  
  
}