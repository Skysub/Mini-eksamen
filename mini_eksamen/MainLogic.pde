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
    
    
    
    
    gameStateManager.SkiftGameState("start");
  }
}
