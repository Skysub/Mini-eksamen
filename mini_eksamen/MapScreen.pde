class MapScreen extends GameState {

  Boolean greetingMessageSaid = false, Menu = false;
  int nextSet = -1;
  int onceAsecond = 0;

  ExitButton exitButton;
  Button spm1;
  Button customMenuButton;
  ExitButton closeMenuButton;

  CustomMenu customMenu;

  MapScreen(PApplet thePApplet) {
        super(thePApplet);
    ///posX, posY, width, heigh, text, color, clickColor, TextSize, textColor
    exitButton = new ExitButton(25, 20, 75, 75, "Back", color(180, 180, 180), color(255, 200, 200), 20, color(25, 25, 25), color(230, 150, 150));
    spm1 = new Button((round(width*3/4)), 300, 200, 50, "Spørgsmål 1", color(200, 150, 150), color(100, 200, 100), 30, color(0));
    customMenuButton = new Button((round(width/6)-100), round(height/2)+275, 200, 50, "Karakter", color(200, 150, 150), color(100, 200, 100), 30, color(0));
    customMenu = new CustomMenu();
    closeMenuButton = new ExitButton(round(width/2+customMenu.menuWidth/2-50), 110, 40, 40, "X", color(180, 180, 180), color(255, 200, 200), 30, color(25, 25, 25), color(230, 150, 150));
  }

  void Update() {
    if (onceAsecond < millis()-1000) {
      onceAsecond = millis();
      nextSet = GetNextSet();
    }


    if (greetingMessageSaid == false) {
      mainLogic.speakLine = true;
      greetingMessageSaid = true;
    }

    exitButton.Run();
    if (exitButton.isClicked()) {
      ChangeScreen("start");
    }

    spm1.Run();
    if (spm1.isClicked()) {
      mainLogic.gameStateManager.SkiftGameStateQuestion("questionScreen", map[0]);
    }


    customMenu.Draw(Menu);
    customMenu.Update(Menu);

    if (!Menu) {
      customMenuButton.Run();
      if (customMenuButton.isClicked()) {
        Menu = true;
      }
    }
    if (Menu) {
      closeMenuButton.Run();
      if (closeMenuButton.isClicked()) {
        Menu = false;
      }
    }
  }

  int GetNextSet() {
    try {
      //db.query( "SELECT username FROM PW WHERE username='"+a[1]+"';" );
    }
    catch(Exception e) {
      println(e);
    }

    return -1;
  }

  Boolean getMenu() {
    return Menu;
  }
}
