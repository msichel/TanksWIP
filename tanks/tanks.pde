tank p1, p2;
FloatList terrain = new FloatList();
ArrayList<bullet> shot = new ArrayList<bullet>();
boolean turn1 = true;
float startmove;
boolean fired = false;
void setup()
{
  float level = random(150, 300); 
  float slope = 0;
  size (800, 450);
  noStroke();
  for (int i = 0; i<width; i++)
  {
    terrain.append(level);
    if (level<=150)
    {
      slope+= random(.1);
    }
    else if (level>=300)
    {
      slope-=random(.1);
    }
    else
    {
      slope +=random(-.1, .1);
    }
    level+= slope;
  }
  float rand = random(25, 300);
  p1 = new tank(new PVector(rand-2, height-terrain.get(int(rand))-2), true);
  startmove = rand;
  rand = random(500, 775);
  p2 = new tank(new PVector(rand-2, height-terrain.get(int(rand))-2), false);
}
void draw()
{
  background(0, 255, 255);
  fill(255, 127, 0);
  text("Health: " + p1.health, 10, 10);
  text("Power: " + p1.pow, 10, 20);
  text("Angle: " + p1.ang, 10, 30);
  text("Health: " + p2.health, width-75, 10);
  text("Power: " + p2.pow, width-75, 20);
  text("Angle: " + p2.ang, width-75, 30);
  for (int s = 0;s<shot.size();s++)
  {
    bullet b = shot.get(s);
    b.display();
    b.move();
    if (b.pos.x>0&&b.pos.x<width)
    {
      if (b.pos.y<=terrain.get(int(b.pos.x)))
      {
        for (int r = -b.radius;r<b.radius;r++)
        {
          //Problems with these if statements.  Trying to detect if terrain is above or inside a circle
          if (int(b.pos.x)+r>0&&int(b.pos.x)+r<width)
          {
            float t = terrain.get(int(b.pos.x)+r);
            float h = sqrt(sq(b.radius)-sq(float(r)));
            if (t>b.pos.y+h)
            {
              terrain.add(int(b.pos.x)+r,-2*h);
            }
            else if (t>b.pos.y-h)
            {
              terrain.set(int(b.pos.x)+r,(b.pos.y-h));
            }
//            else
//            {
//              print("c");
//            }
          }
        }
        print("\n");
        shot.remove(s);
      }
    }
    else
    {
      shot.remove(s);
    }
  }
  for (int i = 0; i<= terrain.size();i++)
  {
    float g = terrain.get(i);
    fill(0, 255, 0);
    rect(i, height-g, 1, g);
  }
  p1.display();
  p2.display();
  if (fired)
  {
    if (!keyPressed)
    {
      if (shot.size()==0)
      {
        fired = false;
        if (turn1)
        {
          startmove = p2.pos.x;
          p2.shot = false;
          turn1=false;
        }
        else
        {
          startmove = p1.pos.x;
          p1.shot = false;
          turn1 = true;
        }
      }
    }
  }
  else if (turn1)
  {
    if (keyPressed)
    {
      if (keyCode==LEFT)
      {
        if (abs(p1.pos.x+2-startmove)<50)
        {
          p1.move(new PVector(p1.pos.x-1, height -(terrain.get(int(p1.pos.x+1)))-2));
        }
      }
      else if (keyCode==RIGHT)
      {
        if (abs(p1.pos.x+2-startmove)<50)
        {
          p1.move(new PVector(p1.pos.x+1, height -(terrain.get(int(p1.pos.x+3)))-2));
        }
      }
      else if (key == 'a')
      {
        if (p1.ang<180)
        {
          p1.ang++;
        }
      }
      else if (key == 'd')
      {
        if (p1.ang>0)
        {
          p1.ang--;
        }
      }
      else if (keyCode==DOWN)
      {
        if (p1.pow>20)
        {
          p1.pow--;
        }
      }
      else if (keyCode==UP)
      {
        if (p1.pow<100)
        {
          p1.pow++;
        }
      }
      else if (key == ' ')
      {
        if (!p1.shot)
        {
          shot.add(new bullet(new PVector(p1.pos.x, terrain.get(int(p1.pos.x+2))+2), new PVector(p1.pow*cos(radians(p1.ang))/10, p1.pow*sin(radians(p1.ang))/10)));
          p1.fire();
          fired = true;
        }
      }
    }
  }
  else
  {
    if (keyPressed)
    {
      if (keyCode==LEFT)
      {
        if (abs(p2.pos.x+2-startmove)<50)
        {
          p2.move(new PVector(p2.pos.x-1, height -(terrain.get(int(p2.pos.x+1)))-2));
        }
      }
      else if (keyCode==RIGHT)
      {
        if (abs(p2.pos.x+2-startmove)<50)
        {
          p2.move(new PVector(p2.pos.x+1, height -(terrain.get(int(p2.pos.x+3)))-2));
        }
      }
      else if (key == 'a')
      {
        if (p2.ang<180)
        {
          p2.ang++;
        }
      }
      else if (key == 'd')
      {
        if (p2.ang>0)
        {
          p2.ang--;
        }
      }
      else if (keyCode==DOWN)
      {
        if (p2.pow>20)
        {
          p2.pow--;
        }
      }
      else if (keyCode==UP)
      {
        if (p2.pow<100)
        {
          p2.pow++;
        }
      }
      else if (key == ' ')
      {
        if (!p2.shot)
        {
          shot.add(new bullet(new PVector(p2.pos.x, terrain.get(int(p2.pos.x+2))+2), new PVector(p2.pow*cos(radians(p2.ang))/10, p2.pow*sin(radians(p2.ang))/10)));
          p2.fire();
          fired = true;
        }
      }
    }
  }
}

