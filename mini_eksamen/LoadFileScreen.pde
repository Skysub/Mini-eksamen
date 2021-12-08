class LoadFileScreen extends GameState {

  Boolean greetingMessageSaid = false, speakLine, fresh = true;
  String path = null;

  ExitButton exitButton;
  Button load;

  LoadFileScreen() {
    ///posX, posY, width, heigh, text, color, clickColor, TextSize, textColor
    exitButton = new ExitButton(25, 20, 75, 75, "Back", color(180, 180, 180), color(255, 200, 200), 20, color(25, 25, 25), color(230, 150, 150));
    load = new Button((width/2)-(width/4)+300, 300, 250, 50, "Load opgave fil", color(200, 150, 150), color(100, 200, 100), 30, color(0));
  }

  void Update() {
    if (greetingMessageSaid == false) {
      speakLine = true;
      greetingMessageSaid = true;
    }
    DrawText();



    load.Run();
    if (load.isClicked()) {
      if (fresh) {
        fresh = false;
        selectInput("Vælg XML opgavesæt fil:", "fileSelected");
        if (path != null) {
          fresh = true;
          mainLogic.gameStateManager.SkiftGameState("map");
        }
      }
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
    text("Du har ikke en save file, load en opgave fil", 150, 20);
  }

  void fileSelected(File selection) {
    if (selection == null) {
      println("Window was closed or the user hit cancel.");
      fresh = true;
    } else {
      println("User selected " + selection.getAbsolutePath());
      path = selection.getAbsolutePath();
    }
  }
}
