class StartScreen extends GameState {

  Button laererKnap;
  Button elevKnap;
  ExitButton exitButton;

  StartScreen() {
    laererKnap = new Button(round(width*0.27), round(height*0.55), 300, 150, "Lærer", color(200, 150, 150), color(100, 200, 100), 30, color(0));
    elevKnap = new Button(round(width*0.57), round(height*0.55), 300, 150, "Elev", color(200, 150, 150), color(100, 200, 100), 30, color(0));
    exitButton = new ExitButton(25, 20, 75, 75, "Back", color(180, 180, 180), color(255, 200, 200), 20, color(25, 25, 25), color(230, 150, 150));
  }

  void Update() {
    
  DrawUI();

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
  
  void DrawUI() {
    textMode(CENTER);
    textSize(40);
    text("Velkommen til:",width/2,150);
    textSize(70);
    text("KOOL SKOOL RPG!", width/2,250);
    textSize(35);
    text("Er du lærer eller elev?", width/2,500);
  }
}
