
public class GridLayout
{
  float[] columns;
  float[] rows;
  float width,height;
  PVector topLeft;
  GridCell[][] cells;
  GridLayout parent;
  boolean enableBackground;
  color[] background;
  
  public GridLayout(GridLayout p, int row,int col, int rowSpan, int colSpan)
  { 
    topLeft=p.cells[row][col].topLeft;
    PVector bottomRight=p.cells[row+rowSpan][col+colSpan].bottomRight;
    this.width=bottomRight.x-topLeft.x;
    this.height=bottomRight.y-topLeft.y;
  }
  
  
  public GridLayout(float w,float h)
  {
    this.width=w;
    this.height=h;
    topLeft=new PVector();
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
  
  public void setColumns(String data)
  {
    columns=parseGapDefinition(data,this.width);
    refreshCells();
  }
  
  public void setRows(String data)
  {
    rows=parseGapDefinition(data,this.height);
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
  
  public void draw()
  {
    pushMatrix();
    translateTo();
    //shape(shapes);
    popMatrix();
  }
}