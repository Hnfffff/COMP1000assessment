//hitbox class, used in everything
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

//little moving blob class
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

//super class for all the main objects
class Object{
  float xpos, ypos, wwidth, hheight;
  HitBox h;
  GraphicBlob[] blobs = new GraphicBlob[3];
  
  //constructor
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
  
  //base fraw function
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
  //getters and setters
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

//subclass player
class Player extends Object{
  boolean[] Inputs = new boolean[4];
  int lastSteppedFrame;
  boolean stepped;
  
  //constructor
  Player(float x, float y, float _width, float _height)
  {
   super(x, y, _width, _height);
   
   //these are for the teleport
   lastSteppedFrame = frameCount;
   stepped = false;
  }
  
  //draw function
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
  
  //setters
  void setValue(boolean b, int index)
  {
    Inputs[index] = b;
  }
  
  //check what keys are pressed down and change x/y based on that
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
  //allows for me to reset the game aswell
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
  
  //reset the step after the timer
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
  //constructor
  Enemy(float x, float y, float _width, float _height, int i, int ii)
  {
    super(x, y, _width, _height);
    //these are used for the random direction
    direction = i;
    upordown = ii;
    moveSpeed = random(2,3);
    
    //reset the hitbox to new instance cos we want it smaller than the actual sprite (make the game more fair)
    super.h = new HitBox(x, y, _width - _width/3, _height - _height/3);
  }
  
  void render(color Colour1, color Colour2)
  {
     super.render(Colour1, Colour2); 
     
     //has it here cos it wont work otherwise
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
  
  //set what the direction is
  void SetDirection(int n)
  {
   direction = n; 
  }
}


//pickup subclass
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
  
  //getter
  int GetPoints()
  {
   return points; 
  }
}

//add pickup to arrraylist if there is less than 10 every second (game runs at 60fps)
void AddPickups(ArrayList<Pickup> arr)
{
  if(frameCount % 60 == 0 && arr.size() < 10)
  {
    arr.add(new Pickup(random(30, width-30), random(30, height-30), height/12, height/12, 10));
  }
}

//draw everything
void renderObjects(Player p, ArrayList<Pickup> pickupArr, ArrayList<Enemy> enemArr)
{
  //draw each pickup in array
  for(int i = 0; i < pickupArr.size(); i++)
  {
    Pickup temp = pickupArr.get(i);
    temp.render(color(0,255,0), color(255,0,0));
  }
  
  //draw each enemy in array
  for(int i = 0; i < enemArr.size(); i++)
  {
    Enemy te = enemArr.get(i);
    te.render(color(255,0,0), color(0,0,255));
  }
  
  //call player movement function
  p.handleMovement();
  
  //draw at different colour based on if it has moved or not
  if(p.stepped == false)
  {
      p.render(color(60, 168, 50), color(30, 94, 25));
  }
  else
  {
    p.render(color(138, 62, 11), color(194, 100, 37));
  }
  
  //check if we can reset it
  p.CheckCanStepAgain();
  
  //draw ui
  fill(0);
  textSize(height/20);
  text("SCORE: " + score, width/50, height/20);
  text("TIME: " + timer, width/50, height/20 * 3);

}
//move the enemies
void HandleEnemMovement(ArrayList<Enemy> enemArr)
{
  for(int i = 0; i < enemArr.size(); i++)
  {
    //get object
    Enemy t = enemArr.get(i);
    //check the direction its moving in and move it based on that
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
    
    //check if the object is out of bounds and if so remove it
    if(t.xpos < -30 || t.xpos > width + 30 || t.ypos < -30 || t.ypos > height + 30)
    {
      enemArr.remove(i);
    }
  }
}


//check collisions
void CollisionCheck(Player p, ArrayList<Pickup> pickupArr, ArrayList<Enemy> enemArr)
{
  for(int i = 0; i < pickupArr.size(); i++)
  {
    //if collision using helper function add points and remove pickup
   Pickup temp = pickupArr.get(i); 
   if(AABB(p.h, temp.h))
   {
     pickupArr.remove(i);
     score += temp.points;
   }
  }
  
  for(int i = 0; i < enemArr.size(); i++)
  {
    //if collision with enemy remove it and remove points
    Enemy tempe = enemArr.get(i);
    if(AABB(p.h, tempe.h))
    {
      enemArr.remove(i);
     score -= 10; 
    }
  }
  
}

//helper function that reutrns whether 2 boxes have overlapped
boolean AABB(HitBox a, HitBox b)
{
 return a.xPos - a.hWidth/2 < b.xPos + b.hWidth/2 && a.xPos + a.hWidth/2 > b.xPos - b.hWidth/2 && a.yPos - a.hHeight/2 < b.yPos + b.hHeight/2 && a.yPos + a.hHeight/2 > b.yPos - b.hHeight/2;
}

//add enemies
void AddEnemies(ArrayList<Enemy> arrl)
{
  //every half second
  if(frameCount % 30 == 0)
  {
    //set random size
    float a = height/random(10,13);
    
    //add item, get item and set the random direction
    arrl.add(new Enemy(width + 300, height + 300, a, a, 0, 0));
    Enemy t = arrl.get(arrl.size()-1);
    t.direction = (int) random(0,2);
    t.upordown = (int) random(0,2);
    
    //set to random x or why based on if were having it move up or down etc
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

//tick down timer every second 
void TimeHandle()
{
 if(frameCount % 60 == 0)
 {
  timer--; 
 }
 
 //if time is out change state
 if(timer <= 0)
 {
  GameState = State.END;
 }
}


//draw main menu
void DrawMainMenu()
{
  fill(255);
 background(54, 4, 4); 
 textSize(height/10);
 text("BACTERIA BATTLEGROUND", width/10, 0 + height/10);
 textSize(width/30);
 text("HOW TO PLAY", width/15, 0 + height/10 * 2);
 text("ARROW KEYS TO MOVE", width/15,0 + height/10 * 3);
 text("CLick mouse to teleport when not on cooldown", width/15, 0 + height/10 * 4);
 text("Avoid the enemy bacteria and eat the good ones!", width/15, 0+height/10 * 5);
 text("SPACE TO START", width/4, 0 + height/10 * 7);
}

//draw end screen
void EndScreen()
{
  fill(255);
 background(54, 4, 4); 
 textSize(height/10);
 text("GAME OVER", width/10, 0 + height/10);
 textSize(width/30);
 text("Final Score: " + score, width/15, 0 + height/10 * 2);

 text("SPACE TO RESTART", width/4, 0 + height/10 * 7);
  
}

void innitbg(int[][] arr)
{
 for(int i = 0; i < arr.length; i++)
 {
  for(int j = 0; j < arr[i].length; j++)
  {
   arr[i][j] = random(0, height);
  }
 }
  
  
}
