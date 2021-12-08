public class GameState
{
  String[][] set;
  public String path = null;
  public boolean fresh = true;
  public String[][][] map = null;

  public void Update() {
  }

  public void Reset() {
  }

  void ChangeScreen(String name)
  {
    mainLogic.gameStateManager.SkiftGameState(name);
  }

  void InjectSet(String[][] a) {
    set = a;
  }
}
