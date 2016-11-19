import java.util.Map;

interface BugDelegate {
  void bugCreated(Bug bug);
  void bugCaught(Bug bug);
  void bugDied(Bug bug);
  Player getPlayer();
}

interface GameLifeCycle {
  void gameOver();
}


class BugsController implements BugDelegate, GameLifeCycle {
  boolean isGameOver = false;
  final Player player;
  final BugFactory factory;
  final HashMap<UUID, Bug> gameBugs;
  final HashMap<UUID, Bug> deadBugs;
  final HashMap<UUID, Bug> caughtBugs;
  int allBugsCount = 0;
  int deadBugsCount = 0;
  int caughtBugsCount = 0;
  int playerSpeedAddition = 1;
  final int maxPlaySpeed = 50;

  BugsController(Player player, BugFactory factory) {
    this.player = player;
    this.factory = factory;
    this.gameBugs = new HashMap<UUID, Bug>();
    this.deadBugs = new HashMap<UUID, Bug>();
    this.caughtBugs = new HashMap<UUID, Bug>();
    this.factory.delegate = this;
    this.player.gameController = this;
  }

  void draw() {
    this.drawPlayer();
    this.addWaveOfBugs();
    this.drawLivingBugs();
    this.removeDeadBugs();
    this.removeCaughtBugs();
    this.showScores();
  }

  void keyPressed() {
    int amount = 0;
    if (keyPressed == true) {
      if (key == 'a' || keyCode == LEFT) {
        amount = -this.getPlayerSpeedAmount();
      }
      if (key == 'd' || keyCode == RIGHT) {
        amount = this.getPlayerSpeedAmount();
      }
    }
    this.movePlayer(amount);
  }

  void keyReleased() {
    this.playerSpeedAddition = 0;
    int amount = 0;
    this.movePlayer(amount);
  }

  private int getPlayerSpeedAmount() {
    this.playerSpeedAddition = min(maxPlaySpeed, this.playerSpeedAddition + 1);
    return this.playerSpeedAddition;
  }

  private void movePlayer(int amount) {
    this.player.move(amount);
  }


  private void drawPlayer() {
    this.player.run();
  }

  private void drawLivingBugs() {
    for (Map.Entry<UUID, Bug> me : this.gameBugs.entrySet()) {
      Bug bug = me.getValue();
      bug.run();
    }
  }

  private void addWaveOfBugs() {
    if (this.isGameOver) {
      return;
    }
    timer = millis();
    if (timer%100 == 0) {
      this.addBugsToGame();
    }
  }

  private void addBugsToGame() {
    ArrayList<Bug> newBugs = factory.createBugs();
    for (int i = 0; i < newBugs.size(); i ++) {
      Bug newBug = newBugs.get(i);
      this.bugCreated(newBug);
    }
    print(",", gameBugs.size());
  }

  void removeDeadBugs() {
    if (this.deadBugs != null) {
      for (Map.Entry<UUID, Bug> me : deadBugs.entrySet()) {
        Bug bug = me.getValue();
        this.gameBugs.remove(me.getKey());
      }
    }
    this.deadBugs.clear();
  }

  void removeCaughtBugs() {
    if (this.caughtBugs != null) {
      for (Map.Entry<UUID, Bug> me : caughtBugs.entrySet()) {
        Bug bug = me.getValue();
        this.gameBugs.remove(me.getKey());
      }
    }
    this.caughtBugs.clear();
  }

  void showScores() {
    stroke(255);
    float allBugsDiv = allBugsCount > 0 ? allBugsCount : 1;
    float deadToBugsPerCent = 100 * deadBugsCount/allBugsDiv;
    float caughtToBugsPerCent = 100 * caughtBugsCount/allBugsDiv;

    String deadBugsText = "Dead bugs: " + deadBugsCount +"/" + allBugsCount + " (" + deadToBugsPerCent +"%)";
    text(deadBugsText, 10, 50);
    String caughtBugsText = "Caught bugs: " + caughtBugsCount +"/" + allBugsCount + " (" + caughtToBugsPerCent +"%)";
    text(caughtBugsText, 10, 70);
    int count = this.gameBugs.size();
    String bugsText = "Bugs: " + count;
    text(bugsText, 10, 30);

    String healthText = "Player health: " + this.player.health;
    text(healthText, 10, 90);

    this.showGameOver();
  }


  void gameOver() {
    this.isGameOver = true;
  }

  void showGameOver() {
    if (this.isGameOver) {
      stroke(#FF1177);
      String gameOverText = "GAME OVER!";
      text(gameOverText, width/2 - 50, height/2);
    }
  }

  // Implements: interface BugLifeCycle

  void bugCreated(Bug bug) {
    this.allBugsCount ++;
    this.gameBugs.put(bug.bugID, bug); 
    this.player.bugCreated(bug);
  }

  void bugCaught(Bug bug) {
    if (this.isGameOver) {
      return;
    }
    this.caughtBugsCount ++;
    this.player.bugCaught(bug);
    this.caughtBugs.put(bug.bugID, bug);
  }

  void bugDied(Bug bug) {
    this.deadBugsCount ++;
    this.player.bugDied(bug);
    this.deadBugs.put(bug.bugID, bug);
  }

  Player getPlayer() {
    return this.player;
  }
}