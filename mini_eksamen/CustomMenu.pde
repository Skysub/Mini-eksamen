class CustomMenu {

  Boolean ItemsInitialized = false;

  int itemCount, verticalItems, horizontalItems, menuWidth = 580, menuHeight = 696, seperation = 116;


  ItemButton[] items;

  CustomMenu() {
    verticalItems = menuHeight/seperation;
    horizontalItems = menuWidth/seperation;
    itemCount = verticalItems*horizontalItems;
    items = new ItemButton[itemCount];
  }

  void Update(Menu) {
    if(Menu) {
      
    }
  }

  void Draw(Boolean Menu) {
    if (Menu) {
      fill(180, 200, 220);
      rect(700, 300, 580, 600, 10);

      fill(0, 0, 0);
      textSize(50);
      text("KOOL MATH RPG", 745, 370);
    }
  }
}
