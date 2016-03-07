public class test4 implements iTestScene
{
  float theta;   
  GridLayout g;
  GridLayout[] workspace=new GridLayout[4];
  void setup()
  {
    g=new GridLayout();//root grid
    g.setColumns("1*,2*");
    g.setRows("1*,2*");
    workspace[0]=new GridLayout(g,0,0,0,0);
    workspace[1]=new GridLayout(g,1,0,0,0);
    workspace[2]=new GridLayout(g,0,1,0,0);
    workspace[3]=new GridLayout(g,1,1,0,0);
    frameRate(30);
  }
  
  void draw()
  {
    background(0);
    stroke(255);
    for(int i=0;i<workspace.length;i++)
    {
      workspace[i].project(640,360);
      drawTree();
      workspace[i].unProject();
    }
  }
  void drawTree()
  {
    
  
  
  // Let's pick an angle 0 to 90 degrees based on the mouse position
  float a = (mouseX / (float) width) * 90f;
  // Convert it to radians
  theta = radians(a);
  // Start the tree from the bottom of the screen
  translate(width/2,height);
  // Draw a line 120 pixels
  line(0,0,0,-120);
  // Move to the end of that line
  translate(0,-120);
  // Start the recursive branching!
  branch(120);
  }
  void branch(float h) {
  // Each branch will be 2/3rds the size of the previous one
  h *= 0.66;
  
  // All recursive functions must have an exit condition!!!!
  // Here, ours is when the length of the branch is 2 pixels or less
  if (h > 2) {
    pushMatrix();    // Save the current state of transformation (i.e. where are we now)
    rotate(theta);   // Rotate by theta
    line(0, 0, 0, -h);  // Draw the branch
    translate(0, -h); // Move to the end of the branch
    branch(h);       // Ok, now call myself to draw two new branches!!
    popMatrix();     // Whenever we get back here, we "pop" in order to restore the previous matrix state
    
    // Repeat the same thing, only branch off to the "left" this time!
    pushMatrix();
    rotate(-theta);
    line(0, 0, 0, -h);
    translate(0, -h);
    branch(h);
    popMatrix();
  }
}
}