MainLogic mainLogic;

void setup() {
  size(1920, 1080);
  frameRate(60);
  mainLogic = new MainLogic();
}

void draw() {
  background(220);
  mainLogic.Update();
  mainLogic.draw();
}
