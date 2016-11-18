import java.util.Map;

interface BugDelegate {
  void bugCreated(Bug bug);
  void bugCaught(Bug bug);
  void bugDied(Bug bug);
}


class BugsController implements BugDelegate {
  Player player;
  BugFactory factory;
  HashMap<UUID, Bug> gameBugs;
  HashMap<UUID, Bug> deadBugs;
  int allBugsCount = 0;
  int deadBugsCount = 0;
  int caughtBugsCount = 0;

  BugsController(Player player, BugFactory factory) {
    this.player = player;
    this.factory = factory;
    this.gameBugs = new HashMap<UUID, Bug>();
    this.deadBugs = new HashMap<UUID, Bug>();
    this.factory.delegate = this;
  }

  void draw() {
    player.run();
    this.addWaveOfBugs();
    this.drawLivingBugs();
    this.removeDeadBugs();
    this.showScores();
  }


  private void drawLivingBugs() {
    for (Map.Entry<UUID, Bug> me : this.gameBugs.entrySet()) {
      Bug bug = me.getValue();
      bug.run();
    }
  }

  private void addWaveOfBugs() {
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

  void showScores() {
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
  }


  // Implements: interface BugLifeCycle

  void bugCreated(Bug bug) {
    this.allBugsCount ++;
    this.gameBugs.put(bug.bugID, bug); 
    this.player.bugCreated(bug);
  }

  void bugCaught(Bug bug) {
    this.caughtBugsCount ++;
    this.player.bugCaught(bug);
  }

  void bugDied(Bug bug) {
    this.deadBugsCount ++;
    this.player.bugDied(bug);
    this.deadBugs.put(bug.bugID, bug);
  }
}