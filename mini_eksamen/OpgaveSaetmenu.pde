
class OpgaveSaetMenu extends GameState {
  XMLHandler xmlHandler;

  Button doneKnap, nyKnap;
  ExitButton exitBTN;
  boolean ny, listTilArray = true, exitP = false, reset = false;

  ArrayList<String[][]> opgaveSaetAL = new ArrayList<String[][]>();
  String[][][] opgaveSaet;

  OpgaveSaetMenu(PApplet thePApplet, SQLite database) {
        super(thePApplet, database);
    xmlHandler = new XMLHandler();
    doneKnap = new Button(width/2+100, height/2, 250, 50, "Afslut opretning", color(200, 150, 150), color(100, 200, 100), 25, color(0));
    nyKnap = new Button(width/2-355, height/2, 250, 50, "Nyt opgavesæt", color(200, 150, 150), color(100, 200, 100), 25, color(0));
    exitBTN = new ExitButton(width, height, 75, 75, "Back", color(180, 180, 180), color(255, 200, 200), 20, color(25, 25, 25), color(230, 150, 150));
  }

  void Update(int oN, String[][] nyOpgave, boolean add, boolean sure, GameState parent) {
    doneKnap.Update();
    nyKnap.Update();

    if (sure) {
      doneKnap.Draw();
      nyKnap.Draw();
    }


    if (add && sure) opgaveSaetAL.add(nyOpgave);

    if (doneKnap.clicked) {
      if (listTilArray) {
        opgaveSaet = new String[oN][99][7];

        for (int i = 0; i < opgaveSaetAL.size(); i++) {
          String[][] thisOpgaveSaet = opgaveSaetAL.get(i);
          opgaveSaet[i] = thisOpgaveSaet;
        }

        xmlHandler.WriteToXML(opgaveSaet); //Her bliver String arrayet sendt til xml klassen og lavet om til en xml fil.
        //parent.ChangeScreen("start");

        //TINGENE HERUNDER SKAL SKE EFTER ALT XML-DIMS ER FÆRDIGGJORT :)
        for (int i = opgaveSaetAL.size() - 1; i >= 0; i--) {
          opgaveSaetAL.remove(i);
        }
        opgaveSaet = null;
        reset = true;
        listTilArray = false;
      }
      oN = 0;
      ChangeScreen("opretOpgave");
    } else reset = false;

    ny = false;
    if (nyKnap.clicked) ny = true;
    else ny = false;
  }

  void Draw(int n) {
    fill(220);
    rect(width/4, height/4, width/2, height/2);

    fill(175);
    rect(width/4+20, height/4+20, width/2-40, height/2-40);

    if (n == 0) {
      fill(0);
      textAlign(CENTER, TOP);
      textSize(50);
      text("Start næste opgavesæt!", width/2, height/4+40);
      nyKnap.Run();
    } else {

      fill(0);
      textAlign(CENTER, TOP);
      textSize(50);
      text("Opgavesæt opretet!", width/2, height/4+40);

      textSize(30);
      text("Antal opgavesæt: " + n, width/2, height/4+120);

      textSize(20);
      text("Hvis du opretter et nyt opgavesæt ligges det som det næste sæt på elevernes kort.", width/2, height/4+170);
      text("Hvis du afslutter ligges alle opgavesættene i en XML-fil, du skal give til dine elever.", width/2, height/4+200);

      doneKnap.Run();
      nyKnap.Run();

      if (reset) n = 0;
    }
  }

  void ResetNow() {
    listTilArray = true;
  }
}
