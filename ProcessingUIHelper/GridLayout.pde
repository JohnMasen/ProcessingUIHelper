
public class GridLayout
{
  float[] columns;
  float[] rows;
  float gridWidth,gridHeight;
  PVector topLeft;
  GridCell[][] cells;
  GridLayout parent;
  boolean enableBackground;
  color[] background;
  int previousWidth,previousHeight;
  
  public GridLayout(GridLayout p, int row,int col, int rowSpan, int colSpan)
  { 
    topLeft=p.cells[row][col].topLeft;
    PVector bottomRight=p.cells[row+rowSpan][col+colSpan].bottomRight;
    this.gridWidth=bottomRight.x-topLeft.x;
    this.gridHeight=bottomRight.y-topLeft.y;
    setDefaultGrid();
  }
  
  
  public GridLayout(float w,float h)
  {
    this.gridWidth=w;
    this.gridHeight=h;
    topLeft=new PVector();
    setDefaultGrid();
  }
  
  public GridLayout()
  {
    this.gridWidth=width;
    this.gridHeight=height;
    topLeft=new PVector();
    setDefaultGrid();
  }
  
  public PVector getTopLeft()
  {
    PVector result=topLeft.copy();
    if (parent!=null)
    {
      result.add(parent.getTopLeft());
    }
    return result;
  }
  
  private void setDefaultGrid()
  {
    setColumns("1*");
    setRows("1*");
  }
  
  public void boundToCells(int row,int col, int rowSpan,int colSpan)
  {
    previousWidth=width;
    previousHeight=height;
    PVector pos1=cells[row][col].topLeft;
    PVector pos2=cells[row+rowSpan][col+colSpan].bottomRight;
    println("pos1",pos1,"pos2",pos2);
    println("width",pos2.x-pos1.x);
    pushMatrix();
    cells[row][col].translateTo();
    width=int(pos2.x-pos1.x);
    height=int(pos2.y-pos1.y);
  }
  public void projectToCells(int row,int col, int rowSpan,int colSpan,int w,int h)
  {
    previousWidth=width;
    previousHeight=height;
    PVector pos1=cells[row][col].topLeft;
    PVector pos2=cells[row+rowSpan][col+colSpan].bottomRight;
    println("pos1",pos1,"pos2",pos2);
    println("width",pos2.x-pos1.x);
    pushMatrix();
    
    cells[row][col].translateTo();
    
    width=w;
    height=h;
    scale(float(width)/w,float(height)/h);
  }
  
  public void project()
  {
    previousWidth=width;
    previousHeight=height;
    PVector pos1=cells[0][0].topLeft;
    println(rows.length-1,columns.length-1);
    PVector pos2=cells[rows.length-2][columns.length-2].bottomRight; 
    pushMatrix();
    
    cells[0][0].translateTo();
    
    width=int(pos2.x-pos1.x);
    height=int(pos2.y-pos1.y);
  }
  
    public void project(float w,float h)
  {
    previousWidth=width;
    previousHeight=height;
    PVector pos1=cells[0][0].topLeft;
    PVector pos2=cells[rows.length-2][columns.length-2].bottomRight;
    pushMatrix();
    
    cells[0][0].translateTo();
    //cells[0][0].translateTo(((pos2.x-pos1.x)/w),((pos2.y-pos1.y)/h));
    
    width=int(w);
    height=int(h);
    println((pos2.x-pos1.x)/w,(pos2.y-pos1.y)/h);
    scale((pos2.x-pos1.x)/w,(pos2.y-pos1.y)/h);
  }
  public void unProject()
  {
    width=previousWidth;
    height=previousHeight;
    popMatrix();    
  }
  
  public void unbound()
  {
    width=previousWidth;
    height=previousHeight;
    popMatrix();
  }
  
  public void setColumns(String data)
  {
    columns=parseGapDefinition(data,this.gridWidth);
    refreshCells();
  }
  
  public void setRows(String data)
  {
    rows=parseGapDefinition(data,this.gridHeight);
    refreshCells();
  }
  private void refreshCells()
  {
    if (columns!=null && columns.length>0 && rows!=null && rows.length>0)
    {
      cells=new GridCell[rows.length-1][columns.length-1];
      for (int r=0;r<rows.length-1;r++) //<>//
      {
        for(int c=0;c<columns.length-1;c++)
        {
          cells[r][c]=new GridCell(columns[c],rows[r],columns[c+1]-columns[c],rows[r+1]-rows[r],topLeft);
        }
      }
    }
  }
  
  public void drawChessboard(color... colors)
  {
    if (colors.length==0)
    {
      colors=new color[]{color(0),color(255)};
    }

    for (int row=0;row<rows.length-1;row++)
    {
      for(int col=0;col<columns.length-1;col++)
      {
        pushStyle();
        pushMatrix();
        color c=colors[(row+col)%colors.length];
        fill(c);
        GridCell cell=cells[row][col];
        cell.translateTo();
        rect(0,0,cell.width,cell.height);
        //revert the color for text
        int r = (c >> 16) & 0xFF;  // Faster way of getting red(argb)
        int g = (c >> 8) & 0xFF;   // Faster way of getting green(argb)
        int b = c & 0xFF;          // Faster way of getting blue(argb)
        c=color(255-r,255-g,255-b);
        fill(c);
        println(c & 0x00ff0000);
        textAlign(CENTER,CENTER);
        text(str(row)+","+str(col),cell.width/2,cell.height/2);
        popMatrix();
        popStyle();
      }
    }
    
  }

     
  private float[] parseGapDefinition(String data, float value)
  {
    String[] items=split(data,',');
    float fixedLength=0;
    float dynamicTotal=0;
    float[] result=new float[items.length+1];
    for(String item : items)//calculate totals
    {
      item=item.trim();
      if (item.endsWith("*"))// a star position
      {
        item=item.substring(0,item.length()-1).trim();
        
        dynamicTotal+=float(item);
      }
      else
      {
        fixedLength+=float(item);
      }
    }
    float dynamicUnit=0;
    if (dynamicTotal!=0 && fixedLength<value)
      {
        dynamicUnit=(value-fixedLength)/dynamicTotal;
      }
    
    float current=0;
    for(int i=0;i<items.length;i++)// scan again, now we get the real data
    {
      String item=items[i];
      
      if (item.endsWith("*"))
      {
        item=item.substring(0,item.length()-1);
        current+=float(item)*dynamicUnit;
      }
      else
      {
        current+=float(item);
      }
      result[i+1]=current;
    }
    return result;
  }
}

public class GridCell
{
  PVector topLeft;
  PVector bottomRight;
  PVector world;

  float width;
  float height;
  GridCell(float x, float y, float w, float h, PVector worldTranslate)
  {
    topLeft=new PVector(x,y);
    bottomRight=new PVector(x+w,y+h);
    world=worldTranslate;

    this.width=w;
    this.height=h;
  }
  
  public void translateTo()
  {
    translate(world.x,world.y);
    translate(topLeft.x,topLeft.y);
  }
  public void translateTo(float scaleX, float scaleY)
  {
    translate(world.x*scaleX,world.y*scaleY);
    translate(topLeft.x*scaleX,topLeft.y*scaleY);
  }
  
  public void draw()
  {
    pushMatrix();
    translateTo();
    //shape(shapes);
    popMatrix();
  }
}