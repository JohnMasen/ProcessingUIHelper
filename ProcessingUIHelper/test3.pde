public class test3 implements iTestScene
{
  int xspacing = 16;   // How far apart should each horizontal location be spaced
  int w;              // Width of entire wave
  
  float theta = 0.0;  // Start angle at 0
  float amplitude = 75.0;  // Height of wave
  float period = 500.0;  // How many pixels before the wave repeats
  float dx;  // Value for incrementing X, a function of period and xspacing
  float[] yvalues;  // Using an array to store height values for the wave
  GridLayout g;
  GridLayout workspace;
  void setup()
  {
    g=new GridLayout();//root grid
    g.setColumns("1*,2*");
    g.setRows("1*");
    workspace=new GridLayout(g,0,1,0,0);
    workspace.setColumns("1*,1*");
    workspace.setRows("1*,1*");
    workspace.project(640,360);
    w = width+16;
    
    dx = (TWO_PI / period) * xspacing;
    yvalues = new float[w/xspacing];

  }
  
  void draw()
  {
    background(51);
    g.drawChessboard();
    workspace.drawChessboard(color(100),color(200)); //<>//
    workspace.project(640,360);

    calcWave();
    renderWave();

    workspace.unProject();
  }
  void calcWave() {
    // Increment theta (try different values for 'angular velocity' here
    theta += 0.02;
  
    // For every x value, calculate a y value with sine function
    float x = theta;
    for (int i = 0; i < yvalues.length; i++) {
      yvalues[i] = sin(x)*amplitude;
      x+=dx;
    }
  }

  void renderWave() {
    noStroke();
    fill(255);
    // A simple way to draw the wave with an ellipse at each location
    for (int x = 0; x < yvalues.length; x++) {
      ellipse(x*xspacing, height/2+yvalues[x], 16, 16);
    }
  }
}