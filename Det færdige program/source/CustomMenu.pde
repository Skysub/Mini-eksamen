import java.io.File; //<>// //<>// //<>// //<>// //<>//

class CustomMenu {

  //for reading the data folder
  String dataPath = dataPath("");
  File dir = new File(dataPath);
  File[] files = dir.listFiles();

  String test;

  Boolean ItemsInitialized = false, purchaseState;
  int itemCount, horizontalItems, menuWidth = 580, menuHeight = 696, seperation = 116, rows=7, row, column, itemsAdded = 0;
  ArrayList<ItemButton> itemButtons = new ArrayList<ItemButton>();
  ;
  ArrayList<String> itemTextures = new ArrayList<String>();
  ArrayList<String> ownedItems = new ArrayList<String>();
  String tempItemType;
  PVector buttonPos;
  color c = color(194), click = color(100), mouseOver = color(220), textColor = color(0);

  Button removeItemsButton;

  ItemButton itemButton;

  CustomMenu() {
    horizontalItems = menuWidth/seperation;
    itemCount = rows*horizontalItems;

    //posX, posY, width, heigh, text, color, clickColor, TextSize, textColor
    removeItemsButton = new Button(round(width/2-menuWidth/2)+70, 110, 250, 60, "Remove items", color(200, 150, 150), color(100, 200, 100), 30, color(0));
  }

  void Update(Boolean Menu) {
    if (Menu) {

      removeItemsButton.Run();
      if (removeItemsButton.isClicked()) {
        removeItems();
      }


      //for creating the arraylist of itembuttons and reading SQL player data first time
      if (ItemsInitialized == false) {
        itemButtons.clear();

        //reads through the data folder and loads images into itemTextures
        for (int h = 0; h < files.length; h++) {
          String path = files[h].getPath();

          //checks file type
          if (path.toLowerCase().endsWith(".png")) {
            itemTextures.add(files[h].getName());
          }
        }
        initializeItemsBasic();

        //Henter de items man ejer fra databasen 
        mainLogic.HentCosmetics();

        ItemsInitialized = true;
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
            ownedItems.add(itemButton.textureName);
          }

          //equip new item
          //Der er en fejl her et sted, der ikke lader en equippe et item efter at have taget det af
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

            println(itemButton.textureName);
            mainLogic.character.changeSpecificCosmetic(itemButton.textureName, itemButton.itemType);
          }

          //unequip worn item
          //if (itemButton.purchased == true && itemButton.wearing == true) {
          //  itemButton.wearing = false;
          //  mainLogic.character.unequipItem(itemButton.itemType);
          //}
        }
      }
    }
  }

  void Draw(Boolean Menu) {
    if (Menu) {
      fill(180, 180, 180);
      rect(round(width/2-menuWidth/2), 100, menuWidth, menuHeight+200, 10);

      fill(0, 0, 0);
      textSize(50);
      textAlign(CENTER);
      text("KOOL SKOOL RPG", round(width/2), 80);
    }
  }


  void initializeItemsBasic() {
    //posX, posY, width, heigh, text, color, clickColor, TextSize, textColor, mouseOverColor, price, purchased, textureName, noItem

    translate((round(width/2-menuWidth/2)), 100);


    //iterates through itemCount, which is the number of itemButtons
    for (int a = 0; a < itemCount; a++) {

      //if there are already buttons for actual items

      if (itemsAdded >= itemTextures.size()) {

        row = a % rows;
        column = a/rows;
        buttonPos = new PVector(seperation*column, seperation*row);
        //posX, posY, width, height, text, color, clickColor, TextSize, textColor, mouseOverColor, price, purchased, textureName, noItem 
        itemButton = new ItemButton(round(buttonPos.x+width/2-menuWidth/2+2.5), round(buttonPos.y+100+seperation/1.5), seperation-5, seperation-5, " ", color(45, 49, 74), color(100, 100, 100), 20, color(255), color(126, 153, 189), 25, false, " ", true);
        itemButtons.add(itemButton);
        //itemButtons.add(new ItemButton(round(buttonPos.x), round(buttonPos.y), seperation, seperation, itemTextures.get(a), color(194, 194, 194), color(100, 100, 100), 20, color(0, 0, 0), color(220, 220, 220), 25, false, itemTextures.get(a), true));
        //the button doesn't have item

        itemsAdded++;

        //if there is not buttons for all actual items
      } else if (itemsAdded < itemTextures.size()) {

        //matrix of itemTextures and ownedItems is looped through to figure out if the item is purchased or not
        for (int b = 0; b < itemTextures.size(); b++) {
          for (int c = 0; c < ownedItems.size(); c++) {
            if (itemTextures.get(b) == ownedItems.get(c)) {
              purchaseState = true;
              break;
            } else purchaseState = false;
          }
        }

        row = a % rows;
        column = a/rows;
        buttonPos = new PVector(seperation*column, seperation*row);
        //posX, posY, width, heigh, text, color, clickColor, TextSize, textColor, mouseOverColor, price, purchased, textureName, noItem
        itemButtons.add(new ItemButton(round(buttonPos.x+width/2-menuWidth/2+2.5), round(buttonPos.y+100+seperation/1.5), seperation-5, seperation-5, itemTextures.get(a), color(45, 49, 74), color(100, 100, 100), 20, color(255), color(126, 153, 189), 25, purchaseState, itemTextures.get(a), false));
        //the button has item

        itemsAdded++;
      }
    }
  }

  void removeItems() {
    for (int q = 0; q < itemButtons.size(); q++) {
      itemButton = itemButtons.get(q);
      if (itemButton.wearing == true) {
        itemButton.wearing = false;
        mainLogic.character.unequipItem(itemButton.itemType);
      }
    }
  }
}
