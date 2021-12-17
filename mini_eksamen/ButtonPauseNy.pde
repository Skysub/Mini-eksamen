class ButtonPauseNy extends BaseButton {

  ///posX, posY, width, heigh, text, color, clickColor, TextSize, textColor
  ButtonPauseNy(int posX, int posY, int w, int h, String t, color c, color cc, int ts, color tc) {
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

  //Så man kan pause knappen, så den stadig tegnes men ikke opdateres når den ikke er i brug
  //Men den reagerer stadig på mouseover så man ikke tror at programmet er frossent
  void Run(boolean pause) {
    if (!pause) {
      currentColor = buttonColor;
      Update();
    } else {
      currentColor = color(200);
      UpdateMouseOver();
    }
    Draw();
  }

  void UpdateMouseOver() {
    if (mouseX >= x && mouseX <= x + widthB && mouseY >= y && mouseY <= y + heightB) {
      mouseOver = true;
    } else { 
      cursor(ARROW);
      mouseOver = false;
    }
  }
}
