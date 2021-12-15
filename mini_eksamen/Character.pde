class Character { //<>// //<>// //<>// //<>// //<>//

  Boolean frontScreen = false, assignment = false, speaking = false, lineDetermined = false, characterOnScreen = false;
  PVector fsPos, asPos, pos;
  int dialoguePick;
  float speakTimeSec, speakTimeMillis, speakTimeFrameStart, evaluateMillis, sizeMod = 2.5;

  String spokenLine;

  String currentHead = "none", currentShoes = "none", currentShirt = "none";
  PImage headTexture, shoeTexture, shirtTexture;
  Boolean head = false, shoes = false, shirt = false;

  String[] fsLines = {"Jeg har glædet mig til matematik!", "Hej! Er du klar til at regne?", "Velkommen tilbage!", "Så skal der regnes!", "Heyo!", "Yes! du er tilbage", "Er du frisk på lidt matematik?", "Skal vi spare sammen til noget nyt?\nSå lad os regne!", "Lad os komme i gang!", "Hej! Så er det tid til matematik"};
  String[] asLines = {"Godt klaret!", "Den var lidt svær syntes jeg", "Wow, den var du god til!", "Nice! Godt gjort", "Alright, lad os tage den næste", "Det er godt med noget udfordring", "Vi skal nok tjene en masse mønter!", "Wow, den løste du hurtigt", "Ej, den var sjov", "Det tror jeg også er svaret"};

  Character() {
    //hvor på skærmen karakteren tegnes
    fsPos = new PVector(round(width/6), round(height/2));
    asPos = new PVector(500, 640);
    speakTimeSec = 3;
    speakTimeMillis = speakTimeSec*1000;
  }

  void Update(String characterState) {

    //tjek af gamestate
    if (characterState == "map") {
      frontScreen = true;
      assignment = false;
      pos = fsPos;
      characterOnScreen = true;
    } else if (characterState == "questionScreen") {
      frontScreen = false;
      assignment = true;
      pos = asPos;
      characterOnScreen = true;
    } else {
      characterOnScreen = false;
    }
  }


  void drawCharacter(Boolean speak) {

    if (characterOnScreen == true) {
      translate(pos.x, pos.y);
      stroke(4);
      strokeWeight(5);
      fill(255, 255, 255);

      //krop og hoved
      line(0, 40*sizeMod, 0, -50*sizeMod);
      circle(0, -50*sizeMod, 30*sizeMod);

      //ben
      line(0, 40*sizeMod, 20*sizeMod, 100*sizeMod);
      line(0, 40*sizeMod, -20*sizeMod, 100*sizeMod);

      //arme
      line(0, -30*sizeMod, 25*sizeMod, 30*sizeMod);
      line(0, -30*sizeMod, -25*sizeMod, 30*sizeMod);

      drawCosmetics();
    }

    //println(speak);
    if (speak) {
      speak();
    }
  }

  void speak() {
    if (speaking == false) {
      dialoguePick = round(random(0, 9));
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

    //println (millis() + "///////" + (speakTimeFrameStart+speakTimeMillis));

    if (frontScreen && speaking) {
      drawBubble();
      textAlign(CENTER);
      fill(0, 0, 0);
      textSize(25);
      text(spokenLine, 230, -220);
    }

    if (assignment && speaking) {
      drawBubble();
      textAlign(CENTER);
      fill(0, 0, 0);
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

  void drawCosmetics() {
    imageMode(CENTER);

    //println("Current head item: " + currentHead);
    //println("Current shirt item: " + currentShirt);

    //current coords are innacurate //<>//
    if (head) {
      image(headTexture, 0, -50*sizeMod);
    }

    if (shirt) {
      image(shirtTexture, 0, 0);
    }

    if (shoes) {
      image(shoeTexture, 20*sizeMod, 100*sizeMod);
      image(shoeTexture, -20*sizeMod, 100*sizeMod);
    }
  }

  //Metode, der lader en skifte hvad en karakter har på. Denne skifter alting
  void loadWearingCosmetics(String wItem1, String wItem2, String wItem3) {
    if (wItem1 != "none") {
      currentHead = wItem1;
      headTexture = loadImage(currentHead);
      head = true;
    } else if (wItem1 == "none") {
      head = false;
    }
    if (wItem2 != "none") {
      currentShoes = wItem2;
      shoeTexture = loadImage(currentShoes);
      shoes = true;
    } else if (wItem2 == "none") {
      shoes = false;
    }
    if (wItem3 != "none") {
      currentShirt = wItem3;
      shirtTexture = loadImage(currentShirt);
      shirt = true;
    } else if (wItem3 == "none") {
      shirt = false;
    }
  }

  //til at skifte enkelt cosmetic ad gangen
  void changeSpecificCosmetic(String wItem, String itemType) {
    if (itemType == "hat") {
      println("Hat runs!");
      currentHead = wItem;
      headTexture = loadImage(currentHead);
      head = true;
    } else if (itemType == "shoes") {
      currentShoes = wItem;
      shoeTexture = loadImage(currentShoes);
      shoes = true;
    } else if (itemType == "shirt") {
      println("shirt runs!");
      currentShirt = wItem;
      shirtTexture = loadImage(currentShirt);
      shirt = true;
    }
  }

  //til at unequipe et enkelt item
  void unequipItem(String itemType) {
    if (itemType == "hat") {
      currentHead = "none";
      headTexture = null;
      head = false;
    } else if (itemType == "shoes") {
      currentShoes = "none";
      shoeTexture = null;
      shoes = false;
    } else if (itemType == "shirt") {
      currentShirt = "none";
      shirtTexture = null;
      shirt = false;
    }
  }
  
  String getwItem(String itemSlot) {
    if(itemSlot == "head") return currentHead;
    if(itemSlot == "shirt") return currentShirt;
    if(itemSlot == "shoes") return currentShoes;
    else return "wrong call in getwItem, Character";
  }

  Boolean speakCheck() {
    if (speaking) return true;
    return false;
  }
}
