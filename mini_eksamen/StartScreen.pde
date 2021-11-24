class StartScreen extends GameState {

  Button laererKnap;
  
  
  StartScreen() {
    laererKnap = new Button((width/2)-(width/4),200,100,50,"Lærer", color(200,150,150),color(100,200,100),30,color(0));
  }

  void Update() {
    laererKnap.Run();
    
    if(laererKnap.isClicked()){
      gameStateManager.SkiftGameState("opretOpgave");
    }
  }
}
