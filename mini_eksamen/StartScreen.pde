class StartScreen extends GameState {

  Button knap;
  
  
  StartScreen() {
    knap = new Button(500,500,500,500,"AMONG US!", color(200,150,150),color(100,200,100),20,color(0));
  }

  void Update() {
    knap.Run();
  }
}
