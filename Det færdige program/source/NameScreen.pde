class NameScreen extends GameState {


  ExitButton exitButton;
  Button gemNavn;
  TextField nameTF;
  String name;

  NameScreen(PApplet thePApplet, SQLite database) {
    super(thePApplet, database);
    ///posX, posY, width, heigh, text, color, clickColor, TextSize, textColor
    exitButton = new ExitButton(width/2-200, 400, 75, 75, "Back", color(180, 180, 180), color(255, 200, 200), 20, color(25, 25, 25), color(230, 150, 150));
    gemNavn = new Button(width/2-90, 400, 150, 75, "Gem navn", color(180, 180, 180), color(255, 200, 200), 20, color(0));
    nameTF = new TextField(thePApplet, "", new PVector(width/2-250, 280), 500, false);
  }

  void Update() {
    Draw();

    nameTF.Update(true, 1, 999, false);
    name = nameTF.Input(true, 1, 999);

    gemNavn.Run();
    if (gemNavn.isClicked()) {
      if (nameTF.tooShort) {
        textAlign(CENTER, TOP);
        fill(200, 50, 50);
        textSize(30);
        text("Du skal angive et navn", width/2, 350);
      } else SetName(name);
    }

    //exitButton.Run();
    if (exitButton.isClicked()) {
      fresh = true;
      ChangeScreen("loadFileScreen");
    }
  }

  void Draw() {
    fill(0);
    textAlign(CENTER, CENTER);
    textSize(50);
    text("Indtast dit navn", width/2, 200);
  }

  void SetName(String name) {
    db.execute("INSERT INTO info VALUES(0,'name','"+name+"');");
    delay(10);
    ChangeScreen("map");
  }
}
