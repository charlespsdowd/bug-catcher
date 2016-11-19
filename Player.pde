class Player implements BugDelegate {
  int x = 400;
  int y = 750;
  int xspeed = 7;
  boolean invertedcontrols = false;
  int score = 0;
  int health = 100;
  float hitRadius = 30;

  void display() {
    stroke(0);
    fill(255);
    ellipse(x, y, 75, 75);
    ellipse(x, y-35, 50, 50);
    rect(x-15, y-30, 30, 10, 25);
    ellipse(x-10, y-40, 15, 15);
    ellipse(x+10, y-40, 15, 15);
    ellipse(x+10, y-43, 2, 2);
    ellipse(x-10, y-43, 2, 2);
  }

  void move() {
    if (keyPressed == true) {
      if (key == 'a' || keyCode == LEFT) {
        x = x - xspeed;
      }
    }
    if (keyPressed == true) {
      if (key == 'd' || keyCode == RIGHT) {
        x = x + xspeed;
      }
    }
  }

  void invertcontrols() {
    if (invertedcontrols == true) {
      xspeed = xspeed * -1;
    }
  }

  void displayScore() {
    int offset = 5;
    fill(0);
    textSize(20);

    if (score >= 10) {
      offset = 13;
    } else if (score >= 100) {
      offset = 26;
    }

    text(this.score, x-offset, y+10);
  }

  void run() {
    move();
    display();
    invertcontrols();
    displayScore();
  }

  void addToScore(Bug withBug) {
    this.score += withBug.points;
  }


  // Implements: interface BugLifeCycle

  void bugCreated(Bug bug) {
  }


  void bugCaught(Bug bug) {
    this.addToScore(bug);
    text("Nice catch!", x, y + 20);
  }


  void bugDied(Bug bug) {
  }
  
  Player getPlayer() {
    return this;
  }
  
}