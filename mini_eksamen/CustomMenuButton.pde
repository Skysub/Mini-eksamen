class CustomMenuButton extends BaseButton {

  color mouseOverColor;
  Boolean Menu;
  
  CustomMenu customMenu;
  
  ///posX, posY, width, height, text, color, clickColor, TextSize, textColor, mouseOverColor
  CustomMenuButton(int posX, int posY, int w, int h, String t, color c, color cc, int ts, color tc, color moc) {
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
    mouseOverColor = moc;
    
    customMenu = new CustomMenu();
  }
  
    void Draw() {
    fill(currentColor);
    if (mouseOver)fill(mouseOverColor); 

    noStroke();
    rect(x, y, widthB, heightB, 15);

    fill(textColor);
    textSize(textSize);
    textAlign(CENTER, CENTER);
    text(buttonText, x+(widthB/2), y+(heightB/2));
    
    customMenu.draw(Menu);
  }
  
  void Update() {
    if (clicked) Menu = !Menu;
  }
  
}
