import de.bezier.data.sql.*;
import de.bezier.data.sql.mapper.*;

MainLogic mainLogic;


void setup() {
  size(1920, 1080);
  frameRate(144);
  XMLHandler.SetUp();
  mainLogic = new MainLogic();
}

void draw() {
  background(200);
  mainLogic.Update();
}
