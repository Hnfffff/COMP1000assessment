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
 float xpos, ypos, wwidth, hheight;
 
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
      blobs[i] = new GraphicBlob(random(0, wwidth/3), random(0, hheight/3), _width/5, _height/5);
    }
  }
  
  void render(color Colour1, color Colour2)
  {
    if(Debug == true)
    {
       h.Draw(); 
    }
    
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
  int lastSteppedFrame;
  boolean stepped;
  
  Player(float x, float y, float _width, float _height)
  {
   super(x, y, _width, _height);
   lastSteppedFrame = frameCount;
   stepped = false;
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
  void Innit(float _width, float _height, float x, float y)
  {
    super.wwidth = _width;
    super.hheight = _height;
    super.h.hWidth = _width;
    super.h.hHeight =_height;
    super.xpos = x;
    super.ypos = y;
    super.h.xPos = x;
    super.h.yPos = y;
    
    for(int i = 0; i < super.blobs.length; i++)
    {
      super.blobs[i] = new GraphicBlob(random(0, wwidth/3), random(0, hheight/3), _width/5, _height/5);
    }
  }
  
  void CheckCanStepAgain()
  {
    if(frameCount - MainChar.lastSteppedFrame >= 600)
    {
     stepped = false; 
    }
  }
}

class Enemy extends Object{
  int direction;
  int upordown;
  float moveSpeed;
  Enemy(float x, float y, float _width, float _height, int i, int ii)
  {
    super(x, y, _width, _height);
    direction = i;
    upordown = ii;
    moveSpeed = random(2,3);
    super.h = new HitBox(x, y, _width - _width/3, _height - _height/3);
  }
  
  void render(color Colour1, color Colour2)
  {
     super.render(Colour1, Colour2); 
     
     if(Debug)
     {
      super.h.Draw(); 
     }
   
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
  
  void SetDirection(int n)
  {
   direction = n; 
  }
}

class Pickup extends Object{
  int points;
   Pickup(float x, float y, float _width, float _height, int p)
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
  
  int GetPoints()
  {
   return points; 
  }
}

void AddPickups(ArrayList<Pickup> arr)
{
  if(frameCount % 60 == 0 && arr.size() < 10)
  {
    arr.add(new Pickup(random(30, width-30), random(30, height-30), height/12, height/12, 10));
  }
}

void renderObjects(Player p, ArrayList<Pickup> pickupArr, ArrayList<Enemy> enemArr)
{
  for(int i = 0; i < pickupArr.size(); i++)
  {
    Pickup temp = pickupArr.get(i);
    temp.render(color(0,255,0), color(255,0,0));
  }
  
  for(int i = 0; i < enemArr.size(); i++)
  {
    Enemy te = enemArr.get(i);
    te.render(color(255,0,0), color(0,0,255));
  }
  
  p.handleMovement();
  if(p.stepped == false)
  {
      p.render(color(60, 168, 50), color(30, 94, 25));
  }
  else
  {
    p.render(color(138, 62, 11), color(194, 100, 37));
  }
  
  p.CheckCanStepAgain();
  
  fill(0);
  textSize(height/20);
  text("SCORE: " + score, width/50, height/20);

}

void HandleEnemMovement(ArrayList<Enemy> enemArr)
{
  for(int i = 0; i < enemArr.size(); i++)
  {
    Enemy t = enemArr.get(i);
    if(t.direction == 0)
    {
      if(t.upordown == 0)
      {
          t.ChangeY(t.moveSpeed);
      }
      else
      {
        t.ChangeY(-t.moveSpeed);
      }
    }
    else
    {
      if(t.upordown == 0)
      {
          t.ChangeX(t.moveSpeed);
      }
      else
      {
        t.ChangeX(-t.moveSpeed);
      }
    }
    
    if(t.xpos < -30 || t.xpos > width + 30 || t.ypos < -30 || t.ypos > height + 30)
    {
      enemArr.remove(i);
    }
  }
}


void CollisionCheck(Player p, ArrayList<Pickup> pickupArr, ArrayList<Enemy> enemArr)
{
  for(int i = 0; i < pickupArr.size(); i++)
  {
   Pickup temp = pickupArr.get(i); 
   if(AABB(p.h, temp.h))
   {
     pickupArr.remove(i);
     score += temp.points;
   }
  }
  
  for(int i = 0; i < enemArr.size(); i++)
  {
    Enemy tempe = enemArr.get(i);
    if(AABB(p.h, tempe.h))
    {
      enemArr.remove(i);
     score -= 10; 
    }
  }
  
}

boolean AABB(HitBox a, HitBox b)
{
 return a.xPos - a.hWidth/2 < b.xPos + b.hWidth/2 && a.xPos + a.hWidth/2 > b.xPos - b.hWidth/2 && a.yPos - a.hHeight/2 < b.yPos + b.hHeight/2 && a.yPos + a.hHeight/2 > b.yPos - b.hHeight/2;
}

void AddEnemies(ArrayList<Enemy> arrl)
{
  if(frameCount % 30 == 0)
  {
    float a = height/random(10,13);
    arrl.add(new Enemy(width + 300, height + 300, a, a, 0, 0));
    Enemy t = arrl.get(arrl.size()-1);
    t.direction = (int) random(0,2);
    t.upordown = (int) random(0,2);
    if(t.direction == 0)
    { 
      t.SetX(random(10, width - 10));
      if(t.upordown == 0)
      {
        t.SetY(-30);
        arrl.set(arrl.size()-1, t);
      }
      else
      {
        t.SetY(height + 30);
        arrl.set(arrl.size()-1, t);
      }
    }
    else
    {
      t.SetY(random(10, width - 10));
      if(t.upordown == 0)
      {
        t.SetX(-30);
        arrl.set(arrl.size()-1, t);
      }
      else
      {
        t.SetX(width + 30);
        arrl.set(arrl.size()-1, t);
      }
    }
  }
}

void TimeHandle()
{
 if(frameCount % 60 == 0)
 {
  timer--; 
 }
}

void DrawMainMenu()
{
 background(54, 4, 4); 
 textSize(height/10);
 text("BACTERIA BATTLEGROUND", width/10, height/2);
  
}
