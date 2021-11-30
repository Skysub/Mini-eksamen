class CustomMenu {

  Boolean ItemsInitialized = false;

  int itemCount, verticalItems, horizontalItems, menuWidth = 580, menuHeight = 696, seperation = 116, rows, row, column;


  ArrayList<ItemButton> itemButtons = new ArrayList<ItemButton>();

  CustomMenu() {
    verticalItems = menuHeight/seperation;
    horizontalItems = menuWidth/seperation;
    itemCount = verticalItems*horizontalItems;
    rows = horizontalItems;
  }

  void Update(Boolean Menu) {
    if(Menu) {
      
      if(ItemsInitialized == false) {
        //kode til at loade items
        //for each item i SQL add til arraylist
      }
      
      for(int i = 0; i < itemButtons.size(); i++){
        itemButtons[i]
      }
    }
  }

  void draw(Boolean Menu) {
    if (Menu) {
      fill(180, 200, 220); //<>//
      rect(700, 300, 580, 600, 10);

      fill(0, 0, 0);
      textSize(50);
      text("KOOL MATH RPG", 745, 370);
    }
  }
}
