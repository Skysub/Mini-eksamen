class Button {
  Boolean pressed = false, clicked = false; //pressed er om selve mussen klikkes på, clicked er om knappen klikkes på
  int x, y, width, height, textSize, counter = 50;
  String buttonText;
  color currentColor, buttonColor, clickColor, textColor;

  Button(int posX, int posY, int w, int h, String t, color c, color cc, int ts, color tc) {
    x = posX;
    y = posY;
    width = w;
    height = h;
    buttonText = t;
    buttonColor = c;
    currentColor = c;
    clickColor = cc;
    textSize = ts;
    textColor = tc;
  }
  void run() {
    draw();
    update();
  }

  void update() {
    if (mouseX >= x && mouseX <= x + width && mouseY >= y && mouseY <= y + height || counter < 20) {
      cursor(HAND);
      fill(0, 0, 0, 70);
      noStroke();
      rect(x, y, width, height, 15);
    } else cursor(ARROW);

    if (mousePressed && mouseButton == LEFT && pressed == false) {
      pressed = true;
      if (mouseX >= x && mouseX <= x + width && mouseY >= y && mouseY <= y + height) {
        clicked = true;
        counter = 0;
        currentColor = clickColor;
      }
    } else { 
      clicked = false;
    }

    if (!mousePressed) pressed = false;

    counter++;
    if (counter > 20) currentColor = buttonColor;
  }

  void draw() {
    fill(currentColor);
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
