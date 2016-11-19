class Player implements BugDelegate {
  GameLifeCycle gameController;
  int x = 400;
  int y = 750;
  int xspeed = 10;
  boolean invertedcontrols = false;
  int score = 0;
  int health = 100;
  float hitRadius = 30;

  void display() {
    stroke(255);
    fill(this.healthColor());
    ellipse(x, y, 75, 75);
    ellipse(x, y-35, 50, 50);
    rect(x-15, y-30, 30, 10, 25);
    ellipse(x-10, y-40, 15, 15);
    ellipse(x+10, y-40, 15, 15);
    ellipse(x+10, y-43, 2, 2);
    ellipse(x-10, y-43, 2, 2);
  }

  color healthColor() {
    int red = int(128.0 * (1.0 - health/100.0));
    int green = int(128.0 * (health/100.0));
    int blue = 0;
    color c = color(red, green, blue);
    return c;
  }

  void move(int speed) {
    x = x + speed * xspeed;
    x = max(0, x);
    x = min(x, width);
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
    } else if (score >= 1000) {
      offset = 51;
    }

    text(this.score, x-offset, y+10);
  }

  void run() {
    display();
    invertcontrols();
    displayScore();
    shouldEndGame();
  }
  
  void shouldEndGame() {
    if(this.health <= 0) {
      this.gameController.gameOver();
    }
  }

  void addToScore(Bug withBug) {
    if(withBug.points >= 0) {
        text("Nice catch!", x - 20, y + 20);
    } else {
        text("Ouch!", x - 20, y + 20);
    }

    this.score += withBug.points;
    this.health += withBug.health;
    this.health = max(0, this.health);
    this.health = min(this.health, 100);
  }


  // Implements: interface BugLifeCycle

  void bugCreated(Bug bug) {
  }


  void bugCaught(Bug bug) {
    this.addToScore(bug);
  }


  void bugDied(Bug bug) {
  }

  Player getPlayer() {
    return this;
  }
}