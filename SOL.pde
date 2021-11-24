space Space = new space();
cam Camera = new cam();

void setup()
{
  size(600, 600,P2D);
  frameRate(60);
  
  smooth(0);
  
  noStroke();
}

void draw()
{
  background(50);

  Camera.draw();
  Space.draw();
  fps();
}
