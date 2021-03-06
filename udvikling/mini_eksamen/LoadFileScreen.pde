class LoadFileScreen extends GameState { //<>// //<>// //<>//

  Boolean greetingMessageSaid = false, speakLine, noSave = false;

  ExitButton exitButton, name;
  Button load, fort;
  boolean goingBefore = false;
  ;


  LoadFileScreen(PApplet thePApplet, SQLite database) {
    super(thePApplet, database);
    ///posX, posY, width, heigh, text, color, clickColor, TextSize, textColor
    exitButton = new ExitButton(25, 20, 75, 75, "Back", color(180, 180, 180), color(255, 200, 200), 20, color(25, 25, 25), color(230, 150, 150));
    name = new ExitButton(width/2-150, 280, 300, 60, "Angiv dit navn", color(200, 150, 150), color(255, 200, 200), 30, color(25, 25, 25), color(230, 150, 150));
    load = new Button(width/2-280, 330, 560, 60, "Load opgave fil og slet gammelt save", color(200, 150, 150), color(100, 200, 100), 30, color(0));
    fort  = new Button(width/2-180, 530, 300, 60, "Fortsæt", color(200, 150, 150), color(100, 200, 100), 30, color(0));
  }

  void Update() {
    Draw();
    if (greetingMessageSaid == false) {
      speakLine = true;
      greetingMessageSaid = true;
    }
    DrawText();

    load.Run();
    if (load.isClicked()) {
      if (knapLoad())  NewSave();
    }

    fort.Run();
    if (fort.isClicked()) {
      if (DoesSaveExist()) {
        db.query( "SELECT information FROM info WHERE id=1;" );
        delay(10);
        path = db.getString(1);
        println(path);
        mainLogic.gameStateManager.GetGameState("map").map = xmlHandler.ReadFromXML(path);
        mainLogic.gameStateManager.SkiftGameState("map");
      } else {
        //kode hvor der står at der ikke er et save på skærmen
        noSave = true;
      }
    }

    exitButton.Run();
    if (exitButton.isClicked()) {
      fresh = true;
      ChangeScreen("start");
    }

    //name.Run();
    if (name.isClicked()) {
      ChangeScreen("name");
    }
  }

  void DrawText() {
    fill(0);
    textAlign(CENTER, TOP);
    textSize(50);
    text("Før du kan komme igang skal du:", width/2, 100);

    textAlign(CORNER, TOP);
    textSize(30);
    text("Loade filen din lærer har givet dig, hvis det er første gang", width/2-410, 200);
    text("du spiller på den. Hvis du loader en fil og det ikke er første", width/2-410, 233);
    text("gang, så overskrives dit gamle save:", width/2-410, 266);

    text("Fortsætte, hvis du allerede har loadet en fil, og gerne vil ", width/2-410, 433);
    text("spille videre på dit save:", width/2-410, 466);
  }

  void NewSave() {
    //Sletter og genopretter tabellerne, samt fjerner coins og cosmetics i selve porgrammet 
    mainLogic.coins = 0;
    mainLogic.character.currentHead = "none";
    mainLogic.character.currentShoes = "none";
    mainLogic.character.currentShirt = "none";

    db.execute("DROP TABLE progress;");
    delay(10);
    db.execute("DROP TABLE info");
    delay(10);
    db.execute("CREATE TABLE [info] (id integer NOT NULL PRIMARY KEY UNIQUE,info type text NOT NULL,information text)");
    delay(10);
    db.execute("CREATE TABLE [progress] (bane id integer NOT NULL PRIMARY KEY UNIQUE,spm ialt integer NOT NULL,rigtige integer NOT NULL,point fået integer NOT NULL,tid brugt integer NOT NULL)");
    delay(10);

    db.execute("INSERT INTO info VALUES(1,'path','"+FileHandler.GetFolder()+"\\opgaveMap.xml');");
    delay(10);
  }

  void GemOpgaveMap() {
    try {
      Files.copy(Paths.get(path), Paths.get(FileHandler.GetFolder()+"\\opgaveMap.xml"));
    }
    catch(IOException e) {
      println(e);
    }
  }

  void SletOpgaveMap() {
    try {
      Files.delete(Paths.get(FileHandler.GetFolder()+"\\opgaveMap.xml"));
    }
    catch(IOException e) {
      println(e);
    }
  }

  boolean DoesSaveExist() {
    if (Files.exists(Paths.get(FileHandler.GetFolder()+"\\opgaveMap.xml"))) {
      return true;
    }
    return false;
  }

  //Spaghettikode, sorry
  boolean knapLoad() {
    if (fresh) {
      if (!going && !goingBefore) {
        done = false;
        selectInput("Vælg XML opgavesæt fil:", "fileSelected");
        going = true;
      }
      if (done) {
        //println(fresh +"  "+ path);
        if (path != null) {
          //println("inside____"+millis());
          fresh = true;
          mainLogic.gameStateManager.GetGameState("map").map = xmlHandler.ReadFromXML(path);
          ChangeScreen("name"); //ændr det her når name screen er færdiggjort
          SletOpgaveMap();
          GemOpgaveMap();
          noSave = false;
          done = false;
          going = false;
          return true;
        }
      }
    }
    goingBefore = going;
    return false;
  }

  void Draw() {
    if (noSave) {
      fill(255, 50, 50);
      textAlign(CENTER, CENTER);
      textSize(50);
      text("Intet save existerer", width/2, 705);
    }
  }
}
