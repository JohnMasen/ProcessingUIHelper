GridLayout g;
ArrayList<TrackGenerator> tgs;
SequenceDataGenerator gen=new SequenceDataGenerator();
ArrayList<iDataProjector> projectors=new ArrayList<iDataProjector>();

void setup()
{
  size(500,500);
  g=new GridLayout(width,height);
  g.setColumns("1*,1*");
  g.setRows("1*,1*");
  frameRate(10);
  gen.X.from=0;
  gen.X.to=TWO_PI;
  gen.X.steps=60;
  gen.Y.from=30;
  gen.Y.to=30;
  gen.Y.steps=1;
  frameRate(30);
  
  //projectors.add(new CartesianProjector());
  projectors.add(new CircleProjector());
  projectors.add(new CircleProjector());
  projectors.add(new CircleProjector());
  //projectors.add(new CircleProjector());
  //projectors.add(new CircleProjector());
  //projectors.add(new CircleProjector());
  //projectors.add(new CircleProjector());
  //projectors.add(new CircleProjector());
}


void draw()
{
  background(200);
  //g.drawChessboard(color(200),color(255));
  
  g.cells[1][1].translateTo();
  
  PDataPoint data=gen.getData();
  PDataPoint data1=null;
  println("-----------------------");
  for(iDataProjector item :projectors)
  {
    data1=item.Project(data);
    println(data.value,"->",data1.value);
    drawItem(data1);
  }
  
  
   //<>//
  

  
  
}

void drawItem(PDataPoint item)
{
 
  //drawGrid();
  pushStyle();
  noFill();
  ellipse(0,0,60,60);
  line(0,0,item.value.x,item.value.y);
  //line(item.value.x,0,item.value.x,item.value.y);
  item.translateTo(true);
  //ellipse(0,0,30,30);
  //line(0,-15,0,-30);
  popStyle();
  
}

void drawGrid()
{
  GridLayout g1=new GridLayout(100,100);
  g1.setColumns("1*,1*,1*,1*");
  g1.setRows("1*,1*,1*,1*");
  pushMatrix();
  translate(-50,-50);
  g1.drawChessboard(color(255,255,255,0));
  popMatrix();
}