import java.util.UUID;

class Bug {
  BugDelegate delegate;
  UUID bugID;
  float x = random(0+20, width-20); 
  float y = -35;
  float yspeed = 4.5;
  float randombug = random (1, 10);
  int type = 0;
  int points = 0;
  int health = -1;
  private int jitterCount = 10;
  int signValue = 1;
  int baseJitter = 10;
  float hitRadius = 70; 

  Bug(BugDelegate delegate) {
    this.bugID = UUID.randomUUID();
    this.delegate = delegate;
    jitterCount = baseJitter;
  }

  void draw() {
    fill(255);
    basicDisplay();
  }

  void displayScore() {
    int offset = 5;
    fill(0);
    textSize(20);

    if (points >= 10) {
      offset = 13;
    }

    text(this.points, x-offset, y-22);
  }

  void basicDisplay() {
    stroke(63);
    line(x, y, x+50, y+50);
    line(x, y, x-50, y-50);
    line(x, y, x+50, y-50);
    line(x, y, x-50, y+50);
    line(x, y, x+60, y);
    line(x, y, x-60, y);
    ellipse(x, y, 75, 90);
    fill(0);
    ellipse(x+13, y+15, 9, 9);
    ellipse(x+13, y, 9, 9);
    ellipse(x+13, y-15, 9, 9);
    ellipse(x-13, y+15, 9, 9);
    ellipse(x-13, y, 9, 9);
    ellipse(x-13, y-15, 9, 9);

    displayScore();
  }
  
  void showHitBox() {
    noFill();
    stroke(#77FF77);
    ellipse(x,y,hitRadius*2,hitRadius*2);
  }

  int xOffset() {
    return 0;
  }

  int yOffset() {
    return int(yspeed);
  }


  final void move() {
    y = y + this.yOffset();
    x = x + this.xOffset();

    y = max(-50, y);
    y = min(y, height + 50);

    x = max(0, x);
    x = min(x, width);
    
    if(y >= height + 50) {
      this.delegate.bugDied(this);
    }
    
    if(this.isCaught(this.delegate.getPlayer())) {
      this.delegate.bugCaught(this);
    }
  }

  final void run() {
    //basicDisplay();
    if (y < height + 50) {
      move();
      draw();
      showHitBox();
    }
  }

  boolean shouldJitter() {
    jitterCount --;

    if (jitterCount <= 0) {
      jitterCount = baseJitter;
      return true;
    } 

    return false;
  }

  boolean isOffScreen() {

    if (y >= height + 50) {
      return true;
    }

    return false;
  }
  
  boolean isCaught(Player player) {
    if(dist(x , y, player.x, player.y) < (hitRadius + player.hitRadius)) {
      return true;
    }
    
    return false;
  }
  
}