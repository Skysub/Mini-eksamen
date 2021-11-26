public class GameState
{
  String[][] set;

  public void Update() {
  }

  public void Reset() {
  }

  void ChangeScreen(String name)
  {
    gameStateManager.SkiftGameState(name);
  }

  void InjectSet(String[][] a) {
    set = a;
  }
}
