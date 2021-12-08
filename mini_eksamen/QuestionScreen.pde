class QuestionScreen extends GameState {

  ExitButton exitButton;
  String[][] opgaver = new String[3][7];
  int opgaveNummer = 1, antalRigtige = 0, antalPoint = 0;
  String antalSPG, pointIAlt, antalKorrekteSPG, laererNavn, SPG, fTekst, pointSPG, rSvar, fSvar1, fSvar2, fSvar3;
  IntList intListeRandom = IntList.fromRange(0, 4);
  boolean shuffle = true, svar = false;
  ButtonWPauseMove rBTN, f1BTN, f2BTN, f3BTN;

  QuestionScreen() {
    ///posX, posY, width, heigh, text, color, clickColor, TextSize, textColor
    exitButton = new ExitButton(25, height - 125, 75, 75, "Back", color(180, 180, 180), color(255, 200, 200), 20, color(25, 25, 25), color(230, 150, 150));

    rBTN = new ButtonWPauseMove(250, 50, "Rigtigt", color(200, 150, 150), color(100, 200, 100), 25, color(0));
    f1BTN = new ButtonWPauseMove(250, 50, "forkert 1 tf", color(200, 150, 150), color(100, 200, 100), 25, color(0));
    f2BTN = new ButtonWPauseMove(250, 50, "forkert 2 nj", color(200, 150, 150), color(100, 200, 100), 25, color(0));
    f3BTN = new ButtonWPauseMove(250, 50, "forkert 3 jj", color(200, 150, 150), color(100, 200, 100), 25, color(0));
  }

  void Update() {
    OpretOpgaver();

    antalSPG = opgaver[0][0];
    pointIAlt = opgaver[0][1];
    antalKorrekteSPG = opgaver[0][2];
    laererNavn = opgaver[0][3];

    SPG = opgaver[opgaveNummer][0];
    fTekst = opgaver[opgaveNummer][1];
    pointSPG = opgaver[opgaveNummer][2];
    rSvar = opgaver[opgaveNummer][3];
    fSvar1 = opgaver[opgaveNummer][4];
    fSvar2 = opgaver[opgaveNummer][5];
    fSvar3 = opgaver[opgaveNummer][6];

    if (shuffle) {
      intListeRandom.shuffle();
      svar = true;
    }
    shuffle = false;

    exitButton.Run();
    if (exitButton.isClicked()) {
      ChangeScreen("start");
    }

    Draw();
    rBTN.Run(false, width - 340, 320 + 100 * intListeRandom.get(0));
    f1BTN.Run(false, width - 340, 320 + 100 * intListeRandom.get(1));
    f2BTN.Run(false, width - 340, 320 + 100 * intListeRandom.get(2));
    f3BTN.Run(false, width - 340, 320 + 100 * intListeRandom.get(3));

    if (rBTN.isClicked() && svar || f1BTN.isClicked() && svar || f2BTN.isClicked() && svar || f3BTN.isClicked() && svar) {
      if (rBTN.isClicked()) {
        antalRigtige++;
      } else {
        //Ting der skal ske når der svares forkert
      }
      shuffle = true;
      opgaveNummer++; 
      print(opgaveNummer);
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
    text("Opgavesæt x", 20, 20);


    textSize(25);
    text("Spørgsmål: " + opgaveNummer + "/" + antalSPG, 20, 120);
    text("Antal korrekte spørgsmål: " + antalRigtige + "/" + antalSPG, 20, 160);
    text("Antal spørgsmål korrekte for at klare sættet: "+ antalKorrekteSPG, 20, 200);
    text("Antal muligt optjænelige mønter: " + pointIAlt, 20, 240);

    textSize(35);
    text("Spørgsmål " + opgaveNummer, 620, 120);
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



  //Bare midlertidig metode, indtil at samarbejde med at få hentet arrayet fra XML-filen implementeres, bare så alt på skærmen kan testes.
  void OpretOpgaver() {
    opgaver[0][0] = "2";
    opgaver[0][1] = "8";
    opgaver[0][2] = "1";
    opgaver[0][3] = "Ole";

    opgaver[1][0] = "Hvad er den bedste serie?";
    opgaver[1][1] = "Det kan du godt svare på, kom nu! Dette er den forklarende tekst h";
    opgaver[1][2] = "2";
    opgaver[1][3] = "Ingen af de nævnte serier";
    opgaver[1][4] = "The Flash";
    opgaver[1][5] = "Ninjago";
    opgaver[1][6] = "JoJo";

    opgaver[2][0] = "Hvem er den sejeste lærer på HCØ gymnasium?";
    opgaver[2][1] = "HCØ Gymnasium i Lyngbu, der ligger på DTU";
    opgaver[2][2] = "6";
    opgaver[2][3] = "Espen";
    opgaver[2][4] = "Nina";
    opgaver[2][5] = "Ole";
    opgaver[2][6] = "Tina :^(";
  }
}
