
public class GridLayout
{
  float[] columns;
  float[] rows;
  float width,height;
  PVector world;
  GridCell[][] cells;
  public GridLayout(float w,float h,PVector worldTranslate)
  {
    this.width=w;
    this.height=h;
    world=worldTranslate;
  }
  public GridLayout(float w,float h)
  {
    this.width=w;
    this.height=h;
    world=new PVector();
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
          cells[r][c]=new GridCell(columns[c],rows[r],columns[c+1]-columns[c],rows[r+1]-rows[r],world);
        }
      }
    }
  }
  
  public void draw()
  {
    if(cells!=null)
    {
      for (int r=0;r<rows.length-1;r++)
      {
        for(int c=0;c<columns.length-1;c++)
        {
          cells[r][c].draw();
        }
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
  PShape shapes;
  float width;
  float height;
  GridCell(float x, float y, float w, float h, PVector worldTranslate)
  {
    topLeft=new PVector(x,y);
    bottomRight=new PVector(x+w,y+h);
    world=worldTranslate;
    shapes=createShape(GROUP);
    this.width=w;
    this.height=h;
  }
  
  public void translateTo()
  {
    translate(world.x,world.y);
    translate(topLeft.x,topLeft.y);
  }
  
  public void addShape(PShape s)
  {
    shapes.addChild(s);
  }
  
  public void draw()
  {
    pushMatrix();
    translateTo();
    shape(shapes);
    popMatrix();
  }
}