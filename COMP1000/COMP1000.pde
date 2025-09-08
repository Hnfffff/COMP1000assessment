Player MainChar = new Player(50,50,0,0);
ArrayList<Pickup> Pickups = new ArrayList<Pickup>();
ArrayList<Enemy> Enemies = new ArrayList<Enemy>();
int score = 0;
boolean Debug = false;
int timer = 60;

enum State {START, GAME, END};
State GameState = State.START;

void setup()
{
  frameRate(60);
  strokeWeight(2);
  size(700,500);
  MainChar.Innit(height/10, height/10, width/2, height/2);
}


void draw()
{
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
  }
  

}

void keyPressed()
{
  //this is from the references in the documentation im doing it cos i assume its best practice
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
 
   if(key == 'p')
   {
    Debug = !Debug;
    println(Debug);
   }
}

void keyReleased()
{
  //this is from the references in the documentation im doing it cos i assume its best practice
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
  println(MainChar.lastSteppedFrame);
  println(frameCount);
 if(MainChar.stepped == false || frameCount - MainChar.lastSteppedFrame >= 600)
 {
   MainChar.stepped = true;
   MainChar.SetX(mouseX);
   MainChar.SetY(mouseY);
   MainChar.lastSteppedFrame = frameCount;
 }
}
