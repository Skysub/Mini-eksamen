class TextField {
  ControlP5 cp5;
  String enteredString, stringTextfield, seedTextfieldOld;
  boolean tooLong, tooShort;
  Textfield textfield;

  //konstruktør hvor tesktfeltet sættes op. Se http://www.sojamo.de/libraries/controlP5/reference/controlP5/Textfield.html for dokumentation
  //PApplet er en reference til selve sketchen og fåes helt tilbage fra RacerSpil ved at blive trukket igennem konstruktører hertil
  TextField(PApplet thePApplet, String s, PVector pos, int l, boolean kunInt) {
    stringTextfield = "StringTextField";
    enteredString = s;
    cp5 = new ControlP5(thePApplet);
    cp5.setAutoDraw(false);
    PFont p = createFont("Verdana", 20);
    ControlFont font = new ControlFont(p);
    cp5.setFont(font);
    if (kunInt) textfield = cp5.addTextfield("StringTextField").setPosition(pos.x, pos.y).setSize(l, 50).setAutoClear(false).setText(s).setCaptionLabel("").keepFocus(false).setInputFilter(ControlP5.INTEGER);
    else textfield = cp5.addTextfield("StringTextField").setPosition(pos.x, pos.y).setSize(l, 50).setAutoClear(false).setText(s).setCaptionLabel("").keepFocus(false);
  }

  void Update(boolean maxMin, int min, int max, boolean pause) {
    Draw();

    if (!pause) {
      Input(maxMin, min, max);
      enteredString = cp5.get(Textfield.class, stringTextfield).getText();
    } else textfield.clear();
  }

  void Draw() {
    cp5.draw();
  }  

  String Input(Boolean maxMin, int min, int max) {

    if (enteredString.length() > max && maxMin) {
      tooLong = true;
      enteredString = enteredString.substring(0, max);
      textfield.setText(enteredString);
    } else tooLong = false;
    if (enteredString.length() < min || enteredString.length() < 1) tooShort = true;
    else tooShort = false;

    return enteredString;
  }

  void openRemoveText() {
    cp5.get(Textfield.class, stringTextfield).setText("");
  }

  void RemoveText() {

    textfield.setText("");
    enteredString = "";
  }
}
