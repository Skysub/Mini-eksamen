class ItemButton extends BaseButton {

  color mouseOverColor;
  String textureName, itemType;
  int price;
  Boolean purchased, noItem, wearing, showPrice = false;
  PImage itemTexture;
  String wItem1, wItem2, wItem3;
  String[] nameSplit = new String[1];

  ///posX, posY, width, heigh, text, color, clickColor, TextSize, textColor, mouseOverColor, price, purchased, textureName, noItem 
  ItemButton(int posX, int posY, int w, int h, String t, color c, color cc, int ts, color tc, color moc, int p, Boolean pur, String tn, Boolean ni) {
    x = posX;
    y = posY;
    widthB = w;
    heightB = h;
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
    
    //Remove once SQL is running
    if (purchased == null) {
      purchased = true;
    }
    
    //checks if the item is worn
    if (textureName == mainLogic.character.currentHead || textureName == mainLogic.character.currentShirt || textureName == mainLogic.character.currentShoes) {
      wearing = true;
    } else wearing = false;
    

    if (noItem) {
      buttonText = "Item TBA";
    } else if (!noItem) {
      nameSplit = split(t, '.');
      buttonText = nameSplit[0];
      itemTexture = loadImage(textureName);
    }

    if (!noItem && !purchased) {
      showPrice = true;
    }

    assignItemType(textureName);
  }

  void Draw() {
    
    //gets worn items and checks if the price should be displayed
    updateWornItems();

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
    if (showPrice) drawPrice();
  }

  void drawPurchased() {
    //draws a green checkmark of two lines
    fill(14, 135, 22);
    //line(x+(widthB/2)-46, y+(heightB/2)-50, x+(widthB/2)-50, y+(heightB/2)-54);
    rect(x+(widthB/2)-46, y+(heightB/2)-46, 12, 12);
  }

  void drawWearing() {
    //draws a small orange circle to indicate the item is equipped
    noStroke();
    fill(202, 61, 8);
    circle(x+(widthB/2)-20, y+(heightB/2)-40, 12);
  }

  void drawPrice() {
    //draws price and a small golden coin symbol
    noStroke();
    fill(217,176,28);
    textSize(20);
    textMode(CENTER);
    text(price, x+(widthB/2)+20, y+(heightB/2)+40,12);
    circle(x+(widthB/2)+40, y+(heightB/2)+42.5,12);
  }
  

  void updateWornItems() {
    wItem1 = mainLogic.character.getwItem("hat");
    wItem2 = mainLogic.character.getwItem("shirt");
    wItem3 = mainLogic.character.getwItem("shoes");
    
    if (!purchased && !noItem) showPrice = true; else showPrice = false;
  }

  void assignItemType(String itemName) {
    if (itemName.contains("hat.png")) itemType = "hat";
    if (itemName.contains("shirt.png")) itemType = "shirt";
    if (itemName.contains("shoes.png")) itemType = "shoes";
  }
}
