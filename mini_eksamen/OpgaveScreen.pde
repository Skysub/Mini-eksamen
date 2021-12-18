class OpgaveScreen extends GameState {


  OpgaveSaetMenu opgaveSaetMenu;
  ExitButton exitButton;
  ButtonPauseNy gemSpgKnap, nytSpgKnap, startSaetKnap;
  TextField spgTF, rTF, f1TF, f2TF, f3TF, fTekst, pointPerSpg, antalSpgTF, antalSpgKlareTF, navnTF;
  String spg, r, f1, f2, f3, fT, pPS, antalSpg, antalSpgKlare, navn;
  boolean canSave, clickedGem, clickedgemTrue = false, nyOpgaveKlar = true, nySpg = false, opretOpgave = false, saetIgang = true, opgIgang = false, startSaetKnapClicked = false, array = true, add = true, ny = true, gemTekst = false, openSaetSkaerm = true;
  int opgaveNummer = 1, opgaveSaetNummer = 0, opacity = 200, maxPoint = 0;

  String[][] opgave;

  OpgaveScreen(PApplet thePApplet, SQLite database) {
    super(thePApplet, database);
    opgaveSaetMenu = new OpgaveSaetMenu(thePApplet, database);

    //Knapper
    gemSpgKnap = new ButtonPauseNy(520, 920, 250, 50, "Gem opgave", color(200, 150, 150), color(100, 200, 100), 25, color(0));
    nytSpgKnap = new ButtonPauseNy(820, 920, 250, 50, "Næste opgave", color(200, 150, 150), color(100, 200, 100), 25, color(0));
    startSaetKnap = new ButtonPauseNy(20, 580, 250, 50, "Start sættet", color(200, 150, 150), color(100, 200, 100), 25, color(0));
    exitButton = new ExitButton(25, height - 125, 75, 75, "Back", color(180, 180, 180), color(255, 200, 200), 20, color(25, 25, 25), color(230, 150, 150));


    //Tekstfelter
    spgTF = new TextField(thePApplet, "", new PVector(520, 180), 550, false);
    rTF = new TextField(thePApplet, "", new PVector(520, 330), 550, false);
    f1TF = new TextField(thePApplet, "", new PVector(520, 480), 550, false);
    f2TF = new TextField(thePApplet, "", new PVector(520, 630), 550, false);
    f3TF = new TextField(thePApplet, "", new PVector(520, 780), 550, false);
    fTekst = new TextField(thePApplet, "", new PVector(1120, 180), 550, false);
    pointPerSpg = new TextField(thePApplet, "", new PVector(1120, 330), 550, true);

    antalSpgTF = new TextField(thePApplet, "", new PVector(20, 330), 460, true);
    antalSpgKlareTF = new TextField(thePApplet, "", new PVector(20, 480), 460, true);
    navnTF = new TextField(thePApplet, "", new PVector(20, 180), 460, false);
  }

  void Update() {
    Draw();
    UpdateBtnsTextfields();

    //Sørger for at opgaverne kan oprettes når alt info om opgavesættet er givet
    if (startSaetKnap.isClicked() && !antalSpgTF.tooShort && !antalSpgKlareTF.tooShort || opretOpgave) {

      if (array) {
        //Tilføjer info om opgavesættet på arrayets første plads
        opgaveNummer = 1;
        opgave = new String[int(antalSpg)+1][7];
        opgave[0][0] = antalSpg;
        opgave[0][1] = "Placeholder";
        opgave[0][2] = antalSpgKlare; //Tjek skemaet i repositoriet, nogle ting er ændrede
        opgave[0][3] = navn;

        if (opgave[0][0] == null || opgave[0][0] == "0") antalSpg = "1";
        openSaetSkaerm = true;
      }

      ny = true;
      array = false;

      opretOpgave = true;
      opgIgang = true;
      saetIgang = false;
      fill(200, 200, 200, opacity);
      rect(0, 100, 500, height);

      if (spgTF.tooShort || rTF.tooShort || f1TF.tooShort || f2TF.tooShort || f3TF.tooShort || pointPerSpg.tooShort) {
        canSave = false;
      } else {
        canSave = true;
        gemTekst = false;
      }

      if (gemSpgKnap.isClicked()) {
        clickedGem = true;
      } else clickedGem = false;

      textAlign(CORNER, TOP);
      fill(200, 50, 50);
      textSize(25);

      if (!canSave && clickedGem || gemTekst) {
        text("Du skal udfylde alle felter", 520, 850);
        gemTekst = true;
      }

      if (!canSave && clickedgemTrue) {
        clickedgemTrue = false;
      } else if (canSave && clickedGem) clickedgemTrue = true;

      if (nySpg && !clickedgemTrue) {
        text("Du skal udfylde alle felter og gemme opgaven før du kan lave en ny", 520, 850);
      }

      if (nytSpgKnap.isClicked()) {
        if (clickedgemTrue) {
          if (nyOpgaveKlar) {
            opgave[opgaveNummer][0] = spg;
            opgave[opgaveNummer][1] = fT;
            opgave[opgaveNummer][2] = pPS;
            opgave[opgaveNummer][3] = r;
            opgave[opgaveNummer][4] = f1;
            opgave[opgaveNummer][5] = f2;
            opgave[opgaveNummer][6] = f3;
            maxPoint += int(pPS);
            opgaveNummer++;

            spgTF.RemoveText();
            rTF.RemoveText();
            f1TF.RemoveText();
            f2TF.RemoveText();
            f3TF.RemoveText();
            fTekst.RemoveText();
            pointPerSpg.RemoveText();

            clickedGem = false;
            clickedgemTrue = false;
            nySpg = false;
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

    if (startSaetKnapClicked && antalSpgTF.tooShort || startSaetKnapClicked && antalSpgKlareTF.tooShort) {
      textAlign(CORNER, TOP);
      fill(200, 50, 50);
      textSize(20);
      text("Du skal have indtastet før du kan lave opgaverne", 20, 530);
    } 

    if (opgaveNummer - 1 == int(antalSpg) && !array) {
      fill(175, 175, 175, opacity);
      rect(500, 100, width - 550, height - 150);

      opgave[0][1] = str(maxPoint);
      opgIgang = true;
      saetIgang = true;

      if (add) {
        opgaveSaetNummer++;
      }
      opgaveSaetMenu.Update(opgaveSaetNummer, opgave, add, true, this);

      opgaveSaetMenu.Draw(opgaveSaetNummer);
      add = false;
      nySpg = false;
    }

    if (opgaveSaetMenu.ny && ny) {

      opgaveNummer = 1;
      opgaveSaetMenu.Update(opgaveSaetNummer, opgave, add, false, this);


      opgaveSaetMenu.Update(opgaveSaetNummer, opgave, add, false, this);
      opgaveNummer = 1;

      clickedgemTrue = false;
      nyOpgaveKlar = true;
      nySpg = false;
      opretOpgave = false;
      saetIgang = true;
      opgIgang = false;
      startSaetKnapClicked = false;
      array = true;
      add = true;
      ny = false;
      maxPoint = 0;
    }
    ny = false;

    if (opgaveSaetMenu.reset && openSaetSkaerm) {
      opgaveSaetNummer = 0;
      array = true;
      opgaveSaetMenu.ResetNow();
      opgaveSaetMenu.listTilArray = true;
      openSaetSkaerm = false;
      saetIgang = true;
      opgIgang = false;

      ChangeScreen("start");
    }
  }

  void Draw() {
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
    text("Antal point for rigtigt svar (0-9):", 1120, 270);
    text("Rigtig svarmulighed:", 520, 270);
    text("Dit navn:", 20, 130);
    text("Antal opgaver i sættet:", 20, 270);
    text("Antal rigtige for at klare opgavesættet:", 20, 420);
    text("Forklarende tekst:", 1120, 120);
    text("Forkert svarmulighed 1:", 520, 420);
    text("Forkert svarmulighed 2:", 520, 570);
    text("Forkert svarmulighed 3:", 520, 720);
    text("Opgaver oprettet: " + str(int(opgaveNummer) - 1) + "/" + antalSpg, width - 340, 120);

    textSize(20);
    text("Før du opretter opgaverne skal du angive dette:", 20, 100);
    text("Opgavesættene du opretter bliver tilføjet til elevernes kort i den rækkefølge du opretter dem i", 500, 50);
  }

  void UpdateButtons() {
    exitButton.Run();
    if (exitButton.isClicked()) {
      ChangeScreen("start");
    }
  }

  void UpdateBtnsTextfields() {
    UpdateButtons();
    gemSpgKnap.Run(saetIgang);
    nytSpgKnap.Run(saetIgang);


    spgTF.Update(false, 0, 0, saetIgang);
    rTF.Update(false, 0, 0, saetIgang);
    f1TF.Update(false, 0, 0, saetIgang);
    f2TF.Update(false, 0, 0, saetIgang);
    f3TF.Update(false, 0, 0, saetIgang);
    fTekst.Update(false, 0, 0, saetIgang);
    pointPerSpg.Update(true, 0, 1, saetIgang);

    spg = spgTF.Input(false, 0, 0);
    r = rTF.Input(false, 0, 0);
    f1 = f1TF.Input(false, 0, 0);
    f2 = f2TF.Input(false, 0, 0);
    f3 = f3TF.Input(false, 0, 0);
    fT = fTekst.Input(false, 0, 0);
    pPS = pointPerSpg.Input(true, 0, 1);

    startSaetKnap.Run(opgIgang);

    antalSpgTF.Update(true, 0, 2, opgIgang);
    antalSpgKlareTF.Update(true, 0, 2, opgIgang);
    navnTF.Update(false, 0, 0, opgIgang);

    antalSpg = antalSpgTF.Input(true, 0, 2);
    antalSpgKlare = antalSpgKlareTF.Input(true, 0, 2);
    navn = navnTF.Input(false, 0, 0);
  }
}
