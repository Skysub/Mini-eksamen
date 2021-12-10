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
}

void fileSelected(File selection) {

  if (selection == null) {
    mainLogic.gameStateManager.GetGameState("loadFileScreen").fresh = true;
    println("Window was closed or the user hit cancel.");
  } else {
    println("User selected " + selection.getAbsolutePath());
    mainLogic.gameStateManager.GetGameState("loadFileScreen").path = selection.getAbsolutePath();
  }
  mainLogic.gameStateManager.GetGameState("loadFileScreen").done = true;
}
