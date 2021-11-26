Character character;
public Boolean speakLine = false; //denne int afgør, om karakteren taler eller ej. Sæt den true for at få karakteren til at tale, den revereter selv til false

public GameStateManager gameStateManager;

public class MainLogic {

  MainLogic(PApplet thePApplet) {
    gameStateManager = new GameStateManager();
    character = new Character();
    InitializeScreens(thePApplet);
  }

  void Update() {
    gameStateManager.Update();
    
    //needs to be given an int that represents the gameState. See the switch under the Character class
    character.Update(gameStateManager.GetCurrentGameStateName());

  }
  void draw(PApplet thePApplet) {
    character.drawCharacter(speakLine);
    speakLine = character.speakCheck();
    InitializeScreens(thePApplet);
  }


  void InitializeScreens(PApplet thePApplet) {
    gameStateManager.AddGameState("start", new StartScreen());

    gameStateManager.AddGameState("opretOpgave", new OpgaveScreen(thePApplet));   
    gameStateManager.AddGameState("map", new MapScreen());
    gameStateManager.AddGameState("questionScreen", new QuestionScreen());

    gameStateManager.SkiftGameState("start");
  }
}
