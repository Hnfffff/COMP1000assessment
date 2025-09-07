Player MainChar = new Player(10,10,50,50);

void setup()
{
  size(100,100);
}


void draw()
{
  MainChar.render(color(255,0,0), color(0,255,0));
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

void renderObjects()
{
  
  
}
