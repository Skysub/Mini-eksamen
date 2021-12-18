import controlP5.*;
import de.bezier.data.sql.*;
import de.bezier.data.sql.mapper.*;
import java.nio.file.*;
import java.io.FileWriter;
import java.io.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

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
    mainLogic.gameStateManager.GetGameState("loadFileScreen").going = false;
  } else {
    println("User selected " + selection.getAbsolutePath());

    try {
      mainLogic.gameStateManager.GetGameState("loadFileScreen").path = selection.getAbsolutePath();
    }
    catch(Exception e) {
      println(e);
    }
  }
  mainLogic.gameStateManager.GetGameState("loadFileScreen").done = true;
}
