public static GameStateManager gameStateManager;
Character character;
PVector test = new PVector(500, 640);
float characterSize = 1.5;
Boolean speakLine = true;

//this int is only for testing, as the gamestate manager isnt in my build
int characterState = 0;

public class MainLogic {

  MainLogic() {
    gameStateManager = new GameStateManager();
    character = new Character();
  }

  void Update() {
    character.Update(characterState);
    character.drawCharacter(test, characterSize, speakLine);
  }


  void InitializeScreens() {
  }
}
