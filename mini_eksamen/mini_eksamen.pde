import controlP5.*;

MainLogic mainLogic;


void setup() {
  size(1920, 1080);
  frameRate(144);
  mainLogic = new MainLogic(this);
}

void draw() {
  background(200);
  mainLogic.Update();
}
