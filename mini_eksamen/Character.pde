class Character {

  Boolean frontScreen = false, assignment = false, costumize = false;
  PVector fsPos, asPos, coPos;

  Character(int characterState) {
    switch(characterState) {
    case 0:
      frontScreen = true;
      break;
    case 1: 
      assignment = true;
      break;
    case 2:
      costumize = true;
      break;
    default:
      println("characterState out of bounds");
      break;
    }
  }

  void update() {
    
  }

  void draw() {
    if (frontScreen) {
      
    }
    
    if (assignment) {
      
    }
    
    if (costumize) {
      
    }
  }
  
  void drawCharacter(PVector pos, float size) {
    
  }
}
