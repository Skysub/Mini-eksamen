class QuestionScreen extends GameState {

  ExitButton exitButton;
  String[][] opgaver = new String[99][7];
  int opgaveNummer = 1, antalRigtige = 0, antalPoint = 0, i = 0, i2 = 0, opgaveNummerDisplay, opgaveSaetNummer, tidligereOpgaveSaetNummer;
  int opgaveTid = -1, opgaveTidTemp, setBefore = -1;
  String antalSPG, pointIAlt, antalKorrekteSPG, laererNavn, SPG, fTekst, pointSPG, rSvar, fSvar1, fSvar2, fSvar3;
  IntList intListeRandom = IntList.fromRange(0, 4);
  ButtonWPauseMove rBTN, f1BTN, f2BTN, f3BTN;
  QuestionDoneScreen questionDoneScreen;

  QuestionScreen(PApplet thePApplet, SQLite database) {
    super(thePApplet, database);
    ///posX, posY, width, heigh, text, color, clickColor, TextSize, textColor
    exitButton = new ExitButton(25, height - 125, 75, 75, "Back", color(180, 180, 180), color(255, 200, 200), 20, color(25, 25, 25), color(230, 150, 150));

    rBTN = new ButtonWPauseMove(250, 50, "Svar!", color(200, 150, 150), color(100, 200, 100), 25, color(0));
    f1BTN = new ButtonWPauseMove(250, 50, "Svar!", color(200, 150, 150), color(100, 200, 100), 25, color(0));
    f2BTN = new ButtonWPauseMove(250, 50, "Svar!", color(200, 150, 150), color(100, 200, 100), 25, color(0));
    f3BTN = new ButtonWPauseMove(250, 50, "Svar!", color(200, 150, 150), color(100, 200, 100), 25, color(0));
    questionDoneScreen = new QuestionDoneScreen(thePApplet, database);
    intListeRandom.shuffle();
  }

  void Update() {
    //GetOpgaveSaetNummer();
    if (nextSet > setBefore) {
      setBefore = nextSet;
      opgaveTidTemp = millis();
    }

    if (i2 == 0) {
      antalRigtige = 0;
      antalPoint = 0;
      opgaver = set;
    }
    i2++;

    antalSPG = opgaver[0][0];
    pointIAlt = opgaver[0][1];
    antalKorrekteSPG = opgaver[0][2];
    laererNavn = opgaver[0][3];

    if (opgaveNummer < int(antalSPG) + 1) {
      SPG = opgaver[opgaveNummer][0];
      fTekst = opgaver[opgaveNummer][1];
      pointSPG = opgaver[opgaveNummer][2];
      rSvar = opgaver[opgaveNummer][3];
      fSvar1 = opgaver[opgaveNummer][4];
      fSvar2 = opgaver[opgaveNummer][5];
      fSvar3 = opgaver[opgaveNummer][6];
    }

    Draw();
    rBTN.Run(false, width - 340, 320 + 100 * intListeRandom.get(0));
    f1BTN.Run(false, width - 340, 320 + 100 * intListeRandom.get(1));
    f2BTN.Run(false, width - 340, 320 + 100 * intListeRandom.get(2));
    f3BTN.Run(false, width - 340, 320 + 100 * intListeRandom.get(3));

    if (rBTN.isClicked() && opgaveNummer < int(antalSPG) + 1 || f1BTN.isClicked() && opgaveNummer < int(antalSPG) + 1 || f2BTN.isClicked() && opgaveNummer < int(antalSPG) + 1 || f3BTN.isClicked() && opgaveNummer < int(antalSPG) + 1) {
      if (i >= 50) {
        if (rBTN.isClicked()) {
          antalRigtige++;
          antalPoint += int(pointSPG);
        } else {
          //Ting der skal ske n??r der svares forkert
        }
        //Ting der skal g??res selvom sp??rgsm??let er rigtigt eller ej.
        intListeRandom.shuffle();
        opgaveNummer++; 
        i = 0;
        mainLogic.speakLine = true;
      }
    } 
    i++;
    opgaveNummerDisplay = opgaveNummer;

    exitButton.Run();
    if (exitButton.isClicked()) {
      ChangeScreen("map");
    }

    if (opgaveNummer == int(antalSPG) + 1) {
      if (opgaveTid == -1) opgaveTid = millis() - opgaveTidTemp;
      if (antalRigtige >= int(antalKorrekteSPG)) questionDoneScreen.Update(true, int(antalKorrekteSPG) - antalRigtige, antalPoint, antalRigtige, int(antalSPG));
      else questionDoneScreen.Update(false, int(antalKorrekteSPG) - antalRigtige, antalPoint, antalRigtige, int(antalSPG));
      opgaveNummerDisplay = opgaveNummer - 1;
    }

    if (questionDoneScreen.done) {
      //print("hahah f??rdig ");
      opgaveNummer = 1;
      i = 0;
      i2 = 0;
      questionDoneScreen.done = false;
      if (antalRigtige >= int(antalKorrekteSPG)) { 
        mainLogic.UpdateCoins(antalPoint);
        AddToDataBase();
      }
      ChangeScreen("map");
    }
  }

  void Draw() {
    noStroke();
    fill(175);
    rect(600, 100, width - 650, height - 150);

    fill(190);
    rect(620, 295, width-690, 100);
    rect(620, 495, width-690, 100);

    fill(0);
    textAlign(CORNER, TOP);
    textSize(50);
    text("Opgaves??t " + nextSet, 20, 20);


    textSize(25);
    text("Sp??rgsm??l: " + opgaveNummerDisplay + "/" + antalSPG, 20, 120);
    text("Antal korrekte sp??rgsm??l: " + antalRigtige + "/" + antalSPG, 20, 160);
    text("Antal sp??rgsm??l korrekte for at klare s??ttet: "+ antalKorrekteSPG, 20, 200);
    text("Antal muligt optj??nelige m??nter: " + pointIAlt, 20, 240);

    textSize(35);
    text("Sp??rgsm??l " + opgaveNummer, 620, 120);
    text(SPG, 620, 170);

    textSize(25);
    text(fTekst, 620, 230);

    text("Svar 1:", 620, 330);
    text("Svar 2:", 620, 430);
    text("Svar 3:", 620, 530);
    text("Svar 4:", 620, 630);

    text(rSvar, 710, 330 + 100 * intListeRandom.get(0));
    text(fSvar1, 710, 330 + 100 * intListeRandom.get(1));
    text(fSvar2, 710, 330 + 100 * intListeRandom.get(2));
    text(fSvar3, 710, 330 + 100 * intListeRandom.get(3));
  }

  void AddToDataBase() {
    db.execute("INSERT INTO progress VALUES("+nextSet+","+antalSPG+","+antalKorrekteSPG+","+antalPoint+","+int(opgaveTid/1000f)+");");
    opgaveTid = -1;
    delay(10);
  }
}
