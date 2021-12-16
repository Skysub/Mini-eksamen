class LoadFileScreen extends GameState { //<>// //<>// //<>// //<>// //<>//

  Boolean greetingMessageSaid = false, speakLine, going = false, noSave = false;

  ExitButton exitButton, name;
  Button load, fort;


  LoadFileScreen(PApplet thePApplet) {
    super(thePApplet);
    ///posX, posY, width, heigh, text, color, clickColor, TextSize, textColor
    exitButton = new ExitButton(25, 20, 75, 75, "Back", color(180, 180, 180), color(255, 200, 200), 20, color(25, 25, 25), color(230, 150, 150));
    name = new ExitButton(1000, 200, 75, 75, "name test", color(180, 180, 180), color(255, 200, 200), 20, color(25, 25, 25), color(230, 150, 150));
    load = new Button((width/2)-(width/4)+100, 300, 560, 65, "Load opgave fil og slet gammelt save", color(200, 150, 150), color(100, 200, 100), 30, color(0));
    fort  = new Button((width/2)-(width/4)+100, 500, 300, 60, "Fortsæt", color(200, 150, 150), color(100, 200, 100), 30, color(0));
    

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
      knapLoad();

      NewSave();
    }

    fort.Run();
    if (fort.isClicked()) {
      if (DoesSaveExist()) {
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

    name.Run();
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
    text("Angive dit navn, hvis det er første gang du spiller på den", width/2-410, 200);
    text("fil, din lærer har givet til dig:", width/2-410, 233);
    
    text("Loade filen din lærer har givet dig, hvis det er første gang", width/2-410, 430);
    text("du spiller på den. Hvis du loader en fil og det ikke er første", width/2-410, 463);
    text("gang, så overskrives dit gamle save:", width/2-410, 496);
  }

  void NewSave() {
    //Sletter og genopretter tabellerne
    db.execute("DROP TABLE progress;");
    db.execute("DROP TABLE info");
    db.execute("CREATE TABLE [info] (id integer NOT NULL PRIMARY KEY UNIQUE,info type text NOT NULL,information text)");
    db.execute("CREATE TABLE [progress] (bane id integer NOT NULL PRIMARY KEY UNIQUE,spm ialt integer NOT NULL,rigtige integer NOT NULL,point fået integer NOT NULL,tid brugt integer NOT NULL)");

    db.execute("INSERT INTO info VALUES(1,'path','"+FileHandler.GetFolder()+"\\opgaveMap.xml');");
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
  void knapLoad() {
    if (fresh) {
      if (!going) {
        //fresh = false;
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
          ChangeScreen("map"); //ændr det her når name screen er færdiggjort
          SletOpgaveMap();
          GemOpgaveMap();
          noSave = false;
        }
      }
    }
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
