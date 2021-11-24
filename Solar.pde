class sol
{
  vec p;
  vec v;
  vec a;

  float m;
  float R;

  int n;
  int bh;
  float t;

  sol(vec p, vec v, float m)
  {
    this.p = p;
    this.v = v;
    this.m = m;

    a = new vec(0, 0);

    calcR();

    n = 1;
    t = 0;
    bh = 0;
  }

  void draw()
  {
    if ((p.x-Camera.p.x>0) && (p.x-Camera.p.x<600) && (p.y-Camera.p.y>0) && (p.y-Camera.p.y<600))
    {
      Color();
      if (t > 200) calcR();
      if (n != 0) 
      {
      //circle(p.x, p.y, R);
      rect(p.x-R/2,p.y-R/2,R,R);
      }
    }
  }

  void calc()
  {  
    v = add(v, pow(a, dt));
    p = add(p, pow(v, dt));
    t+=dt*(n-1)/500;
  }

  void calcR()
  {
    if (t < 200)
    {
      R = sqrt(m);
    } else
    {
      R = sqrt(m)*((t-200)/7+1);
    }

    if (bh == 1) R = 4;
  }

  void Color()
  {
    if (bh == 0)
    {
      fill(255, 255-t, 0);
    }
    if (bh == 1)
    {
      fill(0, 0, 0);
    }
  }
}
