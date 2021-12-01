class MapScreen extends GameState {

  Boolean greetingMessageSaid = false, speakLine;
  
  ExitButton exitButton;
  Button spm1;

  MapScreen() {
    ///posX, posY, width, heigh, text, color, clickColor, TextSize, textColor
    exitButton = new ExitButton(25, 20, 75, 75, "Back", color(180, 180, 180), color(255, 200, 200), 20, color(25, 25, 25), color(230, 150, 150));
    spm1 = new Button((width/2)-(width/4), 300, 200, 50, "Spørgsmål 1", color(200, 150, 150), color(100, 200, 100), 30, color(0));
  }

  void Update() {
    println("Oy!");
    if (greetingMessageSaid == false){
      speakLine = true; //<>//
      greetingMessageSaid = true;
    }
    
    exitButton.Run();
    if (exitButton.isClicked()) {
      ChangeScreen("start");
    }

    spm1.Run();
    if (spm1.isClicked()) {
      mainLogic.gameStateManager.SkiftGameStateQuestion("questionScreen", null);
    }
  }
}
