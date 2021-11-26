class QuestionScreen extends GameState {

  ExitButton exitButton;


  QuestionScreen() {
    ///posX, posY, width, heigh, text, color, clickColor, TextSize, textColor
    exitButton = new ExitButton(25, 20, 75, 75, "Back", color(180, 180, 180), color(255, 200, 200), 20, color(25, 25, 25), color(230, 150, 150));
  }

  void Update() {
    exitButton.Run();
    if (exitButton.isClicked()) {
      gameStateManager.SkiftGameState("start");
    }
  }


}
