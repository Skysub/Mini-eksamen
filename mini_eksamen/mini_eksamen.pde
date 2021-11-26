import controlP5.*;
import de.bezier.data.sql.*;
import de.bezier.data.sql.mapper.*;

MainLogic mainLogic;
XMLHandler xmlHandler;
//stuff

void setup() {
  size(1920, 1080);
  frameRate(144);
  FileHandler.SetUp();
  xmlHandler = new XMLHandler();
  mainLogic = new MainLogic(this);
}

void draw() {
  background(220);
  mainLogic.Update();
  mainLogic.draw();
}
