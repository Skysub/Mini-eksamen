class ButtonWPauseMove extends BaseButton {

  ///width, heigh, text, color, clickColor, TextSize, textColor
  ButtonWPauseMove(int w, int h, String t, color c, color cc, int ts, color tc) {
    widthB = w;
    heightB = h;
    buttonText = t;
    buttonColor = c;
    currentColor = c;
    clickColor = cc;
    textSize = ts;
    textColor = tc;
  }

  //Så man kan pause knappen, så den stadig tegnes men ikke opdateres når den ikke er i brug
  void Run(boolean pause, int posX, int posY) {
    x = posX;
    y = posY;
    Draw(posX, posY);
    if (!pause) {
      Update();
      currentColor = buttonColor;
    }
  }

  void Draw(int x, int y) {
    fill(currentColor);
    if (mouseOver)fill(color(red(currentColor)*0.8f, green(currentColor)*0.8f, blue(currentColor)*0.8f)); 

    noStroke();
    rect(x, y, widthB, heightB, 15);

    fill(textColor);
    textSize(textSize);
    textAlign(CENTER, CENTER);
    text(buttonText, x+(widthB/2), y+(heightB/2));
  }
}
