class MapScreen extends GameState {

  ExitButton exitButton;
  Button spm1;

  MapScreen() {
    ///posX, posY, width, heigh, text, color, clickColor, TextSize, textColor
    exitButton = new ExitButton(25, 20, 75, 75, "Back", color(180, 180, 180), color(255, 200, 200), 20, color(25, 25, 25), color(230, 150, 150));
    spm1 = new Button((width/2)-(width/4), 300, 200, 50, "Spørgsmål 1", color(200, 150, 150), color(100, 200, 100), 30, color(0));
  }

  void Update() {
    exitButton.Run();
    if (exitButton.isClicked()) {
      gameStateManager.SkiftGameState("start");
    }

    spm1.Run();
    if (spm1.isClicked()) {
      gameStateManager.SkiftGameStateQuestion("questionScreen", null);
    }
  }
}
