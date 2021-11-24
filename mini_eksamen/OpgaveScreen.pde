class OpgaveScreen extends GameState {

  Button knap;
  
  
  OpgaveScreen() {
    knap = new Button((width/2)-(width/4),200,100,50,"Hahahahha", color(200,150,150),color(100,200,100),30,color(0));
  }

  void Update() {
    knap.Run();
    
    if(knap.isClicked()){
      
    }
  }
}
