GridLayout g;
void setup()
{
  size(500,500);
  g=new GridLayout(width,height);
  g.setColumns("11,23,44,1*,12.5*");
  g.setRows("1*,1*,1*");
  println(g.columns);
  println(g.rows);
  testDrawGrids(g);  
}


void draw()
{
  g.draw();
}

void testDrawGrids(GridLayout source)
{
  int i=0;
  for(GridCell[] row : source.cells)
  {
    for(GridCell item :row)
    {
      PShape x=createShape(RECT,0,0,item.width,item.height);
      x.setFill(color(random(255)));
      x.enableStyle();
      item.addShape(x); //<>//
      print(i++);
    }
  }
}