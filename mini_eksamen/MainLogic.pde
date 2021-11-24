public GameStateManager gameStateManager;

public class MainLogic {

  MainLogic(PApplet thePApplet) {
    gameStateManager = new GameStateManager();
    InitializeScreens(thePApplet);
  }

  void Update() {
    gameStateManager.Update();
  }


  void InitializeScreens(PApplet thePApplet) {
    gameStateManager.AddGameState("start", new StartScreen());
    gameStateManager.AddGameState("opretOpgave", new OpgaveScreen(thePApplet));
    
    
    gameStateManager.SkiftGameState("start");
  }
}
