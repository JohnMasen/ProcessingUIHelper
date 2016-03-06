GridLayout g;
ArrayList<TrackGenerator> tgs;
void setup()
{
  size(500,500);
  g=new GridLayout(width,height);
  g.setColumns("1*,1*,1*");
  g.setRows("1*,1*,1*");
  tgs=new ArrayList<TrackGenerator>();
  
  TrackGenerator tmp;
  tmp=new TrackGenerator();
  tmp.generator=new SinTrackDataGenerator();
  
  
  
  
  frameRate(60);
  
}


void draw()
{
  background(200);
  //g.drawChessboard(color(255,0,0),color(0,255,0),color(0,0,255)); //<>//
  g.drawChessboard();

  drawFPS();
}
void drawFPS()
{
  pushMatrix();
  g.cells[0][0].translateTo();
  text("frame rate: "+frameRate,0,0);
  popMatrix();
}