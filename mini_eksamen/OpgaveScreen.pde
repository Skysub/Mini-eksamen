class OpgaveScreen extends GameState {

  Button gemSpgKnap, nytSpgKnap;
  TextField spgTF, rTF, f1TF, f2TF, f3TF;
  String spg, r, f1, f2, f3;
  boolean canSave, clickedGem, nyOpgaveKlar = true;
  int opgaveNummer = 1, opgaveSaetNummer = 1;
  //String[][][] opgaveSaet;

  OpgaveScreen(PApplet thePApplet) {
    //Knapper
    gemSpgKnap = new Button(520, 920, 250, 50, "Gem opgave", color(200, 150, 150), color(100, 200, 100), 25, color(0));
    nytSpgKnap = new Button(820, 920, 250, 50, "Ny opgave", color(200, 150, 150), color(100, 200, 100), 25, color(0));

    //Tekstfelter
    spgTF = new TextField(thePApplet, "", new PVector(520, 180));
    rTF = new TextField(thePApplet, "", new PVector(520, 330));
    f1TF = new TextField(thePApplet, "", new PVector(520, 480));
    f2TF = new TextField(thePApplet, "", new PVector(520, 630));
    f3TF = new TextField(thePApplet, "", new PVector(520, 780));
  }

  void Update() {
    draw();
    gemSpgKnap.Run();
    nytSpgKnap.Run();

    spgTF.Update(false, 0, 0);
    rTF.Update(false, 0, 0);
    f1TF.Update(false, 0, 0);
    f2TF.Update(false, 0, 0);
    f3TF.Update(false, 0, 0);

    spg = spgTF.Input(false, 0, 0);
    r = rTF.Input(false, 0, 0);
    f1 = f1TF.Input(false, 0, 0);
    f2 = f2TF.Input(false, 0, 0);
    f3 = f3TF.Input(false, 0, 0);

    if (spgTF.tooShort || rTF.tooShort || f1TF.tooShort || f2TF.tooShort || f3TF.tooShort) {
      canSave = false;
    } else canSave = true;

    if (gemSpgKnap.isClicked()) {
      clickedGem = true;
    }

    if (!canSave && clickedGem) {
      textAlign(CORNER, TOP);
      fill(200, 50, 50);
      textSize(25);
      text("Du skal udfylde alle felter", 520, 850);
    }

    if (nytSpgKnap.isClicked() && clickedGem && nyOpgaveKlar) {
      /*opgaveSaet[opgaveSaetNummer -1][opgaveNummer-1][0] = spg;
      opgaveSaet[opgaveSaetNummer -1][opgaveNummer-1][1] = r;
      opgaveSaet[opgaveSaetNummer -1][opgaveNummer-1][2] = f1;
      opgaveSaet[opgaveSaetNummer -1][opgaveNummer-1][3] = f2;
      opgaveSaet[opgaveSaetNummer -1][opgaveNummer-1][4] = f3;
      
      print(opgaveSaet[opgaveSaetNummer -1][opgaveNummer-1][1]);
      */
      opgaveNummer++;
      nyOpgaveKlar = false;
      
    } else nyOpgaveKlar = true;
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
    text("Rigtig svarmulighed:", 520, 270);
    text("Forkert svarmulighed 1:", 520, 420);
    text("Forkert svarmulighed 2:", 520, 570);
    text("Forkert svarmulighed 3:", 520, 720);
  }
}
