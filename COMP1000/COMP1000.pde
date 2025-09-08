Player MainChar = new Player(50,50,50,50);
ArrayList<Pickup> Pickups = new ArrayList<Pickup>();

void setup()
{
  frameRate(60);
  strokeWeight(2);
  size(500,500);
  MainChar.Innit(width/10, height/10);
}


void draw()
{
  background(255);
  renderObjects(MainChar, Pickups);
  AddPickups(Pickups);
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
