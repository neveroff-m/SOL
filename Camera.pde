class cam
{
  vec p;
  int speed = 10;

  cam()
  {
    p = new vec(-300, -300);
  }

  void draw()
  {
    translate(-p.x, -p.y);

    if (mouseX < 100) p.x-=speed;
    if (mouseX > 500) p.x+=speed;
    if (mouseY < 100) p.y-=speed;
    if (mouseY > 500) p.y+=speed;
    if (mousePressed) 
    {
      //p = Space.Sol[int(random(0, Space.S-1))].p;
      //p = add(p,new vec(600,300));
    }
  }
}
