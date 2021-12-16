public class GameState
{
  String[][] set;
  public String path = null;
  public boolean fresh = true, done = true;
  public String[][][] map = null;
  SQLite db;

  GameState(PApplet thePApplet) {
    db = new SQLite( thePApplet, FileHandler.GetFolder()+"\\data.sqlite" );
    db.connect();
  }

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
