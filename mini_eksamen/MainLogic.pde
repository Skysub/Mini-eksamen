public static GameStateManager gameStateManager;
Character character;
PVector test = new PVector(500, 640);
Boolean speakLine = false; //denne int afgør, om karakteren taler eller ej. Sæt den true for at få karakteren til at tale, den revereter selv til false

int characterState = 0; //denne int eksisterer kun som en midlertidig erstatning af Gamestate. 

//this int is only for testing, as the gamestate manager isnt in my build
//int characterState = 0;

public class MainLogic {

  MainLogic() {
    gameStateManager = new GameStateManager();
    character = new Character();
  }

  void Update() {
    //needs to be given an int that represents the gameState. See the switch under the Character class
    character.Update(characterState);

  }

  void draw() {
    character.drawCharacter(speakLine);
    speakLine = character.speakCheck();
  }


  void InitializeScreens() {
  }
}
