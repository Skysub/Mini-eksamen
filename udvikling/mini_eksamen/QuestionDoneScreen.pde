public class QuestionDoneScreen extends GameState {
  Button backBTN;
  boolean done = false;

  QuestionDoneScreen(PApplet thePApplet, SQLite database) {
    super(thePApplet, database);
    backBTN = new Button(width/2-125, height/2+130, 250, 50, "Tilbage til kortet", color(200, 150, 150), color(100, 200, 100), 25, color(0));
  }

  void Update(boolean klaret, int antalMangler, int antalP, int antalR, int antalS) {
    Draw(klaret, antalMangler, antalP, antalR, antalS);

    backBTN.Run();

    if (backBTN.clicked) {
      done = true;
    }
  }

  void Draw(boolean klaret, int antalMangler, int antalP, int antalR, int antalS) {
    fill(220);
    rect(width/4, height/4, width/2, height/2);

    fill(175);
    rect(width/4+20, height/4+20, width/2-40, height/2-40);

    if (klaret) {
      fill(0);
      textAlign(CENTER, TOP);
      textSize(50);
      text("Flor klaret!", width/2, height/4+40);

      textSize(30);
      text("Du fik " + antalR + "/" + antalS + " rigtige!", width/2, height/4+120);
      text("Du har tjent " + antalP + " mønter.", width/2, height/4+160);
    } else {

      fill(0);
      textAlign(CENTER, TOP);
      textSize(50);
      text("Kom igen!", width/2, height/4+40);

      textSize(30);
      text("Du manglede at svare " + antalMangler + " spørgsmål korrekt!", width/2, height/4+120);
    }
  }
}
