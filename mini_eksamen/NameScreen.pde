class NameScreen extends GameState {

  SQLite db;
  ExitButton exitButton;
  TextField nameTF;
  String name;

  NameScreen(PApplet thePApplet) {
    ///posX, posY, width, heigh, text, color, clickColor, TextSize, textColor
    exitButton = new ExitButton(25, 20, 75, 75, "Back", color(180, 180, 180), color(255, 200, 200), 20, color(25, 25, 25), color(230, 150, 150));
    db = new SQLite( thePApplet, FileHandler.GetFolder()+"\\data.sqlite" );
    db.connect();
    nameTF = new TextField(thePApplet, "", new PVector(520, 180), 550, false);
  }

  void Update() {

    nameTF.Update(false, 0, 0, false);
    name = nameTF.Input(false, 0, 0);

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
