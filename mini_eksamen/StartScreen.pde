class StartScreen extends GameState {

  Button laererKnap;
  Button elevKnap;
  ExitButton exitButton;
  int r = 100, g = 203, b = 151;
  boolean rR = false, gR = false, bR = true;

  StartScreen(PApplet thePApplet) {
    super(thePApplet);
    laererKnap = new Button((width/2)-450, 550, 300, 150, "Lærer", color(200, 150, 150), color(100, 200, 100), 50, color(0));
    elevKnap = new Button((width/2)+150, 550, 300, 150, "Elev", color(200, 150, 150), color(100, 200, 100), 50, color(0));
    exitButton = new ExitButton(25, 20, 75, 75, "Back", color(180, 180, 180), color(255, 200, 200), 20, color(25, 25, 25), color(230, 150, 150));
  }

  void Update() { 
    UpdateButtons();
    DrawUI();
  } 


  void Draw() {
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

  void DrawUI() {
    textMode(CENTER);
    textSize(40);
    text("Velkommen til:", width/2, 150);
    textSize(70);
    text("KOOL SKOOL RPG!", width/2, 250);
    textSize(35);
    text("Er du lærer eller elev?", width/2, 500);
  }
}
