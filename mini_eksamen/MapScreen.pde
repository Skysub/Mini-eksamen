class MapScreen extends GameState { //<>// //<>//

  Boolean greetingMessageSaid = false, Menu = false;
  int onceAsecond = 0;
  int saved = -1, savedTime = 0;

  ExitButton exitButton;
  ButtonSpm spm1;
  Button customMenuButton;
  ButtonPauseNy saveData;
  ExitButton closeMenuButton;

  CustomMenu customMenu;

  MapScreen(PApplet thePApplet, SQLite database) {
    super(thePApplet, database);
    ///posX, posY, width, heigh, text, color, clickColor, TextSize, textColor
    exitButton = new ExitButton(25, 20, 75, 75, "Back", color(180, 180, 180), color(255, 200, 200), 20, color(25, 25, 25), color(230, 150, 150));
    spm1 = new ButtonSpm((round(width*3/4)), 300, 200, 50, "Spørgsmål 1", color(200, 150, 150), color(100, 200, 100), 30, color(0));
    saveData = new ButtonPauseNy((round(width*2/4)), 500, 200, 50, "gem data", color(200, 150, 150), color(100, 200, 100), 30, color(0));
    customMenuButton = new Button((round(width/6)-100), round(height/2)+275, 200, 50, "Karakter", color(200, 150, 150), color(100, 200, 100), 30, color(0));
    customMenu = new CustomMenu();
    closeMenuButton = new ExitButton(round(width/2+customMenu.menuWidth/2-50), 110, 40, 40, "X", color(180, 180, 180), color(255, 200, 200), 30, color(25, 25, 25), color(230, 150, 150));
  }

  void Update() {
    Draw();
    if (onceAsecond < millis()-1000) {
      onceAsecond = millis();
      nextSet = GetNextSet();
    }


    if (greetingMessageSaid == false) {
      mainLogic.speakLine = true;
      greetingMessageSaid = true;
    }

    saveData.Run(saved != -1);
    if (saveData.isClicked() && saved == -1) {
      if (MakeCSV()) saved = 1;
      else saved = 0;
      savedTime = millis();
    }
    DrawCSVDone();

    exitButton.Run();
    if (exitButton.isClicked()) {
      ChangeScreen("loadFileScreen");
    }

    spm1.Run(nextSet, nextSet > map.length);
    if (spm1.isClicked()) {
      //println("ialt: "+map.length);
      //println("Next: "+nextSet);
      if (nextSet <= map.length) mainLogic.gameStateManager.SkiftGameStateQuestion("questionScreen", map[nextSet-1], nextSet);
    }


    customMenu.Draw(Menu);
    customMenu.Update(Menu);

    if (!Menu) {
      customMenuButton.Run();
      if (customMenuButton.isClicked()) {
        Menu = true;
      }
    }
    if (Menu) {
      closeMenuButton.Run();
      if (closeMenuButton.isClicked()) {
        Menu = false;
      }
    }
  }

  void Draw() {
    fill(0);
    textAlign(CORNER, TOP);
    textSize(30);
    text("Antal mønter:" + mainLogic.coins, 20, 120);
  }

  int GetNextSet() {
    try {
      db.query( "SELECT MAX(bane) FROM progress" );
      if (db.next()) {
        int t = db.getInt(1);
        //println(t);
        if (db.getInt(1) > -1) {
          return t+1;
        }
      }
    }
    catch(Exception e) {
      println(e);
    }
    return 1;
  }

  Boolean getMenu() {
    return Menu;
  }

  void DrawCSVDone() {
    if (savedTime+6000 > millis()) {
      fill(255, 50, 50);
      textAlign(CENTER, CENTER);
      textSize(30);
      if (saved == 1) {
        text("Data gemt i samme folder programmet ligger", width/2+200, 705);
      } else if (saved == 0) {
        text("Fejl. Data ikke gemt.", width/2+300, 705);
      }
    } else if (savedTime+6500 < millis()) {
      saved = -1;
    }
  }
  boolean MakeCSV() {
    return true;
  }
}
