public GameStateManager gameStateManager;

public class MainLogic {

  MainLogic() {
    gameStateManager = new GameStateManager();
    InitializeScreens();
  }

  void Update() {
    gameStateManager.Update();
  }


  void InitializeScreens() {
    gameStateManager.AddGameState("start", new StartScreen());
    gameStateManager.AddGameState("opretOpgave", new OpgaveScreen());
    
    
    gameStateManager.SkiftGameState("start");
  }
}
