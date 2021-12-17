class ButtonSpm extends BaseButton {

  ///posX, posY, width, heigh, text, color, clickColor, TextSize, textColor
  ButtonSpm(int posX, int posY, int w, int h, String t, color c, color cc, int ts, color tc) {
    x = posX;
    y = posY;
    widthB = w;
    heightB = h;
    buttonText = t;
    buttonColor = c;
    currentColor = c;
    clickColor = cc;
    textSize = ts;
    textColor = tc;
  }

  void Run(int nextSet, boolean done) {
    Draw(nextSet, done);
    Update();
  }

  void Draw(int nS, boolean d) {
    fill(currentColor);
    if(d) fill(200);
    if (mouseOver)fill(color(red(currentColor)*0.8f, green(currentColor)*0.8f, blue(currentColor)*0.8f)); 

    noStroke();
    if(!d)rect(x, y, widthB, heightB, 15);
    else rect(x-40, y, widthB+80, heightB, 15);

    fill(textColor);
    textSize(textSize);
    textAlign(CENTER, CENTER);
    if (!d) text("OpgaveSæt "+nS, x+(widthB/2), y+(heightB/2));
    else text("Ikke flere opgaver", x+(widthB/2), y+(heightB/2));
  }

  boolean isClicked() {
    return clicked;
  }
}
