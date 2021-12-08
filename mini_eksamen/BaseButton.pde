class BaseButton {
  Boolean pressed = false, clicked = false, mouseOver = false; //pressed er om selve mussen klikkes på, clicked er om knappen klikkes på
  int x, y, widthB, heightB, textSize;
  String buttonText;
  color currentColor, buttonColor, clickColor, textColor;

  void Run() {
    Draw();
    Update();
  }

  void Update() {
    if (mouseX >= x && mouseX <= x + widthB && mouseY >= y && mouseY <= y + heightB) {
      cursor(HAND);
      mouseOver = true;
      if (mousePressed && mouseButton == LEFT && pressed == false) {
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
    rect(x, y, widthB, heightB, 15);

    fill(textColor);
    textSize(textSize);
    textAlign(CENTER, CENTER);
    text(buttonText, x+(widthB/2), y+(heightB/2));
  }

  boolean isClicked() {
    return clicked;
  }
}
/* 
 Når en knap skal instantieres:
 Button btn1;
 
 btn1 = new Button(xPos, yPos, længde, højde, "evt. tekst", farven af selv knappen (eks color(200, 50, 50), farven når knappen klikkes, teksstørelsen, farven af teksten);
 
 Når knappen skal bruges (i update-funktion i en klasse for eksempel:
 btn1.run();
 if(btn1.isClicked()){
 //Det der skal ske når man trykke på knappen 
 }
 
 */
