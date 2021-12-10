public class MainLogic {

  Character character;
  public Boolean speakLine = false; //denne int afgør, om karakteren taler eller ej. Sæt den true for at få karakteren til at tale, den revereter selv til false
  
  int coins;

  public GameStateManager gameStateManager;

  MainLogic(PApplet thePApplet) {
    gameStateManager = new GameStateManager();
    character = new Character();
    InitializeScreens(thePApplet);
  }

  void Update() {
    gameStateManager.Update();

    character.Update(gameStateManager.GetCurrentGameStateName());
    character.drawCharacter(speakLine);
    speakLine = character.speakCheck();
  }

  void InitializeScreens(PApplet thePApplet) {
    gameStateManager.AddGameState("start", new StartScreen());

    gameStateManager.AddGameState("opretOpgave", new OpgaveScreen(thePApplet));   
    gameStateManager.AddGameState("map", new MapScreen());
    gameStateManager.AddGameState("questionScreen", new QuestionScreen());
    gameStateManager.AddGameState("LoadFileScreen", new LoadFileScreen());

    gameStateManager.SkiftGameState("start");
  }
  
  void addCoins(int change) {
    coins = coins + change;
  }
  
  int coinAmount(){
    return coins;
  }
}
