class CustomMenu { //<>// //<>//

  Boolean ItemsInitialized = false;
  int itemCount, verticalItems, horizontalItems, menuWidth = 580, menuHeight = 696, seperation = 116, rows, row, column;
  ArrayList<ItemButton> itemButtons ;

  CustomMenu() {
    verticalItems = menuHeight/seperation;
    horizontalItems = menuWidth/seperation;
    itemCount = verticalItems*horizontalItems;
    rows = horizontalItems;

    itemButtons = new ArrayList<ItemButton>();
    ///posX, posY, width, height, text, color, clickColor, TextSize, textColor
  }

  void Update(Boolean Menu) {
    if (Menu) {

      if (ItemsInitialized == false) {
        itemButtons.clear();

        //kode til at loade items
        //for each item i SQL add til arraylist {
        //row = i % rows;
        //column = i /rows;
        //itemButtons.add(new ItemButton(*constructor stuff*));
        //}
      }

      for (int i = 0; i < itemButtons.size(); i++) {
        ItemButton itemButton = itemButtons.get(i);
        itemButton.Update();
        itemButton.Draw();
      }
    }
  }

  void Draw(Boolean Menu) {
    if (Menu) {
      fill(180, 200, 220);
      rect(round(width/2-menuWidth/2), 100, menuWidth, menuHeight+200, 10);

      fill(0, 0, 0);
      textSize(50);
      textAlign(CENTER);
      text("KOOL MATH RPG", round(width/2), 80);
    }
  }
}
