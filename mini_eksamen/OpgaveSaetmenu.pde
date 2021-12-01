class OpgaveSaetMenu {

  Button doneKnap, nyKnap;
  boolean ny, listTilArray = true;

  ArrayList<String[][]> opgaveSaetAL = new ArrayList<String[][]>();
  String[][][] opgaveSaet;

  OpgaveSaetMenu() {
    doneKnap = new Button(width/2+100, height/2, 250, 50, "Afslut opretning", color(200, 150, 150), color(100, 200, 100), 25, color(0));
    nyKnap = new Button(width/2-355, height/2, 250, 50, "Nyt opgavesæt", color(200, 150, 150), color(100, 200, 100), 25, color(0));
  }

  void Update(int oN, String[][] nyOpgave, boolean add, boolean sure) {
    doneKnap.Run();
    nyKnap.Run();

    if (add && sure) opgaveSaetAL.add(nyOpgave);

    if (doneKnap.clicked) {
      if (listTilArray) {
        opgaveSaet = new String[oN+1][99][7];

        for (int i = 0; i < opgaveSaetAL.size(); i++) {
          String[][] thisOpgaveSaet = opgaveSaetAL.get(i);
          opgaveSaet[i] = thisOpgaveSaet;
        }
        
        //LAV SAMARBEJDE MED XML-DIMS LIGE HER, det er opgaveSaet[][][] der er det tre-dimensionelle array
                                                                                                                                   
      }
      listTilArray = false;
    }

    if (nyKnap.clicked) ny = true;
    else ny = false;
  }

  void Draw(int n) {

    fill(220);
    rect(width/4, height/4, width/2, height/2);

    fill(175);
    rect(width/4+20, height/4+20, width/2-40, height/2-40);

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
  }
}
