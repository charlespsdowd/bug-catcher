// Making this work for GITHUB
BugsController gameController;
Player player;
BugFactory factory;
PImage backgroundImage;
float timer;

void setup() {
  size(1200, 700); 
  backgroundImage = loadImage("Monument_Valley_2.jpg");
  player = new Player();
  player.y = height-50;
  player.x = width/2;
  factory = new BugFactory();
  gameController = new BugsController(player, factory);
}

void draw() {
  background(157);
  image(backgroundImage, -100, -200);
  fill(255);
  gameController.draw();
}