Character character;
Boolean speakLine = false; //denne int afgør, om karakteren taler eller ej. Sæt den true for at få karakteren til at tale, den revereter selv til false

public GameStateManager gameStateManager;

public class MainLogic {

  MainLogic(PApplet thePApplet) {
    gameStateManager = new GameStateManager();
    character = new Character();
  }

  void Update() {
    gameStateManager.Update();
    
    character.Update(gameStateManager.GetGameState());

  }

  void draw(PApplet thePApplet) {
    character.drawCharacter(speakLine);
    speakLine = character.speakCheck();
    InitializeScreens(thePApplet);
  }


  void InitializeScreens(PApplet thePApplet) {
    gameStateManager.AddGameState("start", new StartScreen());
    gameStateManager.AddGameState("opretOpgave", new OpgaveScreen(thePApplet));
    gameStateManager.SkiftGameState("start");
  }
}
