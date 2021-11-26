public class GameState
{
  public void Update() {
  }

  public void Reset() {
  }

  void ChangeScreen(String name)
  {
    gameStateManager.SkiftGameState(name);
  }
}
