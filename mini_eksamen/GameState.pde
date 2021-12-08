public class GameState
{
  String[][][] set;

  public void Update() {
  }

  public void Reset() {
  }

  void ChangeScreen(String name)
  {
    mainLogic.gameStateManager.SkiftGameState(name);
  }

  void InjectSet(String[][][] a) {
    set = a;
  }
}
