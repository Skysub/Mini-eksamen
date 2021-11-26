class OpgaveScreen extends GameState {

  Button gemSpgKnap, nytSpgKnap, startSaetKnap;
  TextField spgTF, rTF, f1TF, f2TF, f3TF, fTekst, pointPerSpg, antalSpgTF, antalSpgKlareTF;
  String spg, r, f1, f2, f3, fT, pPS, antalSpg, antalSpgKlare;
  boolean canSave, clickedGem, nyOpgaveKlar = true, nySpg = false, opretOpgave = false, saetIgang = true, opgIgang = false, startSaetKnapClicked = false, array = true;
  int opgaveNummer = 1, opgaveSaetNummer = 1, opacity = 180;

  OpgaveScreen(PApplet thePApplet) {
    //Knapper
    gemSpgKnap = new Button(520, 920, 250, 50, "Gem opgave", color(200, 150, 150), color(100, 200, 100), 25, color(0));
    nytSpgKnap = new Button(820, 920, 250, 50, "Næste opgave", color(200, 150, 150), color(100, 200, 100), 25, color(0));
    startSaetKnap = new Button(20, 430, 250, 50, "Start sættet", color(200, 150, 150), color(100, 200, 100), 25, color(0));

    //Tekstfelter
    spgTF = new TextField(thePApplet, "", new PVector(520, 180), 550);
    rTF = new TextField(thePApplet, "", new PVector(520, 330), 550);
    f1TF = new TextField(thePApplet, "", new PVector(520, 480), 550);
    f2TF = new TextField(thePApplet, "", new PVector(520, 630), 550);
    f3TF = new TextField(thePApplet, "", new PVector(520, 780), 550);
    fTekst = new TextField(thePApplet, "", new PVector(1120, 180), 550);
    pointPerSpg = new TextField(thePApplet, "", new PVector(1120, 330), 550);

    antalSpgTF = new TextField(thePApplet, "", new PVector(20, 180), 460);
    antalSpgKlareTF = new TextField(thePApplet, "", new PVector(20, 330), 460);
  }

  void Update() {
    draw();

    gemSpgKnap.Run(saetIgang);
    nytSpgKnap.Run(saetIgang);

    spgTF.Update(false, 0, 0);
    rTF.Update(false, 0, 0);
    f1TF.Update(false, 0, 0);
    f2TF.Update(false, 0, 0);
    f3TF.Update(false, 0, 0);
    fTekst.Update(false, 0, 0);
    pointPerSpg.Update(true, 0, 1);

    spg = spgTF.Input(false, 0, 0);
    r = rTF.Input(false, 0, 0);
    f1 = f1TF.Input(false, 0, 0);
    f2 = f2TF.Input(false, 0, 0);
    f3 = f3TF.Input(false, 0, 0);
    fT = fTekst.Input(false, 0, 0);
    pPS = pointPerSpg.Input(true, 0, 1);

    startSaetKnap.Run(opgIgang);

    antalSpgTF.Update(true, 0, 2);
    antalSpgKlareTF.Update(true, 0, 2);

    antalSpg = antalSpgTF.Input(true, 0, 2);
    antalSpgKlare = antalSpgKlareTF.Input(true, 0, 2);


    if (startSaetKnap.isClicked() && !antalSpgTF.tooShort && !antalSpgKlareTF.tooShort || opretOpgave) {
      if (array) {
        String[] opgave = new String[int(antalSpg)+1];
      }
      array = false;

      opretOpgave = true;
      opgIgang = true;
      saetIgang = false;
      fill(200, 200, 200, opacity);
      rect(0, 100, 500, height);

      if (spgTF.tooShort || rTF.tooShort || f1TF.tooShort || f2TF.tooShort || f3TF.tooShort || pointPerSpg.tooShort) {
        canSave = false;
      } else canSave = true;

      if (gemSpgKnap.isClicked()) {
        clickedGem = true;
      }

      textAlign(CORNER, TOP);
      fill(200, 50, 50);
      textSize(25);

      if (!canSave && clickedGem) {
        text("Du skal udfylde alle felter", 520, 850);
      }
      if (nySpg && !clickedGem) {
        text("Du skal gemme opgaven før du kan lave en ny", 520, 850);
      }

      if (nytSpgKnap.isClicked()) {
        if (clickedGem) {
          if (nyOpgaveKlar) {
            opgave[0] = spg;
            opgave[1] = fT;
            opgave[2] = pPS;
            opgave[3] = r;
            opgave[4] = f1;
            opgave[5] = f2;
            opgave[6] = f3;
            opgavesaet.add(opgave);
            opgaveNummer++;

            for (int i = 0; i < opgavesaet.size(); i++) {
              String[] opg = opgavesaet.get(0);
              print(opg[0], opg[1], opg[2], opg[3], opg[4], opg[5], opg[6]);
            }

            spgTF.RemoveText();
            rTF.RemoveText();
            f1TF.RemoveText();
            f2TF.RemoveText();
            f3TF.RemoveText();
            fTekst.RemoveText();
            pointPerSpg.RemoveText();
          }
        } else nySpg = true;
        nyOpgaveKlar = false;
      } else nyOpgaveKlar = true;
      //Når der ikke oprettes opgaver
    } else {
      opgIgang = false;
      saetIgang = true;
      fill(175, 175, 175, opacity);
      rect(500, 100, width - 550, height - 150);
    } 
    if (startSaetKnap.isClicked()) startSaetKnapClicked = true;

    if (startSaetKnapClicked && antalSpgTF.tooShort ||startSaetKnapClicked && antalSpgKlareTF.tooShort) {
      textAlign(CORNER, TOP);
      fill(200, 50, 50);
      textSize(20);
      text("Du skal have indtastet før du kan lave opgaverne", 20, 380);
    }
  }

  void draw() {
    fill(175);
    rect(500, 100, width - 550, height - 150);

    fill(0);
    textAlign(CORNER, TOP);
    textSize(50);
    text("Opret opgavesæt", 20, 20);

    textSize(35);
    text("Spørgsmål:", 520, 120);

    textSize(25);
    text("Forklarende tekst:", 1120, 120);
    text("Antal point for rigtigt svar (1-9):", 1120, 270);
    text("Rigtig svarmulighed:", 520, 270);
    text("Antal spørgsmål i sættet:", 20, 120);
    text("Antal rigtige for at klare opgavesættet:", 20, 270);
    text("Forklarende tekst:", 1120, 120);
    text("Forkert svarmulighed 1:", 520, 420);
    text("Forkert svarmulighed 2:", 520, 570);
    text("Forkert svarmulighed 3:", 520, 720);

    textSize(20);
    text("Før du opretter opgaverne skal du angive dette:", 20, 80);
  }
}