class bullet
{
  PVector pos;
  PVector vel;
  PVector acc = new PVector(0,-.1);
  int radius = 20;
  bullet(PVector p, PVector v, int sm)
  {
    pos = p;
    vel = v;
    if(sm == 1)
    {
      radius = 40;
    }
  }
  void move()
  {
    pos.add(vel);
    vel.add(acc);
  }
  void display()
  {
    if(radius==40)
    {
      fill(255,0,0);
    }
    else
    {
      fill(255,255,0);
    }
    ellipse(pos.x,height -pos.y,5,5);
  }
}
