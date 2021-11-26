class Character {

  Boolean frontScreen = false, assignment = false, costumize = false, speaking = false, lineDetermined = false;
  PVector fsPos, asPos, coPos, pos;
  int dialoguePick;
  float speakTimeSec, speakTimeMillis, speakTimeFrameStart, evaluateMillis, sizeMod = 2;

  String spokenLine;

  String[] fsLines = {"Jeg har glædet mig til matematik!", "Hej! Er du klar til at regne?", "Velkommen tilbage!", "Så skal der regnes!", "Heyo!", "Yes! du er tilbage", "Er du frisk på lidt matematik?", "Skal vi spare sammen til noget nyt?\nSå lad os regne!", "Lad os komme i gang!", "Hej! Så er det tid til matematik"};
  String[] asLines = {"Godt klaret!", "Den var lidt svær syntes jeg", "Wow, den var du god til!", "Nice! Godt gjort", "Alright, lad os tage den næste", "Det er godt med noget udfordring", "Vi skal nok tjene en masse mønter!", "Wow, den løste du hurtigt", "Ej, den var sjov", "Det tror jeg også er svaret"};

  Character() {
    //hvor på skærmen karakteren tegnes
    fsPos = new PVector(500, 640);
    asPos = new PVector(500, 640);
    coPos = new PVector(500, 640);
    speakTimeSec = 3;
    speakTimeMillis = speakTimeSec*1000;
  }

  void Update(int characterState) {

    //tjek af gamestate, der passes til klassen gennem update metoden som en int
    switch(characterState) {
    case 0:
      frontScreen = true;
      assignment = false;
      costumize = false;
      pos = fsPos;
      break;
    case 1: 
      frontScreen = false;
      assignment = true;
      costumize = false;
      pos = asPos;
      break;
    case 2:
      frontScreen = false;
      assignment = false;
      costumize = true;
      pos = coPos;
      break;
    default:
      println("characterState out of bounds");
      break;
    }
  }

  void drawCharacter(Boolean speak) {
    translate(pos.x, pos.y);
    stroke(4);
    strokeWeight(5);
    fill(255,255,255);

    //krop og hoved
    line(0, 40*sizeMod, 0, -50*sizeMod);
    circle(0, -50*sizeMod, 30*sizeMod);

    //ben
    line(0, 40*sizeMod, 20*sizeMod, 100*sizeMod);
    line(0, 40*sizeMod, -20*sizeMod, 100*sizeMod);

    //arme
    line(0, -30*sizeMod, 25*sizeMod, 30*sizeMod);
    line(0, -30*sizeMod, -25*sizeMod, 30*sizeMod);

    if (speak) {
      speak();
    }
  }

  void speak() { //<>//

    if (speaking == false) {
      dialoguePick = round(random(0, 9)); //<>//
      speakTimeFrameStart = millis();

      if (lineDetermined == false) {
        if (frontScreen) {
          spokenLine = fsLines[dialoguePick];
        }
        if (assignment) {
          spokenLine = asLines[dialoguePick];
        }
      }
    }

    //evaluateMillis = millis();
    if (millis() < speakTimeFrameStart + speakTimeMillis) {
      speaking = true;
    } else {
      speaking = false;
      //println("no longer speaking");
    }
 //<>//
//println (millis() + "///////" + (speakTimeFrameStart+speakTimeMillis));

    if (frontScreen && speaking) {
      drawBubble();
      textAlign(CENTER);
      fill(0,0,0);
      textSize(25);
      text(spokenLine, 230, -220);
    }

    if (assignment && speaking) {
      drawBubble();
      textAlign(CENTER);
      fill(0,0,0);
      textSize(25);
      text(spokenLine, 230, -220);
    }
  }

  void drawBubble() {
    strokeWeight(5);
    fill(255, 255, 255);
    triangle(90, -170, 140, -170, 50, -100);
    ellipse(230, -230, 430, 200);
    noStroke();
  }
  
  Boolean speakCheck() {
    if (speaking) return true;
    return false;
  }
}