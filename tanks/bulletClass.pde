class bullet
{
  int smode;
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
    fill(255,127,0);
    ellipse(pos.x,height -pos.y,5,5);
  }
}
