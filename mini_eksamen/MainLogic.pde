public class MainLogic { //<>//

  Character character;
  public Boolean speakLine = false; //denne int afgør, om karakteren taler eller ej. Sæt den true for at få karakteren til at tale, den revereter selv til false
  SQLite db;
  int coins;
  String coinsS;

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

  void UpdateCoins(int newCoins) {
    coins += newCoins;
  }

  int coinAmount() {
    return coins;
  }

  void saveCosmetics(boolean firstSave) {
    if (firstSave) {
      db.execute("INSERT INTO info VALUES(2,'currenthead','"+character.currentHead+"');");
      delay(10);
      db.execute("INSERT INTO info VALUES(3,'currentshoes','"+character.currentShoes+"');");
      delay(10);
      db.execute("INSERT INTO info VALUES(4,'currentshirt','"+character.currentShirt+"');");
      delay(10);
      db.execute("INSERT INTO info VALUES(5,'totalcoins','"+coins+"');");
      delay(10);
    } else {
      db.execute("UPDATE info SET information='"+character.currentHead+"' WHERE id = 2;");
      delay(10);
      db.execute("UPDATE info SET information='"+character.currentShoes+"' WHERE id = 3;");
      delay(10);
      db.execute("UPDATE info SET information='"+character.currentShirt+"' WHERE id = 4;");
      delay(10);
      db.execute("UPDATE info SET information="+coins+" WHERE id = 5;");
      delay(10);
    }
  }

  void HentCosmetics() {
    db.query("SELECT information FROM info WHERE id = 2");
    delay(10);
    if (db.next()) character.currentHead = db.getString(1);

    db.query("SELECT information FROM info WHERE id = 3");
    delay(10);
    if (db.next()) character.currentShoes = db.getString(1);

    db.query("SELECT information FROM info WHERE id = 4");
    delay(10);
    if (db.next()) character.currentShirt = db.getString(1);

    db.query("SELECT information FROM info WHERE id = 5");
    delay(10);
    if (db.next()) { 
      coinsS = db.getString(1);
      coins = int(coinsS);
    }
    
    print("cosmetics er hentet!");
  }
}
