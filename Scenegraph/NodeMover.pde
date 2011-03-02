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
  
// moves a node based on velocity and acceleration  

class NodeMover implements NodeModifier
{

  Vec2D v;
  Vec2D a;
  float frictionCoef = 1.0f;
  
  public Vec2D MAXV;

  NodeMover()
  {
    v = new Vec2D();
    a = new Vec2D();
    MAXV = new Vec2D(40,40);
  }

  void update(SceneNode node)
  {
    
    if (node instanceof DrawableNode)
    {
      DrawableNode dnode = (DrawableNode)node;
      if (v.x > MAXV.x)
        v.x = MAXV.x;

      if (v.x < -MAXV.x)
        v.x = -MAXV.x;

      if (v.y > MAXV.y)
        v.y = MAXV.y;

      if (v.y < -MAXV.y)
        v.y = -MAXV.y;

      /* DEBUG
      println("v:" + v);
      println("a:" + a);
      println("pospre:"+dnode.XY());
      */
      dnode.addToPos(v);

//      println("pospost:"+dnode.XY());
      v.scaleSelf(frictionCoef);
      v.addSelf(a);
//      a.scaleSelf(0.5);

      // remove accel
      a.set(0,0);

      //    if (pos.x >= width || pos.x <= 0 ||
      //        pos.y >= height || pos.y <= 0)

      float tmpx=dnode.X(), tmpy=dnode.Y();

      if (tmpx > width-dnode.W() || tmpx < 0)
      {
        //alive = false;
        tmpx = constrain(tmpx, 0, width-dnode.W());
        v.x = -v.x;
        a.x = 0;
      }
      if (tmpy > height-dnode.H() || tmpy < 0)
      {
        //alive = false;
        tmpy = constrain(tmpy, 0, height-dnode.H());
        v.y = -v.y;
        a.y = 0;
      }    
      dnode.setXY(tmpx, tmpy);
    }
  }

  // end class
}

