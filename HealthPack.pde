

class HealthPack extends Bug {

  HealthPack(BugDelegate delegate) {
    super(delegate);
    points = 0;
    yspeed = 6;
    baseJitter = 0;
    hitRadius = 30; 
    health = int(random(1, 100));
  }

  void draw() {
    fill(#12CB26);
    ellipse(x, y, 80, 80);
    fill(0);
    rect(x-30, y-7.5, 57, 12, 40);
    rect(x-7.75, y-30, 12, 57, 40);
  }
}