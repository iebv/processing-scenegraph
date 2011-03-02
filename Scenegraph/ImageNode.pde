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

// a node that contains an image

class ImageNode extends DrawableNode
{
  PImage img = null;

  ImageNode()
  {
    super();
  }

  ImageNode setImage(PImage newImg)
  {
    img = newImg;
    setWidth(img.width);
    setHeight(img.height);

    return this;
  }

  void render()
  {
    if (img != null)
    {

      if (useFill)
        tint(fillc);

      if (useStroke)
      { 
        stroke(strokec);
        noFill();
        rectMode(CORNER);
        rect(pos.x, pos.y, w, h);
      }

      image(img, pos.x, pos.y, w, h);
    }

    super.render();
  }
  
// end class
}



