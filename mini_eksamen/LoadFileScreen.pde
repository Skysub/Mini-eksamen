class LoadFileScreen extends GameState {

  Boolean greetingMessageSaid = false, speakLine, going = false;

  ExitButton exitButton;
  Button load, fort;

  LoadFileScreen() {
    ///posX, posY, width, heigh, text, color, clickColor, TextSize, textColor
    exitButton = new ExitButton(25, 20, 75, 75, "Back", color(180, 180, 180), color(255, 200, 200), 20, color(25, 25, 25), color(230, 150, 150));
    load = new Button((width/2)-(width/4)+100, 300, 560, 65, "Load opgave fil og slet gammelt save", color(200, 150, 150), color(100, 200, 100), 30, color(0));
    fort  = new Button((width/2)-(width/4)+100, 500, 300, 60, "Fortsæt", color(200, 150, 150), color(100, 200, 100), 30, color(0));
  }

  void Update() {
    if (greetingMessageSaid == false) {
      speakLine = true;
      greetingMessageSaid = true;
    }
    DrawText();

    load.Run();
    if (load.isClicked()) {
      knapLoad();
    }

    fort.Run();
    if (fort.isClicked()) {
      mainLogic.gameStateManager.SkiftGameState("map");
    }

    exitButton.Run();
    if (exitButton.isClicked()) {
      fresh = true;
      ChangeScreen("start");
    }
  }

  void DrawText() {
    fill(0);
    textAlign(CORNER, TOP);
    textSize(50);
    //text("Du har ikke en save file, load en opgave fil", 150, 20);
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
          println("inside____"+millis());
          fresh = true;
          mainLogic.gameStateManager.GetGameState("map").map = xmlHandler.ReadFromXML(path);
          ChangeScreen("map");
        }
      }
    }
  }
}
