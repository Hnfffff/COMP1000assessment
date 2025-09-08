class HitBox{
 private float xPos, yPos, hWidth, hHeight; 
  
  HitBox(float x, float y, float _width, float _height)
  {
    xPos = x;
    yPos = y;
    hWidth = _width;
    hHeight = _height;
  }
  
  void Draw()
  {
   rectMode(CENTER);
   fill(0, 255, 0, 50);
   rect(xPos, yPos, hWidth, hHeight); 
  }
  
}

class GraphicBlob{
 private float xpos, ypos, wwidth, hheight;
 
 GraphicBlob(float x, float y, float _width, float _height)
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
  HitBox h;
  GraphicBlob[] blobs = new GraphicBlob[3];
  
  
  Object(float x, float y, float _width, float _height)
  {
    xpos = x;
    ypos = y;
    wwidth = _width;
    hheight = _height;
    h = new HitBox(x, y, _width, _height);
    
    for(int i = 0; i < blobs.length; i++)
    {
      blobs[i] = new GraphicBlob(xpos, ypos, _width/5, _height/5);
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
   h.xPos += value;
  }
  
  void ChangeY(float value)
  {
   ypos += value; 
   h.yPos += value;
  }
  
  void SetX(float value)
  {
    xpos = value;
    h.xPos = value;
  }
  
  void SetY(float value)
  {
   ypos = value; 
   h.yPos = value;
  }
  
}

class Player extends Object{
  boolean[] Inputs = new boolean[4];
  
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
   ellipse(xpos + wwidth/6, ypos - hheight/10, wwidth/4, hheight/4);
   
   fill(0);
   ellipse(xpos - wwidth/6, ypos - hheight/10, wwidth/8, hheight/8);
   ellipse(xpos + wwidth/6, ypos - hheight/10, wwidth/8, hheight/8);
   
   fill(255);
   arc(xpos, ypos + hheight/10, wwidth/1.5, hheight/1.5, 0, PI, CHORD);
   arc(xpos, ypos + hheight/10, wwidth/1.5, hheight/4, 0, PI, CHORD);
  }
  
  void setValue(boolean b, int index)
  {
    Inputs[index] = b;
  }
  
  void handleMovement()
  {
   if(Inputs[0] == true)
   {
     super.ChangeX(-3);
   }
   
   if(Inputs[1] == true)
   {
     super.ChangeX(3);
   }
   
   if(Inputs[2] == true)
   {
     super.ChangeY(-3);
   }
   
   if(Inputs[3] == true)
   {
     super.ChangeY(3);
   }
  }
  //i do this because i make it in global scope and it means that the width and height go off 100 instead of the screensize in setip()
  void Innit(float _width, float _height)
  {
    super.wwidth = _width;
    super.hheight = _height;
    super.h.hWidth = _width;
    super.h.hHeight =_height;
    
    for(int i = 0; i < super.blobs.length; i++)
    {
      super.blobs[i] = new GraphicBlob(xpos, ypos, _width/5, _height/5);
    }
  }
}

class Enemy extends Object{
  Enemy(float x, float y, float _width, float _height)
  {
    super(x, y, _width, _height);
  }
  
  void render(color Colour1, color Colour2)
  {
     super.render(Colour1, Colour2); 
   
     //draw face
     fill(255);
     arc(xpos - wwidth/4, ypos - hheight/8, wwidth/3, hheight/3, 0, PI + QUARTER_PI, CHORD);
     arc(xpos + wwidth/4, ypos - hheight/8, wwidth/3, hheight/3, -QUARTER_PI, PI, CHORD);
   
     fill(0);
     arc(xpos - wwidth/4, ypos - hheight/8, wwidth/5, hheight/5, 0, PI + QUARTER_PI, CHORD);
     arc(xpos + wwidth/4, ypos - hheight/8, wwidth/5, hheight/5, -QUARTER_PI, PI, CHORD);
   
     fill(255);
     arc(xpos, ypos + hheight/3, wwidth/1.5, hheight/1.5, -PI, 0, CHORD);
     line(xpos + (wwidth/1.5)/2.5, ypos + (hheight/3)/2, xpos - (wwidth/1.5)/2.5, ypos + (hheight/3)/2);
  }
  
}

class Pickup extends Object{
  float points;
   Pickup(float x, float y, float _width, float _height, float p)
  {
    super(x, y, _width, _height);
    
    points = p;
  }
  
  void render(color Colour1, color Colour2)
  {
     super.render(Colour1, Colour2); 
   
     //draw face
     fill(255);
     line(xpos + wwidth/5 * 2, ypos + hheight/20 - hheight/10, xpos + wwidth/10, ypos - hheight/10);
     line(xpos - wwidth/5 * 2, ypos + hheight/20 - hheight/10, xpos - wwidth/10, ypos - hheight/10);
   
     fill(255);
     arc(xpos, ypos + hheight/6, wwidth/1.5, hheight/3, 0, PI, CHORD);
  }
}

void AddPickups(ArrayList<Pickup> arr)
{
  if(frameCount % 60 == 0 && arr.size() < 10)
  {
    arr.add(new Pickup(random(30, width-30), random(30, height-30), width/12, height/12, 10));
    println(arr.size());
  }
}

void renderObjects(Player p, ArrayList<Pickup> pickupArr)
{
  p.handleMovement();
  p.render(color(60, 168, 50), color(30, 94, 25));
  
  for(int i = 0; i < pickupArr.size(); i++)
  {
    Pickup temp = pickupArr.get(i);
    temp.render(color(0,255,0), color(255,0,0));
  }
}

boolean AABB(HitBox a, HitBox b)
{
 return a.xPos - a.hWidth/2 < b.xPos + b.hWidth/2 && a.xPos + a.hWidth/2 > b.xPos - b.hWidth/2 && a.yPos - a.hHeight/2 < b.yPos + b.hHeight/2 && a.yPos + a.hHeight/2 > b.yPos - b.hHeight/2;
}
