class NameScreen extends GameState {

  SQLite db;
  ExitButton exitButton;

  NameScreen(PApplet thePApplet) {
    ///posX, posY, width, heigh, text, color, clickColor, TextSize, textColor
    exitButton = new ExitButton(25, 20, 75, 75, "Back", color(180, 180, 180), color(255, 200, 200), 20, color(25, 25, 25), color(230, 150, 150));
    db = new SQLite( thePApplet, FileHandler.GetFolder()+"\\data.sqlite" );
    db.connect();
  }

  void Update() {
    exitButton.Run();
    if (exitButton.isClicked()) {
      fresh = true;
      ChangeScreen("start");
    }
  }

  void SetName(String name) {
    db.execute("INSERT INTO info VALUES(0,'name','"+name+"');");
  }
}
