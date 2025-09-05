class hitbox{
 float xpos, ypos, hwidth, hheight; 
  
  hitbox(float x, float y, float _width, float _height)
  {
    xpos = x;
    ypos = y;
    hwidth = _width;
    hheight = _height;
  }
  
  void Draw()
  {
   fill(0, 255, 0, 50);
   rect(xpos, ypos, hwidth, hheight); 
  }
  
}

class graphicblob{
 float xpos, ypos, wwidth, hheight;
 
 graphicblob(float x, float y, float _width, float _height)
 {
   xpos = x;
   ypos = y;
   wwidth = _width;
   hheight = _height;
 }
  
  void SetX(float x)
  {
   xpos = x; 
  }
  
  void SetY(float y)
  {
    ypos = y;
  }  
}

class Object{
  float xpos, ypos, wwidth, hheight;
  hitbox h;
  graphicblob[] blobs = new graphicblob[3];
  
  
  Object(float x, float y, float _width, float _height)
  {
    xpos = x;
    ypos = y;
    wwidth = _width;
    hheight = _height;
    h = new hitbox(x, y, _width, _height);
    
    for(int i = 0; i < blobs.length; i++)
    {
      blobs[i] = new graphicblob(x, y, _width/5, _height/5);
    }
  }
  
  void render(color Colour1, color Colour2)
  {
    fill(Colour1);
    ellipse(xpos, ypos, wwidth, hheight);
    
    if(frameCount % 6 == 0)
    {
      for(int i = 0; i < blobs.length; i++)
      {
        blobs[i].SetX(random(0, wwidth/3));
        blobs[i].SetY(random(0, hheight/3));
      }
    }
    
    //would use a loop here but want to do it in different "quadrants"
    fill(Colour2);
    ellipse(xpos - blobs[0].xpos, ypos - blobs[0].ypos, blobs[0].wwidth, blobs[0].hheight);
    ellipse(xpos + blobs[1].xpos, ypos + blobs[1].ypos, blobs[1].wwidth, blobs[1].hheight);
    ellipse(xpos - blobs[2].xpos, ypos + blobs[2].ypos, blobs[2].wwidth, blobs[2].hheight);
  }
  
  float GetX()
  {
   return xpos; 
  }
  
  float GetY()
  {
   return ypos; 
  }
  
  void ChangeX(float value)
  {
   xpos += value; 
  }
  
  void ChangeY(float value)
  {
   ypos += value; 
  }
  
  void SetX(float value)
  {
    xpos = value;
  }
  
  void SetY(float value)
  {
   ypos = value; 
  }
  
}

class Player extends Object{
  Player(float x, float y, float _width, float _height)
  {
   super(x, y, _width, _height); 
  }
  
  void render(color Colour1, color Colour2)
  {
    //overriding oh yeah
   super.render(Colour1, Colour2); 
   
   //draw the face
   fill(255);
   ellipse(xpos - wwidth/6, ypos - hheight/10, wwidth/4, hheight/4);
  }
  
}



boolean AABB(hitbox a, hitbox b)
{
 return a.xpos - a.hwidth/2 < b.xpos + b.hwidth/2 && a.xpos + a.hwidth/2 > b.xpos - b.hwidth/2 && a.ypos - a.hheight/2 < b.ypos + b.hheight/2 && a.ypos + a.hheight/2 > b.ypos - b.hheight/2;
}
