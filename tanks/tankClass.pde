class tank
{
  float health = 100;
  PVector pos;
  float ang = 90;
  float pow = 50;
  boolean play1; 
  boolean shot = false;
  int num1 = 2;
  int num2 = 2;
  tank(PVector p, boolean p1)
  {
    pos = p;
    play1=p1;
  }
  void damage(float dam)
  {
    health -= dam;
  }
  void fire()
  {
    shot = true;
  }
  void move(PVector npos)
  {
    if (npos.x>=0&&npos.x<width)
    {
      if (!shot&&pos.y-npos.y<=5)
      {
        pos = npos;
      }
    }
  }
  void display()
  {
    if (play1)
    {
      fill(0, 0, 255);
    }
    else
    {
      fill(255, 0, 0);
    }
    rect(pos.x, pos.y, 4, 2);
  }
}

