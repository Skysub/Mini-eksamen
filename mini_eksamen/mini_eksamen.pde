MainLogic mainLogic;

void setup() {
  size(1920, 1080);
  background(220);
  frameRate(60);
  mainLogic = new MainLogic();
}

void draw() {
  mainLogic.Update();
}
