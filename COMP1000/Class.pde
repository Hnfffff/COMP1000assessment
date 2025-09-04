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
   fill(0,255,0, 50);
   rect(xpos, ypos, hwidth, hheight); 
  }
  
}

class Object{
  float xpos, ypos;
  hitbox h;
  
  Object(float x, float y, float _width, float _height)
  {
    xpos = x;
    ypos = y;
    h = new hitbox(x, y, _width, _height);
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
  Player(float x, float y, float wwidth, float hheight)
  {
   super(x, y, wwidth, hheight); 
    
  }
  
}



boolean AABB(hitbox a, hitbox b)
{
 return a.xpos - a.hwidth/2 < b.xpos + b.hwidth/2 &&
 a.xpos + a.hwidth/2 > b.xpos - b.hwidth/2 &&
 a.ypos - a.hheight/2 < b.ypos + b.hheight/2 &&
 a.ypos + a.hheight/2 > b.ypos - b.hheight/2;
}
