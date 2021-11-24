class space
{
  int S = 1000;
  sol[] Sol;

  space()
  {
    Sol = new sol[S];

    for (int i=0; i<S; i++)
    {
      Sol[i] = new sol(new vec(0, 0), new vec(0, 0), 0);
      //Sol[i].n = 0;
      
      Sol[i].p = new vec(random(-1000, 1000), random(-1000, 1000));
       
       vec R = dis(Sol[i].p, new vec(0, 0));  
       Sol[i].v = horde(R, random(0, 5));
       Sol[i].m = random(1, 20);
       Sol[i].t = random(0, 100);
       
       Sol[i].calcR();
       
    }
/*
    Sol[0].p = new vec(0, 0);
    Sol[0].m = 11000;
    Sol[0].n = 1;
    Sol[0].calcR();

    Sol[1].p = new vec(300, 0);
    Sol[1].m = 2000;
    Sol[1].n = 1000;
    Sol[1].t = 0;
    Sol[1].calcR();
    */
  }

  void draw()
  {
    //Сила притяжения
    for (int i=0; i<S; i++)
    {
      if (Sol[i].n != 0)
      {
        Sol[i].a = new vec(0, 0);
        for (int j=0; j<S; j++)
        {
          if (Sol[j].n != 0)
          {
            if (i != j)
            {
              vec R = dis(Sol[j].p, Sol[i].p);
              float F = G*Sol[j].m/R.size();
              Sol[i].a = add(Sol[i].a, line(R, F));
            }
          }
        }
      }
    }
    //Движение
    for (int i=0; i<S; i++)
    {
      if (Sol[i].n != 0)
      {
        Sol[i].calc();
      }
    }

    //Разрыв от гравитации
    for (int i=0; i<S; i++)
    {
      if ((sqrt(Sol[i].a.size()) > G*Sol[i].m/sq(Sol[i].R/2)/2) && (Sol[i].n > 1) && (Sol[i].bh == 0))
      {
        //print("1");
        int n = Sol[i].n/2;
        float m = Sol[i].m/2;
        float R = Sol[i].R*0.35;
        float t = Sol[i].t;
        int o = Sol[i].n % 2;
        vec p = Sol[i].p;
        vec v = Sol[i].v;
        Sol[i].n = 0;

        float a = 3.1415;
        float da = random(0, 6.283);

        for (int j=0; j<2; j++)
        {
          int s = 0;
          while (true)
          {
            s++;
            if (Sol[s].n == 0)
            {
              break;
            }
          }

          vec r = new vec(R*cos(a*j+da), R*sin(a*j+da));
          Sol[s].p = add(p, line(r, random(0, R)));

          Sol[s].n = n;
          Sol[s].m = m;
          Sol[s].v = v;
          Sol[s].t = t;

          Sol[s].calcR();

          if (j == 1) Sol[s].n+=o;
        }
      }
    }

    //Слияние
    for (int i=0; i<S; i++)
    {
      if (Sol[i].n != 0)
      {
        for (int j=0; j<S; j++)
        {
          if (Sol[j].n != 0)
          {
            if (i != j)
            {
              vec R = dis(Sol[j].p, Sol[i].p);
              if ((abs(R.x)+abs(R.y))*3 < Sol[j].R + Sol[i].R)
              {
                Sol[i].p = pow(add(pow(Sol[i].p, Sol[i].m), pow(Sol[j].p, Sol[j].m)), 1/(Sol[i].m+Sol[j].m));
                Sol[j].p = new vec(0, 0);

                Sol[i].v = pow(add(pow(Sol[i].v, Sol[i].m), pow(Sol[j].v, Sol[j].m)), 1/(Sol[i].m+Sol[j].m));
                Sol[j].v = new vec(0, 0);

                Sol[i].t = (Sol[i].t*Sol[i].m+Sol[j].t*Sol[j].m)/(Sol[i].m+Sol[j].m);
                Sol[j].t = 0;

                Sol[i].m = Sol[i].m + Sol[j].m;
                Sol[j].m = 0;

                Sol[i].n = Sol[i].n + Sol[j].n;
                Sol[j].n = 0;

                Sol[i].bh = Sol[i].bh+Sol[j].bh - Sol[i].bh*Sol[j].bh;

                Sol[i].calcR();
              }
            }
          }
        }
      }
    }


    //Смерть
    for (int i=0; i<S; i++)
    {
      if ((Sol[i].n != 0) && (Sol[i].bh == 0))
      {
        if (Sol[i].t > 255)
        {
          vec p = Sol[i].p;
          float n = Sol[i].n;
          float m = Sol[i].m/n;
          float R = Sol[i].R/2;
          Sol[i].n = 0;
          float a = 6.283/n;
          float da = random(0, 6.283);
          vec v = Sol[i].v;

          for (int j=0; j<n-1; j++)
          {
            int s = 0;
            while (true)
            {
              s++;
              if (Sol[s].n == 0)
              {
                break;
              }
            }

            vec r = new vec(R*cos(a*j+da), R*sin(a*j+da));

            Sol[s].p = add(p, line(r, random(0, R)));
            Sol[s].v = add(line(r, random(0, 10)), v);
            Sol[s].m = m;
            Sol[s].n = 1;
            Sol[s].t = 0;

            Sol[s].calcR();
          }
        }
      }
    }

    //Превращение в черную дыру

    for (int i=0; i<S; i++)
    {
      if ((Sol[i].m > 10000) && (Sol[i].t < 200))
      {
        Sol[i].bh = 1;
        Sol[i].t = 0;
        Sol[i].n = 1;
        Sol[i].calcR();
      }
    }




    float N = 0;
    for (int i=0; i<S; i++)
    {
      N += Sol[i].m;
      Sol[i].draw();
    }
    //println(N);
  }
}
