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

class SceneNode
{
  ArrayList<SceneNode> children;
  boolean visible;
  ArrayList<NodeModifier> modifiers;
  String name;

  SceneNode()
  {
    children = new ArrayList<SceneNode>();
    modifiers = new ArrayList<NodeModifier>();
    visible = true;
    name = this.getClass() + "_" + millis();
  }

  // returns this SceneNode for chaining together
  SceneNode addChild(SceneNode child)
  {
    if (!children.contains(child))
      children.add(child);
    else
    {
      // remove it, and add it back on the end
      children.remove(child);
      children.add(child);
    }

    return this;
  }


  SceneNode update()
  {
    for (NodeModifier modifier : modifiers)
    {
      modifier.update(this);
    }
    
    for (SceneNode child : children)
    {
      child.update();
    }
    return this;
  }
  
  
  void render()
  {
    // this could be done in a separate object as well
    for (SceneNode child : children)
    {
      child.render();
    }
  }


  // returns this SceneNode for chaining together
  SceneNode removeChild(SceneNode child)
  {
    if (children.contains(child))
    {
      children.remove(child);
    }

    return this;
  }

  boolean containsChild(SceneNode child)
  {
    return children.contains(child);
  }


  // returns this SceneNode for chaining together
  SceneNode addModifier(NodeModifier modifier)
  {
    if (!modifiers.contains(modifier))
      modifiers.add(modifier);
    else
    {
      // remove it, and add it back on the end
      modifiers.remove(modifier);
      modifiers.add(modifier);
    }

    return this;
  }

  // returns this SceneNode for chaining together
  SceneNode removeModifier(NodeModifier modifier)
  {
    if (modifiers.contains(modifier))
    {
      modifiers.remove(modifier);
    }

    return this;
  }

  boolean containsModifier(NodeModifier modifier)
  {
    return modifiers.contains(modifier);
  }
  
  boolean hasModifiers()
  {
    boolean val = false;
    
    if (modifiers != null && modifiers.size() > 0) val = true;
    
    return val;
  }
}

