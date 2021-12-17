public class MainLogic {

  Character character;
  public Boolean speakLine = false; //denne int afgør, om karakteren taler eller ej. Sæt den true for at få karakteren til at tale, den revereter selv til false
  SQLite db;
  int coins;

  public GameStateManager gameStateManager;

  MainLogic(PApplet thePApplet) {
    db = new SQLite( thePApplet, FileHandler.GetFolder()+"\\data.sqlite" );
    db.connect();
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
    gameStateManager.AddGameState("start", new StartScreen(thePApplet, db));

    gameStateManager.AddGameState("opretOpgave", new OpgaveScreen(thePApplet, db));   
    gameStateManager.AddGameState("map", new MapScreen(thePApplet, db));
    gameStateManager.AddGameState("questionScreen", new QuestionScreen(thePApplet, db));
    gameStateManager.AddGameState("loadFileScreen", new LoadFileScreen(thePApplet, db));
    gameStateManager.AddGameState("name", new NameScreen(thePApplet, db));

    gameStateManager.SkiftGameState("start");
  }

  void addCoins(int change) {
    coins = coins + change;
  }
  
  void UpdateCoins(int newCoins){
    coins += newCoins;
  }

  int coinAmount() {
    return coins;
  }
}
