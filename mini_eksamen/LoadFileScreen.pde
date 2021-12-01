class LoadFileScreen extends GameState {

  Boolean greetingMessageSaid = false, speakLine;

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

      DrawText();
    }

    exitButton.Run();
    if (exitButton.isClicked()) {
      ChangeScreen("start");
    }

    load.Run();
    if (load.isClicked()) {
      mainLogic.gameStateManager.SkiftGameState("map");
    }
  }

  void DrawText() {
    
  }
}
