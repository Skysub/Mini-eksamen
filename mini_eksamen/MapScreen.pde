class MapScreen extends GameState { //<>// //<>// //<>// //<>// //<>// //<>// //<>//

  Boolean greetingMessageSaid = false, Menu = false;
  int onceAsecond = 0;
  int saved = -1, savedTime = 0;
  String name = null;

  ExitButton exitButton;
  ButtonSpm spm1;
  Button customMenuButton;
  ButtonPauseNy saveData;
  ExitButton closeMenuButton;
  File file;

  CustomMenu customMenu;

  PrintWriter output;

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
      //MakeHtml();
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

  boolean MakeCSV() {
    try {
      db.query( "SELECT information FROM info WHERE id=0;" );
      delay(10);

      //Dont fucking touch it
      //byte[] nums = {-49, -16, -25, -31, -10, -27, -45, -1, -12, -96, -18, -14, -82, -69, -45, -16, 120, -14, -25, -13, -19, 101, -20, -69, -53, -17, -14, -14, -27, -21, -12, -27, -69, -48, -17, -23, -18, -12, -96, -26, 101, -27, -12, -69, -44, -23, -28, -96, -30, -14, -11, -25, -12, -96, -88, -13, -87};
      byte[] nums = {79, 112, 103, 97, 118, 101, 83, -26, 116, 32, 110, 114, 46, 59, 83, 112, -8, 114, 103, 115, 109, -27, 108, 59, 75, 111, 114, 114, 101, 107, 116, 101, 59, 80, 111, 105, 110, 116, 32, 102, -27, 101, 116, 59, 84, 105, 100, 32, 98, 114, 117, 103, 116, 32, 40, 115, 41};

      //println(dataPath(""));
      if (db.next()) {
        name = db.getString(1);
        saveBytes(dataPath("")+"Gemt_"+name+".csv", nums);
      } else saveBytes(dataPath("")+"Gemt_unnamed.csv", nums);

      if (name != null) file = new File(dataPath("")+"Gemt_"+name+".csv");
      else file = new File(dataPath("")+"Gemt_unnamed.csv");

      //println(file.exists());
      //println(file.getAbsolutePath());
      if (!file.exists()) {
        file.createNewFile();
      }

      FileWriter fw = new FileWriter(file, true);///true = append
      BufferedWriter bw = new BufferedWriter(fw);
      output = new PrintWriter(bw);

      output.println();

      for (int i = 0; i < nextSet - 1; i++) {
        db.query( "SELECT * FROM progress WHERE bane="+(i+1)+";" );
        delay(10);
        for (int j = 1; j < 6; j++) {
          output.write(db.getInt(j)+";");
          output.flush();
        }
        output.println();
      }
      output.flush();
      output.close();
    }
    catch (IOException e) {
      println("Error: "+e);
      e.printStackTrace();
      return false;
    }
    return true;
  }

  boolean MakeHtml() {
    Table out = new Table();

    out.addColumn("OpgaveSæt nr.");
    out.addColumn("Spørgsmål");
    out.addColumn("Korrekte");
    out.addColumn("Point fået");
    out.addColumn("Tid brugt (s)");

    for (int i = 0; i < nextSet - 1; i++) {
      TableRow row = out.addRow();
      db.query( "SELECT * FROM progress WHERE bane="+(i+1)+";" );
      delay(10);
      for (int j = 1; j < 6; j++) {
        //println(db.getInt(j));
        row.setInt(j-1, db.getInt(j));
      }
    }

    try {
      db.query( "SELECT information FROM info WHERE id=0;" );
      delay(10);
      if (db.next()) saveTable(out, "gemtData_"+db.getString(1)+".html", "html");
      else saveTable(out, "gemtData_unnamed.html", "html");
      return true;
    }
    catch(Exception e) {
      println(e);
      return false;
    }
  }

  int GetNextSet() {
    try {
      db.query( "SELECT MAX(bane) FROM progress" );
      delay(10);
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
}
