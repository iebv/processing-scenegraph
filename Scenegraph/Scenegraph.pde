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

// using toxiclibs for vectors, better than Processing's built-in ones
import toxi.geom.Vec2D;



// this is the main scenegraph:
ArrayList<SceneNode> nodes;


void setup()
{
  size(320,240);
  
  // create scenegraph node list
  nodes = new ArrayList<SceneNode>();
  
  // add a simple shape node
  ShapeNode node = new ShapeNode();
  node.fillc = color(255,0,255);
  node.primitive = QUADS;
  node.addPoint(10,10).addPoint(40,10).addPoint(40,60).addPoint(10,60);

  // add a child to the shape node
  ShapeNode childnode = new ShapeNode();
  childnode.fillc = color(255,255,0);
  childnode.primitive = QUADS;
  childnode.addPoint(40,20).addPoint(60,20).addPoint(60,60).addPoint(40,60);
  node.addChild(childnode);
  
  nodes.add(node);
  
  // now create an image
  ImageNode inode = new ImageNode();
  inode.setImage(loadImage("http://images4.fanpop.com/image/photos/16900000/cuttest-kittens-ever-kittens-16913142-320-240.jpg"));
  inode.setXY(width/2,height/2);
  
  inode.fillc = color(255,255,255,180);
  inode.setWidth(160);
  inode.setHeight(120);
  
  nodes.add(inode);
  
 // moves a node using velocity and (optionally) acceleration with friction  
  NodeMover mover = new NodeMover();
  
  // give it initial accelleration
  mover.a.set(random(2-15),random(3,10));
  
  // add it to a specific shape
  node.addModifier((NodeModifier)mover);
}


void draw()
{
  background(0);
  
  // update and draw all nodes and their children
  for (SceneNode node : nodes)
  {
    node.update();
    node.render();
  }
  
}


void mousePressed()
{
  
  SceneNode node = nodes.get(0);
  if (node.hasModifiers())
  {
    NodeMover nm = (NodeMover)node.modifiers.get(0);
    nm.v.set(0,0);
    nm.a.set(random(2-15),random(3,10));
  }

  println("nodes:" + nodes.size());
  for (SceneNode n : nodes)
  {
    println("node [" + n.name + "::" + n.getClass());
  }
  
  // make the image show up on top
  Collections.swap(nodes, 0,1);
}
