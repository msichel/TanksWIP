PVector explosion;
float rad;
float ls = 0;
float delay = 100;
tank p1, p2;
FloatList terrain = new FloatList();
ArrayList<bullet> shot = new ArrayList<bullet>();
boolean turn1 = true;
float startmove;
boolean fired = false;
int firemode = 0;
void setup()
{
  explosion = new PVector(0,0);
  rad = 0;
  float level = random(150, 300); 
  float slope = random(-1.5,1.5);
  size (800, 450);
  noStroke();
  for (int i = 0; i<width; i++)
  {
    if (level<=150||slope <=-1.5)
    {
      slope+= random(.1);
    }
    else if (level>=300||slope>=1.5)
    {
      slope-=random(.1);
    }
    else
    {
      slope +=random(-.1, .1);
    }
    level+= slope;
    terrain.append(level);
  }
  float rand = random(25, 300);
  p1 = new tank(new PVector(rand-2, height-terrain.get(int(rand))-2), true);
  startmove = rand;
  rand = random(500, 775);
  p2 = new tank(new PVector(rand-2, height-terrain.get(int(rand))-2), false);
}
void draw()
{
  String type;
  if(firemode == 0)
  {
    type = "Normal Shot";
  }
  else if (firemode == 1)
  {
    type = "Big Shot";
  }
  else
  {
    type = "Spread Shot";
  }
  background(0, 255, 255);
  fill(255, 127, 0);
  textSize(12);
  text("Health: " + int(p1.health), 10, 10);
  text("Power: " + int(p1.pow), 10, 20);
  text("Angle: " + int(p1.ang), 10, 30);
  text("Big Shots: "+ p1.num1,10,40);
  text("Spread Shots: "+p1.num2,10,50);
  text("Health: " + int(p2.health), width-100, 10);
  text("Power: " + int(p2.pow), width-100, 20);
  text("Angle: " + int(p2.ang), width-100, 30);
  text("Big Shots: "+ p2.num1,width-100,40);
  text("Spread Shots: "+p2.num2,width-100,50);
  if(turn1)
  {
    text(type,10,60);
  }
  else
  {
    text(type,width-100,60);
  }
  for (int s = 0;s<shot.size();s++)
  {
    bullet b = shot.get(s);
    b.display();
    b.move();
    if (b.pos.x>0&&b.pos.x<width)
    {
      if (b.pos.y<=terrain.get(int(b.pos.x)))
      {
        float d1 = dist(b.pos.x,b.pos.y,p1.pos.x,terrain.get(int(b.pos.x)));
        float d2 = dist(b.pos.x,b.pos.y,p2.pos.x,terrain.get(int(b.pos.x)));
        if(d1<= b.radius)
        {
          p1.damage(b.radius-d1);
        }
        if(d2<= b.radius)
        {
          p2.damage(b.radius-d2);
        }
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
//            float tf = terrain.get(int(b.pos.x)+r);
//            if(tf<0)
//            {
//              tf = 0;
//              terrain.set(int(b.pos.x)+r,0);
//            }
//            if(b.pos.x+float(r)==p1.pos.x)
//            {
//              p1.pos.y = height-tf-2;
//            }
//            if(b.pos.x+float(r)==p2.pos.x)
//            {
//              p2.pos.y = height-tf-2;
//            }
          }
        }
        rad = b.radius;
        ls = millis();
        explosion = b.pos;
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
        firemode = 0;
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
    p1.aim();
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
      else if (key =='1')
      {
        firemode = 0;
      }
      else if (key =='2')
      {
        if (p1.num1>0)
        {
          firemode = 1;
        }
      }
      else if (key =='3')
      {
        if (p1.num2>0)
        {
          firemode = 2;
        }
      }   
      else if (key == ' ')
      {
        if (!p1.shot)
        {
          if(firemode<2)
          {
            shot.add(new bullet(new PVector(p1.pos.x, terrain.get(int(p1.pos.x+2))+2), new PVector(p1.pow*cos(radians(p1.ang))/10, p1.pow*sin(radians(p1.ang))/10),firemode));
            if (firemode == 1)
            {
              p1.num1--;
            }
          }
           else
          {
            for (int i = -10;i<=10;i+=5)
            {
              shot.add(new bullet(new PVector(p1.pos.x, terrain.get(int(p1.pos.x+2))+2), new PVector(p1.pow*cos(radians(p1.ang+(float(i)/2)))/10, p1.pow*sin(radians(p1.ang+(float(i)/2)))/10),firemode));
            }
            p1.num2--;
          }
          p1.fire();
//          firemode = 0;
          fired = true;
        }
      }
    }
  }
  else
  {
    p2.aim();
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
      else if (key =='1')
      {
        firemode = 0;
      }
      else if (key =='2')
      {
        if(p2.num1>0)
        {
          firemode = 1;
        }
      }
      else if (key =='3')
      {
        if(p2.num2 >0)
        {
          firemode = 2;
        }
      } 
      else if (key == ' ')
      {
        if (!p2.shot)
        {
          if (firemode<2)
          {
            shot.add(new bullet(new PVector(p2.pos.x, terrain.get(int(p2.pos.x+2))+2), new PVector(p2.pow*cos(radians(p2.ang))/10, p2.pow*sin(radians(p2.ang))/10),firemode));
            if(firemode == 1)
            {
              p2.num1--;
            }
          }
          else
          {
            for (int i = -10;i<=10;i+=5)
            {
            shot.add(new bullet(new PVector(p2.pos.x, terrain.get(int(p2.pos.x+2))+2), new PVector(p2.pow*cos(radians(p2.ang+(float(i)/2)))/10, p2.pow*sin(radians(p2.ang+(float(i)/2)))/10),firemode));
            }
            p2.num2--;
          }
          p2.fire();
//          firemode = 0;
          fired = true;
        }
      }
    }
  }
  if(millis()-ls<delay)
  {
    fill(255,255,127.5);
    ellipse(explosion.x,height - explosion.y,2*rad,2*rad);
    if(dist(explosion.x,0,p1.pos.x,0)<=rad)
    {
      float t1 = terrain.get(int(p1.pos.x));
      p1.pos.y = height - t1-2;
    }
    if(dist(explosion.x,0,p2.pos.x,0)<=rad)
    {
      float t2 = terrain.get(int(p2.pos.x));
      p2.pos.y = height - t2-2;
    }
  }
  if(p1.health<=0)
  {
    noLoop();
    background(0);
    textSize(50);
    textAlign(CENTER);
    fill(255,0,0);
    text("P2 WINS!",width/2,height/2);
  }
  else if(p2.health<=0)
  {
    noLoop();
    background(0);
    textSize(50);
    textAlign(CENTER);
    fill(0,0,255);
    text("P1 WINS!",width/2,height/2);
  }
}
void reset()
{
  ls = 0;
  terrain.clear();
  shot.clear();
  explosion = new PVector(0,0);
  rad = 0;
  float level = random(150, 300); 
  float slope = random(-1.5,1.5);
  explosion = new PVector(0,0);
  rad = 0;
  for (int i = 0; i<width; i++)
  {
    if (level<=150||slope <=-1.5)
    {
      slope+= random(.1);
    }
    else if (level>=300||slope>=1.5)
    {
      slope-=random(.1);
    }
    else
    {
      slope +=random(-.1, .1);
    }
    level+= slope;
    terrain.append(level);
  }
  float rand = random(25, 300);
  fired = false;
  turn1 = true;
  p1 = new tank(new PVector(rand-2, height-terrain.get(int(rand))-2), true);
  startmove = rand;
  rand = random(500, 775);
  p2 = new tank(new PVector(rand-2, height-terrain.get(int(rand))-2), false);
  p1.health = 100;
  p2.health = 100;
  loop();
  textAlign(CORNER);
}
void keyPressed()
{
  if (key=='r')
  {
    reset();
  }
}
