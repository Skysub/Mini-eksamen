public static GameStateManager gameStateManager;
Character character;
PVector test = new PVector(500, 640);

public class MainLogic {

  MainLogic() {
    gameStateManager = new GameStateManager();
    character = new Character();
  }

  void Update() {
    character.drawCharacter(test);
    character.drawBubble(test);
  }


  void InitializeScreens() {
  }
}
