class vec
{
  float x;
  float y;

  vec(float x, float y)
  {
    this.x = x;
    this.y = y;
  }
  
  float size()
  {
    return x*x+y*y;
  }
}

vec add(vec A, vec B)
{
  return new vec(A.x+B.x, A.y+B.y);
}

vec dis(vec A, vec B)
{
  return new vec(A.x-B.x, A.y-B.y);
}

vec pow(vec A, float k)
{
  return new vec(A.x*k, A.y*k);
}

vec line(vec E, float size)
{
  return pow(E, size/sqrt(E.size()));
}

vec rand(float min,float max)
{
  return new vec(random(min,max),random(min,max));
}

vec horde(vec E,float size)
{
  return line(new vec(-E.y,E.x),sqrt(size));
}
