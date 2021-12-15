class ItemButton extends BaseButton {

  color mouseOverColor;
  String textureName, itemType;
  int price;
  Boolean purchased, noItem, wearing;
  PImage itemTexture;

  ///posX, posY, width, heigh, text, color, clickColor, TextSize, textColor, mouseOverColor, price, purchased, textureName, noItem, itemType 
  ItemButton(int posX, int posY, int w, int h, String t, color c, color cc, int ts, color tc, color moc, int p, Boolean pur, String tn, Boolean ni, Boolean we, String it) {
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
    price = p;
    purchased = pur;
    textureName = tn;
    noItem = ni;
    wearing = we;
    itemType = it;

    if (noItem) {
      buttonText = "Item TBA";
    } else if (!noItem) {
      itemTexture = loadImage(textureName);
    }
  }

  void Draw(String wItem1, String wItem2, String wItem3) {
    //checks if the button corresponds to a purchased item
    //read through SQL check against items purchased
    //if (textureName == pItem) purchased = true;
    
    //checks if the button corresponds to a worn item
    if (textureName == wItem1 || textureName == wItem2 || textureName == wItem3) wearing = true;
    
    fill(currentColor);
    if (mouseOver)fill(mouseOverColor); 

    noStroke();
    rect(x, y, widthB, heightB, 15);

    if (!noItem) {
      imageMode(CENTER);
      image(itemTexture, x+(widthB/2), y+(heightB/2));
    }

    fill(textColor);
    textSize(textSize);
    textAlign(CENTER, CENTER);
    text(buttonText, x+(widthB/2), y+(heightB/2));

    if (purchased) drawPurchased();
    if (wearing) drawWearing();
  }

  void drawPurchased() {
    //draws a green checkmark of two lines
    stroke(14, 135, 22);
    line(x+(widthB/2)-46, y+(heightB/2)-50, x+(widthB/2)-50, y+(heightB/2)-54);
    line(x+(widthB/2)-50, y+(heightB/2)-54, x+(widthB/2)-48, y+(heightB/2)-52);
  }
  
  void drawWearing() {
    //draws a small orange circle to indicate the item is equipped
    noStroke();
    fill(202,61,8);
    circle(x+(widthB/2)-38, y+(heightB/2)-50,3);
  }
}
