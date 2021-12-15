class NameScreen extends GameState {

  SQLite db;

  NameScreen(PApplet thePApplet) {
    db = new SQLite( thePApplet, FileHandler.GetFolder()+"\\data.sqlite" );
    db.connect();
  }

  void Update() {
  }

  void SetName(String name) {
    db.execute("INSERT INTO info VALUES(0,'name','"+name+"');");
  }
}
