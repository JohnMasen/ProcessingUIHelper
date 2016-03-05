GridLayout g;
TrackGenerator tg;
void setup()
{
  size(500,500);
  g=new GridLayout(width,height);
  g.setColumns("1*,1*");
  g.setRows("1*,1*");
  tg=new TrackGenerator();
  tg.generator=new SinTrackDataGenerator();
  tg.steps=60;
  frameRate(60);
  testDrawGrids(g,color(0),color(255,33,22));
}


void draw()
{
  background(200);
  g.draw();
  tg.step();
  pushMatrix();
  g.cells[1][1].translateTo();
  TrackPoint p=tg.getPosition();
  ellipse(p.position.x,p.position.y,100,100);
  popMatrix();
}

void testDrawGrids(GridLayout source, color color1, color color2)
{
  int i=0;
  int[] b=new color[]{color1,color2};
  for(GridCell[] row : source.cells) //<>//
  {
    for(GridCell item :row)
    {
      PShape x=createShape(RECT,0,0,item.width,item.height);
       //<>//
      x.setFill(b[i++ % 2]);
      x.enableStyle();
      item.addShape(x);
      
    }
    if (row.length %2==0)//shift the first cell of new line to be alternate to the upper one
    {
      i++;
    }
  }
}