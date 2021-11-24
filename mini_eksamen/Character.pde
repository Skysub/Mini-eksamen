class Character {

  Boolean frontScreen = false, assignment = false, costumize = false, speaking = false;
  PVector fsPos, asPos, coPos;
  int dialoguePick;
  float speakTimeSec, speakTimeFrames, speakTimeFrameStart;
  
  String[] fsLines = {"Jeg har glædet mig til matematik!", "Hej! Er du klar til at regne?", "Velkommen tilbage!", "Så skal der regnes!","Heyo!", "Yes! du er tilbage", "Er du frisk på lidt matematik?", "Skal vi spare sammen til noget nyt? Så lad os regne!", "Lad os komme i gang!"};
  String[] asLines = {"Godt klaret!", "Den var lidt svær syntes jeg", "Wow, den var du god til!", "Nice! Godt gjort", "Alright, lad os tage den næste", "Det er godt med noget udfordring", "Vi skal nok tjene en masse mønter!", "Wow, den løste du hurtigt", "Ej, den var sjov", "Det tror jeg også er svaret"};

  Character() {
    //hvor på skærmen karakteren tegnes
    fsPos = new PVector(500, 640);
    asPos = new PVector(500, 640);
    coPos = new PVector(500, 640);
    speakTimeSec = 5;
    speakTimeFrames = 5*60;
  }

  void update(int characterState) {

    //tjek af gamestate, der passes til klassen gennem update metoden som en int
    switch(characterState) {
    case 0:
      frontScreen = true;
      assignment = false;
      costumize = false;
      break;
    case 1: 
      frontScreen = false;
      assignment = true;
      costumize = false;
      break;
    case 2:
      frontScreen = false;
      assignment = false;
      costumize = true;
      break;
    default:
      println("characterState out of bounds");
      break;
    }
  }

  void draw() {
    if (frontScreen) {
    }

    if (assignment) {
    }

    if (costumize) {
    }
  }

  void drawCharacter(PVector pos) {
    
  }

  void speak() {

    if (speaking == false) {
      dialoguePick = round(random(0, 9));
      speakTimeFrameStart = millis();
    }

    if (millis() < speakTimeFrameStart + speakTimeFrames) {
      speaking = true;
    } else {
      speaking = false;
    }

    if (frontScreen && speaking) {
      drawBubble(fsPos);
    }

    if (assignment && speaking) {
      drawBubble(asPos);
    }
  }

  void drawBubble(PVector characterPos) {

    translate(characterPos.x, characterPos.y);
    strokeWeight(5);
    fill(255, 255, 255);
    triangle(90, -120, 140, -120, 50, -50);
    ellipse(150, -150, 200, 120);
    noStroke();

    

  }
}
