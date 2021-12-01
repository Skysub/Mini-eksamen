class ButtonWPause extends BaseButton {

  ///posX, posY, width, heigh, text, color, clickColor, TextSize, textColor
  ButtonWPause(int posX, int posY, int w, int h, String t, color c, color cc, int ts, color tc) {
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

//Viktors knap ting
  void Run(boolean pause) {
    Draw();
    if (!pause) {
      Update();
      currentColor = buttonColor;
    }
  }
}
