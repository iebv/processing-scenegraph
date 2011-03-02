/** 
  * A simple(ish) scenegraph example for Processing, with a helper object
  * for moving scene objects around 
  *
  *  Copyright (C) 2011 Evan Raskob <evan@flkr.com>
  *  http://pixelist.info
  *
  *  This program is free software: you can redistribute it and/or modify
  *  it under the terms of the GNU Affero General Public License as
  *  published by the Free Software Foundation, either version 3 of the
  *  License, or (at your option) any later version.

  *  This program is distributed in the hope that it will be useful,
  *  but WITHOUT ANY WARRANTY; without even the implied warranty of
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU Affero General Public License for more details.

  *  You should have received a copy of the GNU Affero General Public License
  *  along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */

class ShapeNode extends DrawableNode
{
  ArrayList<Vec2D> points;
  int closed = CLOSE;
  int primitive = TRIANGLES;
  
  ShapeNode()
  {
    super();
    points = new ArrayList<Vec2D>();
  }
  
  ShapeNode addPoint(int x, int y)
  {
    addPoint(new Vec2D(x,y));    
    return this;
  }


  ShapeNode addPoint(float x, float y)
  {
    addPoint(new Vec2D(x,y));
    return this;
  }
  
  ShapeNode addPoint(Vec2D p)
  {
    points.add(p);
    // for AABB  
    maxX = max(p.x,maxX);
    minX = min(p.x,minX);
    maxY = max(p.y,maxY);
    minY = min(p.y,minY);

    pos.x = minX;
    pos.y = minY;
    
    w = maxX-minX;
    h = maxY-minY;

    return this;
  }
  
  DrawableNode addToPos(Vec2D v)
  {
    // shift all the points
    for (Vec2D p:points)
    {
      p.addSelf(v);
    }

    return super.addToPos(v);
  }
  
  void render()
  {
        
    if (useFill)
      fill(fillc);
    if (useStroke)
      stroke(strokec);
    
    beginShape(primitive);
    for (Vec2D p : points)
    {
      vertex(p.x, p.y);
    }
    endShape(closed);
    
    super.render();
  }
  
// end class 
}
