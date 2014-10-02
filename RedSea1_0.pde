//The Red Sea. I want to see The Red Sea on a wall.

//class of each light bar that appears onscreen
class Bar{
  int ix;
  int iy;
  int sx;
  int sy;
  int ex;
  int ey;
  color c;
  
  Bar(int tempix, int tempiy, int tempsx, int tempsy, int tempex, 
      int tempey, color tempc){
    int rx = int(random(-20,20));
    int ry = int(random(-10,10));
    ix = tempix;
    iy = tempiy;
    sx = tempsx + rx;
    sy = tempsy + ry;
    ex = tempex + rx;
    ey = tempey + ry;
    c = tempc;
  }
  
  //colours are based off of noise and realtive position, so each
  //colurs shift in slight uinson.
  void update(float t){
    c = color(255*noise(ix/20.0,iy/20.0, t/2.0),
              255*noise(ix/20.0 + 5,iy/20.0 + 5, t/20.0 + 5),
              255*noise(ix/20.0 + 10,iy/20.0 + 10, t/400.0 + 10));
  }
  
  //draws with mouse accounted for. Some trig is used to make the
  //waves
  void display(float t){
    stroke(c);
    strokeWeight(2);
    int sx2 = sx - (mouseX - sx)/4;
    int sy2 = sy - (mouseY - sy)/5; 
    int ex2 = ex - (mouseX - ex)/5; 
    int ey2 = ey - (mouseY - ey)/6;  
    line(sx2 + 4*cos(ix/10.0+iy/10.0-t),
         sy2 + 10*sin(ix/10.0+iy/10.0-t),
         ex2 + 2*cos(ix/10.0+iy/10.0-t),
         ey2 + 10*sin(ix/10.0+iy/10.0-t));
  }
}

ArrayList<Bar> bars;

//creates the bars semi-randomly
void setup(){
  size(1800,500);
  bars = new ArrayList<Bar>();
  int dw = width/100;
  int dh = height/10;
  for (int x = 0; x < 100; x++){
    for(int y = 0; y < 10; y++){
       bars.add(new Bar(x,y,
                dw*(x)+int(50*(noise(x/20.0 + 10,y/20.0 + 10)-0.5)), 
                dh*(y)+int(50*(noise(x/20.0 + 5,y/20.0 + 5)-0.5)),
                dw*(x)+5+int(50*noise(x/20.0,y/20.0) - 0.5),
                dh*(y)+50+int(50*noise(x/20.0 - 5,y/20.0 - 5)-0.5),
                 color(255,0,0)));
    }
  }
  noStroke();
  
  fill(0,0,0);
  rect(0,0,width,height);
}

//draws with low-alpha background, to allow for blur, and adds any 
//time-based trig movement and mouse movement
void draw(){
  //background(0,0,0, 200);
  noStroke();
  fill(0,0,0,3);
  rect(0,0,width,height);
  float t = millis()/1000.0;
  for (int i = bars.size()-1; i >= 0; i--) {
    Bar bar = bars.get(i);
    bar.update(t);
    bar.display(t);
  }
}
