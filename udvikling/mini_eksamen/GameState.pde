public class GameState
{
  String[][] set;
  public String path = null;
  public boolean fresh = true, done = true, going = false;
  public String[][][] map = null;
  public int nextSet = 1;
  SQLite db;

  GameState(PApplet thePApplet, SQLite database) {
    db = database;
  }

  public void Update() {
  }

  public void Reset() {
  }

  void ChangeScreen(String name)
  {
    mainLogic.gameStateManager.SkiftGameState(name);
  }

  void InjectSet(String[][] a, int b) {
    set = a;
    nextSet = b;
  }
}
