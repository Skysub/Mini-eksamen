class CustomMenu { //<>// //<>// //<>// //<>//

  Boolean ItemsInitialized = false;
  int itemCount, verticalItems, horizontalItems, menuWidth = 580, menuHeight = 696, seperation = 116, rows, row, column;
  ArrayList<ItemButton> itemButtons;
  ArrayList<PImage> itemTextures;
  String tempItemType;

  ItemButton itemButton;

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

      //for creating the arraylist of itembuttons and reading SQL player data first time
      if (ItemsInitialized == false) {
        itemButtons.clear();

        initializeItemsBasic();
        //from SQL get the owned and wearing items
        //character.currentHead = SQL currentHead
        //character.currentShoes = SQL currentShoes
        //character.currentShirt = SQL currentShirt
      }

      //loops through the item buttons
      for (int i = 0; i < itemButtons.size(); i++) {
        itemButton = itemButtons.get(i);
        itemButton.Run();

        //what the itemButtons do when clicked depending on their state
        if (itemButton.isClicked() && itemButton.noItem != true) {

          //buying an item
          if (itemButton.purchased != true && itemButton.price < mainLogic.coinAmount()) {
            itemButton.purchased = true;
            mainLogic.addCoins(itemButton.price*-1);
          }

          //equip new item
          if (itemButton.purchased == true && itemButton.wearing != true) {
            //unequips other items of this type
            tempItemType = itemButton.itemType;
            for (int a = 0; a < itemButtons.size(); a++) {
              itemButton = itemButtons.get(a);
              if (itemButton.itemType == tempItemType) {
                itemButton.wearing = false;
              }
            }
            //actually equips the new item
            itemButton = itemButtons.get(i);
            itemButton.wearing = true;
            mainLogic.character.changeSpecificCosmetic(itemButton.textureName, itemButton.itemType);
          }

          //unequip worn item
          if (itemButton.purchased == true && itemButton.wearing == true) {
            itemButton.wearing = false;
            mainLogic.character.unequipItem(itemButton.itemType);
          }
        }
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

void initializeItemsBasic() {
  ///posX, posY, width, heigh, text, color, clickColor, TextSize, textColor, mouseOverColor, price, purchased, textureName, noItem 
  //itemButtons.add(new ItemButton(*constructor stuff*));
}
