
class BugFactory {
  BugDelegate delegate;

  BugFactory() {
  }


  ArrayList<Bug> createBugs() {
    float randombug = random (1, 10);
    Bug newBug = new Bug(delegate);

    ArrayList<Bug> bugList = new ArrayList<Bug>();

    if (randombug >= 0 && randombug < 3.5) {
      newBug = new SamuriBug(delegate);
      bugList.add(newBug);
    } else if (randombug >= 3.5 && randombug < 4.5) {
      newBug = new BlueBug(delegate);
      bugList.add(newBug);
    } else if (randombug >= 4.5 && randombug < 5) {
      newBug = new HealthPack(delegate);
      bugList.add(newBug);
    } else if (randombug >= 5 && randombug < 6.5) {
      newBug = new SamuriBug(delegate);
      bugList.add(newBug);
      newBug = new SamuriBug(delegate);
      bugList.add(newBug);
      newBug = new SamuriBug(delegate);
      bugList.add(newBug);
      newBug = new SamuriBug(delegate);
      bugList.add(newBug);
    } else if (randombug >= 6.5 && randombug < 8) {
      newBug = new SamuriBug(delegate);
      bugList.add(newBug);
      newBug = new BlueBug(delegate);
      bugList.add(newBug);
      newBug = new SamuriBug(delegate);
      bugList.add(newBug);
    } else if (randombug >= 8 && randombug < 9) {
      newBug = new Bug(delegate);
      bugList.add(newBug);
    } else if (randombug >= 9 && randombug < 9.25) {
      for (int i = 0; i < 8; i ++) {
        newBug = new FireAnt(delegate);
        bugList.add(newBug);
      }
    } else if (randombug >= 9.25 && randombug < 10) {
      newBug = new BlueBug(delegate);
      bugList.add(newBug);
      newBug = new SamuriBug(delegate);
      bugList.add(newBug);
    }

    return bugList;
  }
}