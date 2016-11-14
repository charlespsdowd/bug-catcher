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

  BugsController(Player player, BugFactory factory) {
    this.player = player;
    this.factory = factory;
    this.gameBugs = new HashMap<UUID, Bug>();
    this.factory.delegate = this;
  }

  void draw() {
    player.run();
    this.addWaveOfBugs();
    this.drawLivingBugs();
    this.removeDeadBugs();
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
      this.addBugToGame();
    }
  }

  private void addBugToGame() {
    ArrayList<Bug> newBugs = factory.createBugs();
    for (int i = 0; i < newBugs.size(); i ++) {
      Bug newBug = newBugs.get(i);
      this.bugCreated(newBug);
    }
    print(",", gameBugs.size());
  }

  void removeDeadBugs() {
    String deadBugsText = "Dead bugs: " + deadBugsCount +"/" + allBugsCount;
    text(deadBugsText, 10, 50);

    for (Map.Entry<UUID, Bug> me : deadBugs.entrySet()) {
      Bug bug = me.getValue();
      this.bugDied(bug);
    }

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
    this.player.bugCaught(bug);
  }

  void bugDied(Bug bug) {
    this.deadBugsCount ++;
    this.player.bugDied(bug);
    this.deadBugs.put(bug.bugID, bug);
  }
}