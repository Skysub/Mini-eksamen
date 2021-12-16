class StartScreen extends GameState {

  Button laererKnap;
  Button elevKnap;
  ExitButton exitButton;

  StartScreen(PApplet thePApplet) {
        super(thePApplet);
    laererKnap = new Button((width/2)-(width/4), 200, 100, 50, "Lærer", color(200, 150, 150), color(100, 200, 100), 30, color(0));
    elevKnap = new Button((width/2)-(width/3), 600, 100, 50, "Elev", color(200, 150, 150), color(100, 200, 100), 30, color(0));
    exitButton = new ExitButton(25, 20, 75, 75, "Back", color(180, 180, 180), color(255, 200, 200), 20, color(25, 25, 25), color(230, 150, 150));
  }

  void Update() {

  UpdateButtons();
} 

  void UpdateButtons() {
        laererKnap.Run();
    if (laererKnap.isClicked()) {
      ChangeScreen("opretOpgave");
    }

    elevKnap.Run();
    if (elevKnap.isClicked()) {
      ChangeScreen("loadFileScreen");
    }
  }
}
