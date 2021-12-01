class MapScreen extends GameState {

  Boolean greetingMessageSaid = false, Menu = false;
  
  ExitButton exitButton;
  Button spm1;
  Button customMenuButton;
  
  CustomMenu customMenu;

  MapScreen() {
    ///posX, posY, width, heigh, text, color, clickColor, TextSize, textColor
    exitButton = new ExitButton(25, 20, 75, 75, "Back", color(180, 180, 180), color(255, 200, 200), 20, color(25, 25, 25), color(230, 150, 150));
    spm1 = new Button((round(width*3/4)), 300, 200, 50, "Spørgsmål 1", color(200, 150, 150), color(100, 200, 100), 30, color(0));
    customMenuButton = new Button((round(width/6)-100),round(height/2)+250,200,50,"Karakter",color(200,150,150), color(100,200,100),30,color(0));
    customMenu = new CustomMenu();
  }

  void Update() {
    if (greetingMessageSaid == false){
      mainLogic.speakLine = true;
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
    
    customMenuButton.Run();
    if (customMenuButton.isClicked()) {
      Menu = !Menu;
    }
    
    customMenu.Draw(Menu);
  }
}
