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

// should really be abstract
// a node that will be drawn to the screen at some point

class DrawableNode extends ColoredNode
{
  protected float w;
  protected float h;
  protected float maxX, minX, maxY, minY;
  protected Vec2D pos;  // position  

  DrawableNode()
  {
     super();
     minX = minY = MAX_FLOAT;
     maxX = maxY = -MAX_FLOAT;
     pos = new Vec2D(0,0);
  }
  
  protected DrawableNode updateShapeVars()
  {
    minX = pos.x;
    maxX = pos.x+w;
    minY = pos.y;
    maxY = pos.y+h;
    
    return this;
  }
  
  // returns a DrawableNode for chaining together
  DrawableNode setXY(float x, float y)
  {
    return setXY(new Vec2D(x,y));
  }

  // returns a DrawableNode for chaining together
  DrawableNode setXY(Vec2D p)
  {
    Vec2D diff = new Vec2D(p.x-pos.x, p.y-pos.y);
    return addToPos(diff);
  }

  // returns a DrawableNode for chaining together
  DrawableNode addToPos(Vec2D v)
  {
    pos.addSelf(v);
    
    minX = pos.x;
    minY = pos.y;
    maxX = pos.x+w;
    maxY = pos.y+h;
    
    for (SceneNode child : children)
    {
      if (child instanceof DrawableNode)
      {
       ((DrawableNode)child).addToPos(v);
      }
    }
    
    return this;
  }
  

  Vec2D XY()
  {
    //TODO
    return pos;
  }
  
  float X()
  {
    return pos.x;
  }
  
  float Y()
  {
    return pos.y;
  }
  
  float H()
  {
    return h;
  }
  
  float W()
  {
    return w;
  }
  
  DrawableNode setWidth(float _width)
  {
    w = _width;
    maxX = pos.x+w;
    return this;
  }
  
  DrawableNode setWidth(int _width)
  {
    w = _width;
    maxX = pos.x+w;
    return this;
  }
  
  DrawableNode setHeight(float _height)
  {
    h = _height;
    maxY = pos.y+h;
    return this;
  }
  
  DrawableNode setHeight(int _height)
  {
    h = _height;
    maxY = pos.y+h;
    return this;
  }

  // based on rectangular bounding boxes
  boolean intersects(DrawableNode other)
  {
    if (minX > other.maxX || other.minX > maxX)
      return false;
     
    if (minY > other.maxY || other.minY > maxY)
      return false;

    return true;
  } 
  
// end class DrawableNode
}
  
