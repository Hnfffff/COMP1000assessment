/*
  
  
  
  
  
  
  
*/
//player instance
Player MainChar = new Player(50,50,0,0);
//arraylist for pickups and enemies
ArrayList<Pickup> Pickups = new ArrayList<Pickup>();
ArrayList<Enemy> Enemies = new ArrayList<Enemy>();
float[][] BackgroundSpheresPos = new float[2][10];


int score = 0;
boolean Debug = false;
int timer = 60;

enum State {START, GAME, END};
State GameState = State.START;

void setup()
{
  //setup, innit function to set it at the new width and height
  frameRate(60);
  strokeWeight(2);
  size(700,200);
  MainChar.Innit(height/10, height/10, width/2, height/2);
}


void draw()
{
  //check what state and draw certain things based on it
  if(GameState == State.START)
  {
    DrawMainMenu();
  }
  
  else if(GameState == State.GAME)
  {
    background(255);
    CollisionCheck(MainChar, Pickups, Enemies);
    renderObjects(MainChar, Pickups, Enemies);
    AddPickups(Pickups);
    AddEnemies(Enemies);
    HandleEnemMovement(Enemies);
    TimeHandle();
  }
  else if(GameState == State.END)
  {
    EndScreen();
    
  }
}

void keyPressed()
{
  //this is from the references in the documentation im doing it cos i assume its best practice
  //arrowkeys
 if(key == CODED)
 {
   if(keyCode == UP)
   {
     MainChar.setValue(true, 2);
   }
   
   if(keyCode == DOWN)
   {
    MainChar.setValue(true, 3); 
   }
   
   if(keyCode == LEFT)
   {
    MainChar.setValue(true, 0); 
   }
   
   if(keyCode == RIGHT)
   {
    MainChar.setValue(true, 1);
   }
 }
 //show debug hitboxes
   if(key == 'p')
   {
    Debug = !Debug;
   }
   
   //check space if on main meny
   if(GameState == State.START && key == ' ')
   {
     GameState = State.GAME;
     MainChar.stepped = false;
   }
   
   //check space on endscreen
   if(GameState == State.END && key == ' ')
   {
     
    //reset the game
    GameState = State.GAME;
    MainChar.Innit(height/10, height/10, width/2, height/2);
    timer = 60;
    score = 0;
    Pickups.clear();
    Enemies.clear();
    MainChar.stepped = false;
   }
}

void keyReleased()
{
  //remove from move array
 if(key == CODED)
 {
   if(keyCode == UP)
   {
     MainChar.setValue(false, 2); 
   }
   
   if(keyCode == DOWN)
   {
    MainChar.setValue(false, 3); 
   }
   
   if(keyCode == LEFT)
   {
    MainChar.setValue(false, 0); 
   }
   
   if(keyCode == RIGHT)
   {
    MainChar.setValue(false, 1); 
   }
 }
}

void mousePressed()
{
  //check if it has been more than 10 seconds
 if(MainChar.stepped == false || frameCount - MainChar.lastSteppedFrame >= 600)
 {
   //teleport player
   MainChar.stepped = true;
   MainChar.SetX(mouseX);
   MainChar.SetY(mouseY);
   MainChar.lastSteppedFrame = frameCount;
 }
}
