class Button extends BaseButton {

  ///posX, posY, width, heigh, text, color, clickColor, TextSize, textColor
  Button(int posX, int posY, int w, int h, String t, color c, color cc, int ts, color tc) {
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

  void Update() {
    if (mouseX >= x && mouseX <= x + width && mouseY >= y && mouseY <= y + height) {
      cursor(HAND);
      mouseOver = true;
      if (mousePressed && mouseButton == LEFT  && pressed == false) {
        clicked = true;
        currentColor = clickColor;
      } else {
        currentColor = buttonColor;
      }
    } else { 
      cursor(ARROW);
      mouseOver = false;
      clicked = false;
      currentColor = buttonColor;
    }

    if (!mousePressed) pressed = false;
  }

  void Draw() {
    fill(currentColor);
    if (mouseOver)fill(color(red(currentColor)*0.8f, green(currentColor)*0.8f, blue(currentColor)*0.8f)); 

    noStroke();
    rect(x, y, width, height, 15);

    fill(textColor);
    textSize(textSize);
    textAlign(CENTER, CENTER);
    text(buttonText, x+(width/2), y+(height/2));
  }

  boolean isClicked() {
    return clicked;
  }

}
