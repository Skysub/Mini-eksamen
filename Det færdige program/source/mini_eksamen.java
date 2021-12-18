import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import controlP5.*; 
import de.bezier.data.sql.*; 
import de.bezier.data.sql.mapper.*; 
import java.nio.file.*; 
import java.io.FileWriter; 
import java.io.*; 
import java.util.regex.Matcher; 
import java.util.regex.Pattern; 
import java.io.File; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class mini_eksamen extends PApplet {










MainLogic mainLogic;
XMLHandler xmlHandler;
//stuff

public void setup() {
  
  frameRate(144);
  FileHandler.SetUp();
  xmlHandler = new XMLHandler();
  mainLogic = new MainLogic(this);
}

public void draw() {
  background(220);
  mainLogic.Update();
}

public void fileSelected(File selection) {  
  if (selection == null) {
    mainLogic.gameStateManager.GetGameState("loadFileScreen").fresh = true;
    println("Window was closed or the user hit cancel.");
    mainLogic.gameStateManager.GetGameState("loadFileScreen").going = false;
  } else {
    println("User selected " + selection.getAbsolutePath());

    try {
      mainLogic.gameStateManager.GetGameState("loadFileScreen").path = selection.getAbsolutePath();
    }
    catch(Exception e) {
      println(e);
    }
  }
  mainLogic.gameStateManager.GetGameState("loadFileScreen").done = true;
}
class BaseButton {
  Boolean pressed = false, clicked = false, mouseOver = false; //pressed er om selve mussen klikkes på, clicked er om knappen klikkes på
  int x, y, widthB, heightB, textSize;
  String buttonText;
  int currentColor, buttonColor, clickColor, textColor;

  public void Run() {
    Draw();
    Update();
  }

  public void Update() {
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
    //if (!mousePressed) pressed = false;
    pressed = mousePressed;
    //Nu aktiveres knapper ikke hvis man ikke klikker når musen er direkte over dem
  }

  public void Draw() {
    fill(currentColor);
    if (mouseOver)fill(color(red(currentColor)*0.8f, green(currentColor)*0.8f, blue(currentColor)*0.8f)); 

    noStroke();
    rect(x, y, widthB, heightB, 15);

    fill(textColor);
    textSize(textSize);
    textAlign(CENTER, CENTER);
    text(buttonText, x+(widthB/2), y+(heightB/2));
  }

  public boolean isClicked() {
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
class Button extends BaseButton {

  ///posX, posY, width, heigh, text, color, clickColor, TextSize, textColor
  Button(int posX, int posY, int w, int h, String t, int c, int cc, int ts, int tc) {
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
  }
}
class ButtonPauseNy extends BaseButton {

  ///posX, posY, width, heigh, text, color, clickColor, TextSize, textColor
  ButtonPauseNy(int posX, int posY, int w, int h, String t, int c, int cc, int ts, int tc) {
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
  }

  //Så man kan pause knappen, så den stadig tegnes men ikke opdateres når den ikke er i brug
  //Men den reagerer stadig på mouseover så man ikke tror at programmet er frossent
  public void Run(boolean pause) {
    if (!pause) {
      currentColor = buttonColor;
      Update();
    } else {
      currentColor = color(200);
      UpdateMouseOver();
    }
    Draw();
  }

  public void UpdateMouseOver() {
    if (mouseX >= x && mouseX <= x + widthB && mouseY >= y && mouseY <= y + heightB) {
      mouseOver = true;
    } else { 
      cursor(ARROW);
      mouseOver = false;
    }
  }
}
class ButtonSpm extends BaseButton {

  ///posX, posY, width, heigh, text, color, clickColor, TextSize, textColor
  ButtonSpm(int posX, int posY, int w, int h, String t, int c, int cc, int ts, int tc) {
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
  }

  public void Run(int nextSet, boolean done) {
    Draw(nextSet, done);
    Update();
  }

  public void Draw(int nS, boolean d) {
    fill(currentColor);
    if (d) fill(200);
    if (mouseOver)fill(color(red(currentColor)*0.8f, green(currentColor)*0.8f, blue(currentColor)*0.8f)); 

    noStroke();
    if (!d)rect(x, y, widthB, heightB, 15);
    else rect(x-40, y, widthB+80, heightB, 15);

    fill(textColor);
    textSize(textSize);
    textAlign(CENTER, CENTER);
    if (!d) text("OpgaveSæt "+nS, x+(widthB/2), y+(heightB/2));
    else text("Ikke flere opgaver", x+(widthB/2), y+(heightB/2));
  }

  public boolean isClicked() {
    return clicked;
  }
}
class ButtonWPause extends BaseButton {

  ///posX, posY, width, heigh, text, color, clickColor, TextSize, textColor
  ButtonWPause(int posX, int posY, int w, int h, String t, int c, int cc, int ts, int tc) {
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
  }

  //Så man kan pause knappen, så den stadig tegnes men ikke opdateres når den ikke er i brug
  public void Run(boolean pause) {
    Draw();
    if (!pause) {
      Update();
      currentColor = buttonColor;
    }
  }
}
class ButtonWPauseMove extends BaseButton {

  ///width, heigh, text, color, clickColor, TextSize, textColor
  ButtonWPauseMove(int w, int h, String t, int c, int cc, int ts, int tc) {
    widthB = w;
    heightB = h;
    buttonText = t;
    buttonColor = c;
    currentColor = c;
    clickColor = cc;
    textSize = ts;
    textColor = tc;
  }

  //Så man kan pause knappen, så den stadig tegnes men ikke opdateres når den ikke er i brug
  public void Run(boolean pause, int posX, int posY) {
    x = posX;
    y = posY;
    Draw(posX, posY);
    if (!pause) {
      Update();
      currentColor = buttonColor;
    }
  }

  public void Draw(int x, int y) {
    fill(currentColor);
    if (mouseOver)fill(color(red(currentColor)*0.8f, green(currentColor)*0.8f, blue(currentColor)*0.8f)); 

    noStroke();
    rect(x, y, widthB, heightB, 15);

    fill(textColor);
    textSize(textSize);
    textAlign(CENTER, CENTER);
    text(buttonText, x+(widthB/2), y+(heightB/2));
  }
}
class Character { //<>// //<>// //<>// //<>// //<>// //<>// //<>//

  Boolean frontScreen = false, assignment = false, speaking = false, lineDetermined = false, characterOnScreen = false;
  PVector fsPos, asPos, pos;
  int dialoguePick;
  float speakTimeSec, speakTimeMillis, speakTimeFrameStart, evaluateMillis, sizeMod = 2.5f;

  String spokenLine;

  String currentHead = "none", currentShoes = "none", currentShirt = "none";
  PImage headTexture, shoeTexture, shirtTexture;
  Boolean head = false, shoes = false, shirt = false;

  String[] fsLines = {"Jeg har glædet mig til matematik!", "Hej! Er du klar til at regne?", "Velkommen tilbage!", "Så skal der regnes!", "Heyo!", "Yes! du er tilbage", "Er du frisk på lidt matematik?", "Skal vi spare sammen til noget nyt?\nSå lad os regne!", "Lad os komme i gang!", "Hej! Så er det tid til matematik"};
  String[] asLines = {"Godt klaret!", "Den var lidt svær syntes jeg", "Wow, den var du god til!", "Nice! Godt gjort", "Alright, lad os tage den næste", "Det er godt med noget udfordring", "Vi skal nok tjene en masse mønter!", "Wow, den løste du hurtigt", "Ej, den var sjov", "Det tror jeg også er svaret"};

  Character() {
    //hvor på skærmen karakteren tegnes
    fsPos = new PVector(round(width/6), round(height/2));
    asPos = new PVector(100, 670);
    speakTimeSec = 3;
    speakTimeMillis = speakTimeSec*1000;
  }

  public void Update(String characterState) {

    //tjek af gamestate
    if (characterState == "map") {
      frontScreen = true;
      assignment = false;
      pos = fsPos;
      characterOnScreen = true;
    } else if (characterState == "questionScreen") {
      frontScreen = false;
      assignment = true;
      pos = asPos;
      characterOnScreen = true;
    } else {
      characterOnScreen = false;
    }
  }


  public void drawCharacter(Boolean speak) {

    if (characterOnScreen == true) {
      translate(pos.x, pos.y);
      stroke(4);
      strokeWeight(5);
      fill(255, 255, 255);

      //krop og hoved
      line(0, 40*sizeMod, 0, -50*sizeMod);
      circle(0, -50*sizeMod, 30*sizeMod);

      //ben
      line(0, 40*sizeMod, 20*sizeMod, 100*sizeMod);
      line(0, 40*sizeMod, -20*sizeMod, 100*sizeMod);

      //arme
      line(0, -30*sizeMod, 25*sizeMod, 30*sizeMod);
      line(0, -30*sizeMod, -25*sizeMod, 30*sizeMod);

      drawCosmetics();
    }

    //println(speak);
    if (speak) {
      speak();
    }
  }

  public void speak() {
    if (speaking == false) {
      dialoguePick = round(random(0, 9));
      speakTimeFrameStart = millis();

      if (lineDetermined == false) {
        if (frontScreen) {
          spokenLine = fsLines[dialoguePick];
        }
        if (assignment) {
          spokenLine = asLines[dialoguePick];
        }
      }
    }

    //evaluateMillis = millis();
    if (millis() < speakTimeFrameStart + speakTimeMillis) {
      speaking = true;
    } else {
      speaking = false;
      //println("no longer speaking");
    }

    //println (millis() + "///////" + (speakTimeFrameStart+speakTimeMillis));

    if (frontScreen && speaking) {
      drawBubble();
      textAlign(CENTER);
      fill(0, 0, 0);
      textSize(25);
      text(spokenLine, 230, -220);
    }

    if (assignment && speaking) {
      drawBubble();
      textAlign(CENTER);
      fill(0, 0, 0);
      textSize(25);
      text(spokenLine, 230, -220);
    }
  }

  public void drawBubble() {
    strokeWeight(5);
    fill(255, 255, 255);
    triangle(90, -170, 140, -170, 50, -100);
    ellipse(230, -230, 430, 200);
    noStroke();
  }

  public void drawCosmetics() {
    imageMode(CENTER);

    //println("Current head item: " + currentHead);
    //println("Current shirt item: " + currentShirt);

    //current coords are innacurate
    if (head) {
      image(headTexture, 0, -50*sizeMod);
    }

    if (shirt) {
      image(shirtTexture, 0, 0);
    }

    if (shoes) {
      image(shoeTexture, 20*sizeMod, 100*sizeMod);
      image(shoeTexture, -20*sizeMod, 100*sizeMod);
    }
  }

  //Metode, der lader en skifte hvad en karakter har på. Denne skifter alting
  public void loadWearingCosmetics(String wItem1, String wItem2, String wItem3) {
    if (wItem1 != "none") {
      currentHead = wItem1;
      headTexture = loadImage(currentHead);
      head = true;
    } else if (wItem1 == "none") {
      head = false;
    }
    if (wItem2 != "none") {
      currentShoes = wItem2;
      shoeTexture = loadImage(currentShoes);
      shoes = true;
    } else if (wItem2 == "none") {
      shoes = false;
    }
    if (wItem3 != "none") {
      currentShirt = wItem3;
      shirtTexture = loadImage(currentShirt);
      shirt = true;
    } else if (wItem3 == "none") {
      shirt = false;
    }
  }

  //til at skifte enkelt cosmetic ad gangen
  public void changeSpecificCosmetic(String wItem, String itemType) {
    if (itemType == "hat") {
      println("Hat runs!");
      currentHead = wItem;
      headTexture = loadImage(currentHead);
      head = true;
    } else if (itemType == "shoes") {
      currentShoes = wItem;
      shoeTexture = loadImage(currentShoes);
      shoes = true;
    } else if (itemType == "shirt") {
      println("shirt runs!");
      currentShirt = wItem;
      shirtTexture = loadImage(currentShirt);
      shirt = true;
    }
  }

  //til at unequipe et enkelt item
  public void unequipItem(String itemType) {
    if (itemType == "hat") {
      currentHead = "none";
      headTexture = null;
      head = false;
    } else if (itemType == "shoes") {
      currentShoes = "none";
      shoeTexture = null;
      shoes = false;
    } else if (itemType == "shirt") {
      currentShirt = "none";
      shirtTexture = null;
      shirt = false;
    }
  }

  public String getwItem(String itemSlot) {
    if (itemSlot == "head") return currentHead;
    if (itemSlot == "shirt") return currentShirt;
    if (itemSlot == "shoes") return currentShoes;
    else return "wrong call in getwItem, Character";
  }

  public Boolean speakCheck() {
    if (speaking) return true;
    return false;
  }
}
 //<>// //<>// //<>// //<>// //<>//

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
  int c = color(194), click = color(100), mouseOver = color(220), textColor = color(0);

  Button removeItemsButton;

  ItemButton itemButton;

  CustomMenu() {
    horizontalItems = menuWidth/seperation;
    itemCount = rows*horizontalItems;

    //posX, posY, width, heigh, text, color, clickColor, TextSize, textColor
    removeItemsButton = new Button(round(width/2-menuWidth/2)+70, 110, 250, 60, "Remove items", color(200, 150, 150), color(100, 200, 100), 30, color(0));
  }

  public void Update(Boolean Menu) {
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

  public void Draw(Boolean Menu) {
    if (Menu) {
      fill(180, 180, 180);
      rect(round(width/2-menuWidth/2), 100, menuWidth, menuHeight+200, 10);

      fill(0, 0, 0);
      textSize(50);
      textAlign(CENTER);
      text("KOOL SKOOL RPG", round(width/2), 80);
    }
  }


  public void initializeItemsBasic() {
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
        itemButton = new ItemButton(round(buttonPos.x+width/2-menuWidth/2+2.5f), round(buttonPos.y+100+seperation/1.5f), seperation-5, seperation-5, " ", color(45, 49, 74), color(100, 100, 100), 20, color(255), color(126, 153, 189), 25, false, " ", true);
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
        itemButtons.add(new ItemButton(round(buttonPos.x+width/2-menuWidth/2+2.5f), round(buttonPos.y+100+seperation/1.5f), seperation-5, seperation-5, itemTextures.get(a), color(45, 49, 74), color(100, 100, 100), 20, color(255), color(126, 153, 189), 25, purchaseState, itemTextures.get(a), false));
        //the button has item

        itemsAdded++;
      }
    }
  }

  public void removeItems() {
    for (int q = 0; q < itemButtons.size(); q++) {
      itemButton = itemButtons.get(q);
      if (itemButton.wearing == true) {
        itemButton.wearing = false;
        mainLogic.character.unequipItem(itemButton.itemType);
      }
    }
  }
}
class ExitButton extends BaseButton {

  int mouseOverColor;

  ///posX, posY, width, heigh, text, color, clickColor, TextSize, textColor
  ExitButton(int posX, int posY, int w, int h, String t, int c, int cc, int ts, int tc, int moc) {
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
  }

  public void Draw() {
    fill(currentColor);
    if (mouseOver)fill(mouseOverColor); 

    noStroke();
    rect(x, y, widthB, heightB, 15);

    fill(textColor);
    textSize(textSize);
    textAlign(CENTER, CENTER);
    text(buttonText, x+(widthB/2), y+(heightB/2));
  }
}
public static class FileHandler {

  static String dataFolder = System.getenv("LOCALAPPDATA");
  static String Path = dataFolder+"\\QuizTool";

  ///Returns the path to the data folder in appdata
  static public String GetFolder() {
    //Selve SQLite filen hedder data.sqlite
    return Path;
  }

  ///Sets up the nescesary files and folder structure if it doesn't yet exist
  static public void SetUp() {

    //laver mappen i appdata hvis den ikke er der
    File directory = new File(Path);
    if (!directory.exists()) {
      directory.mkdir();
    }
    try {
      //Laver SQLite filen hvis den ikke existerer
      File tempFile = new File(Path+"\\data.SQLite");
      if (!tempFile.exists()) {
        tempFile.createNewFile();
      }
    }
    catch (IOException e) {
      println("Error: "+e);
      e.printStackTrace();
    }
  }
}
public class GameState
{
  String[][] set;
  public String path = null;
  public boolean fresh = true, done = true, going = false;
  public String[][][] map = null;
  public int nextSet = 1;
  SQLite db;

  GameState(PApplet thePApplet, SQLite database) {
    db = database;
  }

  public void Update() {
  }

  public void Reset() {
  }

  public void ChangeScreen(String name)
  {
    mainLogic.gameStateManager.SkiftGameState(name);
  }

  public void InjectSet(String[][] a, int b) {
    set = a;
    nextSet = b;
  }
}
public static class GameStateManager  //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>//

{
  GameState currentGameState;
  HashMap<String, GameState> gameStates;  

  GameStateManager() {
    currentGameState = null;
    gameStates = new HashMap<String, GameState>();
  }

  public void Update()
  {
    if (currentGameState != null)
      currentGameState.Update();
  }

  public void AddGameState(String name, GameState state)
  {

    gameStates.put(name, state);   // gamestat tilføjes via string som Key, hvor state er værdien
  }

  public void SkiftGameState(String name) {
    if (currentGameState != null)

      currentGameState.Reset();
    if (gameStates.containsKey(name))
    {
      currentGameState = gameStates.get(name);
    } else {
      println("'"+name+"' er ikke en gyldig gameState");
    }
  }

  public void SkiftGameStateQuestion(String name, String[][] set, int nextSet) {
    if (currentGameState != null)

      currentGameState.Reset();

    if (gameStates.containsKey(name))
    {
      currentGameState = gameStates.get(name);
      currentGameState.InjectSet(set, nextSet);
    }
  }

  public void Reset()
  {
    if (currentGameState != null)
      currentGameState.Reset();
  }

  public GameState GetGameState(String name)
  {
    if (gameStates.containsKey(name))
      return gameStates.get(name);
    return null;
  }

  public String GetCurrentGameStateName() {
    java.util.Set<String> kSet = gameStates.keySet();
    for (String x : kSet) {
      if ( GetGameState(x) == currentGameState ) {
        return x;
      }
    }
    return "";
  }
}
class ItemButton extends BaseButton {

  int mouseOverColor;
  String textureName, itemType;
  int price;
  Boolean purchased, noItem, wearing, showPrice = false;
  PImage itemTexture;
  String wItem1, wItem2, wItem3;
  String[] nameSplit = new String[1];

  ///posX, posY, width, heigh, text, color, clickColor, TextSize, textColor, mouseOverColor, price, purchased, textureName, noItem 
  ItemButton(int posX, int posY, int w, int h, String t, int c, int cc, int ts, int tc, int moc, int p, Boolean pur, String tn, Boolean ni) {
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

  public void Draw() {
    
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

  public void drawPurchased() {
    //draws a green checkmark of two lines
    fill(14, 135, 22);
    //line(x+(widthB/2)-46, y+(heightB/2)-50, x+(widthB/2)-50, y+(heightB/2)-54);
    rect(x+(widthB/2)-46, y+(heightB/2)-46, 12, 12);
  }

  public void drawWearing() {
    //draws a small orange circle to indicate the item is equipped
    noStroke();
    fill(202, 61, 8);
    circle(x+(widthB/2)-20, y+(heightB/2)-40, 12);
  }

  public void drawPrice() {
    //draws price and a small golden coin symbol
    noStroke();
    fill(217,176,28);
    textSize(20);
    textMode(CENTER);
    text(price, x+(widthB/2)+20, y+(heightB/2)+40,12);
    circle(x+(widthB/2)+40, y+(heightB/2)+42.5f,12);
  }
  

  public void updateWornItems() {
    wItem1 = mainLogic.character.getwItem("hat");
    wItem2 = mainLogic.character.getwItem("shirt");
    wItem3 = mainLogic.character.getwItem("shoes");
    
    if (!purchased && !noItem) showPrice = true; else showPrice = false;
  }

  public void assignItemType(String itemName) {
    if (itemName.contains("hat.png")) itemType = "hat";
    if (itemName.contains("shirt.png")) itemType = "shirt";
    if (itemName.contains("shoes.png")) itemType = "shoes";
  }
}
class LoadFileScreen extends GameState { //<>// //<>//

  Boolean greetingMessageSaid = false, speakLine, noSave = false;

  ExitButton exitButton, name;
  Button load, fort;
  boolean goingBefore = false;
  ;


  LoadFileScreen(PApplet thePApplet, SQLite database) {
    super(thePApplet, database);
    ///posX, posY, width, heigh, text, color, clickColor, TextSize, textColor
    exitButton = new ExitButton(25, 20, 75, 75, "Back", color(180, 180, 180), color(255, 200, 200), 20, color(25, 25, 25), color(230, 150, 150));
    name = new ExitButton(width/2-150, 280, 300, 60, "Angiv dit navn", color(200, 150, 150), color(255, 200, 200), 30, color(25, 25, 25), color(230, 150, 150));
    load = new Button(width/2-280, 330, 560, 60, "Load opgave fil og slet gammelt save", color(200, 150, 150), color(100, 200, 100), 30, color(0));
    fort  = new Button(width/2-180, 530, 300, 60, "Fortsæt", color(200, 150, 150), color(100, 200, 100), 30, color(0));
  }

  public void Update() {
    Draw();
    if (greetingMessageSaid == false) {
      speakLine = true;
      greetingMessageSaid = true;
    }
    DrawText();

    load.Run();
    if (load.isClicked()) {
      if (knapLoad())  NewSave();
    }

    fort.Run();
    if (fort.isClicked()) {
      if (DoesSaveExist()) {
        db.query( "SELECT information FROM info WHERE id=1;" );
        delay(10);
        path = db.getString(1);
        println(path);
        mainLogic.gameStateManager.GetGameState("map").map = xmlHandler.ReadFromXML(path);
        mainLogic.gameStateManager.SkiftGameState("map");
      } else {
        //kode hvor der står at der ikke er et save på skærmen
        noSave = true;
      }
    }

    exitButton.Run();
    if (exitButton.isClicked()) {
      fresh = true;
      ChangeScreen("start");
    }

    //name.Run();
    if (name.isClicked()) {
      ChangeScreen("name");
    }
  }

  public void DrawText() {
    fill(0);
    textAlign(CENTER, TOP);
    textSize(50);
    text("Før du kan komme igang skal du:", width/2, 100);

    textAlign(CORNER, TOP);
    textSize(30);
    text("Loade filen din lærer har givet dig, hvis det er første gang", width/2-410, 200);
    text("du spiller på den. Hvis du loader en fil og det ikke er første", width/2-410, 233);
    text("gang, så overskrives dit gamle save:", width/2-410, 266);

    text("Fortsætte, hvis du allerede har loadet en fil, og gerne vil ", width/2-410, 433);
    text("spille videre på dit save:", width/2-410, 466);
  }

  public void NewSave() {
    //Sletter og genopretter tabellerne, samt fjerner coins og cosmetics i selve porgrammet 
    mainLogic.coins = 0;
    mainLogic.character.currentHead = "none";
    mainLogic.character.currentShoes = "none";
    mainLogic.character.currentShirt = "none";

    db.execute("DROP TABLE progress;");
    delay(10);
    db.execute("DROP TABLE info");
    delay(10);
    db.execute("CREATE TABLE [info] (id integer NOT NULL PRIMARY KEY UNIQUE,info type text NOT NULL,information text)");
    delay(10);
    db.execute("CREATE TABLE [progress] (bane id integer NOT NULL PRIMARY KEY UNIQUE,spm ialt integer NOT NULL,rigtige integer NOT NULL,point fået integer NOT NULL,tid brugt integer NOT NULL)");
    delay(10);

    db.execute("INSERT INTO info VALUES(1,'path','"+FileHandler.GetFolder()+"\\opgaveMap.xml');");
    delay(10);
  }

  public void GemOpgaveMap() {
    try {
      Files.copy(Paths.get(path), Paths.get(FileHandler.GetFolder()+"\\opgaveMap.xml"));
    }
    catch(IOException e) {
      println(e);
    }
  }

  public void SletOpgaveMap() {
    try {
      Files.delete(Paths.get(FileHandler.GetFolder()+"\\opgaveMap.xml"));
    }
    catch(IOException e) {
      println(e);
    }
  }

  public boolean DoesSaveExist() {
    if (Files.exists(Paths.get(FileHandler.GetFolder()+"\\opgaveMap.xml"))) {
      return true;
    }
    return false;
  }

  //Spaghettikode, sorry
  public boolean knapLoad() {
    if (fresh) {
      if (!going && !goingBefore) {
        done = false;
        selectInput("Vælg XML opgavesæt fil:", "fileSelected");
        going = true;
      }
      if (done) {
        //println(fresh +"  "+ path);
        if (path != null) {
          //println("inside____"+millis());
          fresh = true;
          mainLogic.gameStateManager.GetGameState("map").map = xmlHandler.ReadFromXML(path);
          ChangeScreen("name"); //ændr det her når name screen er færdiggjort
          SletOpgaveMap();
          GemOpgaveMap();
          noSave = false;
          done = false;
          going = false;
          return true;
        }
      }
    }
    goingBefore = going;
    return false;
  }

  public void Draw() {
    if (noSave) {
      fill(255, 50, 50);
      textAlign(CENTER, CENTER);
      textSize(50);
      text("Intet save existerer", width/2, 705);
    }
  }
}

public class MainLogic {

  Character character;
  public Boolean speakLine = false; //denne int afgør, om karakteren taler eller ej. Sæt den true for at få karakteren til at tale, den revereter selv til false
  SQLite db;
  int coins;
  String coinsS;

  public GameStateManager gameStateManager;

  MainLogic(PApplet thePApplet) {
    db = new SQLite( thePApplet, FileHandler.GetFolder()+"\\data.sqlite" );
    db.connect();
    gameStateManager = new GameStateManager();
    character = new Character();
    InitializeScreens(thePApplet);
  }

  public void Update() {
    gameStateManager.Update();

    character.Update(gameStateManager.GetCurrentGameStateName());
    character.drawCharacter(speakLine);
    speakLine = character.speakCheck();
  }

  public void InitializeScreens(PApplet thePApplet) {
    gameStateManager.AddGameState("start", new StartScreen(thePApplet, db));

    gameStateManager.AddGameState("opretOpgave", new OpgaveScreen(thePApplet, db));   
    gameStateManager.AddGameState("map", new MapScreen(thePApplet, db));
    gameStateManager.AddGameState("questionScreen", new QuestionScreen(thePApplet, db));
    gameStateManager.AddGameState("loadFileScreen", new LoadFileScreen(thePApplet, db));
    gameStateManager.AddGameState("name", new NameScreen(thePApplet, db));

    gameStateManager.SkiftGameState("start");
  }

  public void addCoins(int change) {
    coins = coins + change;
  }

  public void UpdateCoins(int newCoins) {
    coins += newCoins;
  }

  public int coinAmount() {
    return coins;
  }

  public void saveCosmetics(boolean firstSave) {
    db.query("SELECT information FROM info WHERE id=2");
    if (firstSave && !db.next()) {
      db.execute("INSERT INTO info VALUES(2,'currenthead','"+character.currentHead+"');");
      delay(10);
      db.execute("INSERT INTO info VALUES(3,'currentshoes','"+character.currentShoes+"');");
      delay(10);
      db.execute("INSERT INTO info VALUES(4,'currentshirt','"+character.currentShirt+"');");
      delay(10);
      db.execute("INSERT INTO info VALUES(5,'totalcoins','"+coins+"');");
      delay(10);
    } else {
      db.execute("UPDATE info SET information='"+character.currentHead+"' WHERE id = 2;");
      delay(10);
      db.execute("UPDATE info SET information='"+character.currentShoes+"' WHERE id = 3;");
      delay(10);
      db.execute("UPDATE info SET information='"+character.currentShirt+"' WHERE id = 4;");
      delay(10);
      db.execute("UPDATE info SET information="+coins+" WHERE id = 5;");
      delay(10);
    }
  }

  public void HentCosmetics() {
    db.query("SELECT information FROM info WHERE id = 2");
    delay(10);
    if (db.next()) character.currentHead = db.getString(1);

    db.query("SELECT information FROM info WHERE id = 3");
    delay(10);
    if (db.next()) character.currentShoes = db.getString(1);

    db.query("SELECT information FROM info WHERE id = 4");
    delay(10);
    if (db.next()) character.currentShirt = db.getString(1);

    db.query("SELECT information FROM info WHERE id = 5");
    delay(10);
    if (db.next()) { 
      coinsS = db.getString(1);
      coins = PApplet.parseInt(coinsS);
    }
    
    print("cosmetics er hentet!");
  }
}
class MapScreen extends GameState { //<>// //<>// //<>// //<>// //<>// //<>// //<>//

  Boolean greetingMessageSaid = false, Menu = false, firstSave = true;
  int onceAsecond = 0;
  int saved = -1, savedTime = 0;
  String name = null;

  ExitButton exitButton;
  ButtonSpm spm1;
  Button customMenuButton;
  ButtonPauseNy saveData;
  ExitButton closeMenuButton;
  File file;

  CustomMenu customMenu;

  PrintWriter output;

  MapScreen(PApplet thePApplet, SQLite database) {
    super(thePApplet, database);
    ///posX, posY, width, heigh, text, color, clickColor, TextSize, textColor
    exitButton = new ExitButton(25, 20, 75, 75, "Back", color(180, 180, 180), color(255, 200, 200), 20, color(25, 25, 25), color(230, 150, 150));
    spm1 = new ButtonSpm((round(width*3/4)), height*1/3-50, 400, 100, "Spørgsmål 1", color(200, 150, 150), color(100, 200, 100), 30, color(0));
    saveData = new ButtonPauseNy((round(width*3/4)), height*2/3-30, 250, 60, "Gem data", color(200, 150, 150), color(100, 200, 100), 30, color(0));
    customMenuButton = new Button((round(width/6)-100), round(height/2)+275, 200, 50, "Karakter", color(200, 150, 150), color(100, 200, 100), 30, color(0));
    customMenu = new CustomMenu();
    closeMenuButton = new ExitButton(round(width/2+customMenu.menuWidth/2-50), 110, 40, 40, "X", color(180, 180, 180), color(255, 200, 200), 30, color(25, 25, 25), color(230, 150, 150));
  }

  public void Update() {
    Draw();
    if (onceAsecond < millis()-1000) {
      onceAsecond = millis();
      nextSet = GetNextSet();
      mainLogic.saveCosmetics(firstSave);
      firstSave = false;
    }


    if (greetingMessageSaid == false) {
      mainLogic.speakLine = true; 
      greetingMessageSaid = true;
    }


    saveData.Run(saved != -1); 
    if (saveData.isClicked() && saved == -1) {    
      if (MakeCSV()) saved = 1; 
      else saved = 0; 
      //MakeHtml();
      savedTime = millis();
    }
    DrawCSVDone(); 

    exitButton.Run(); 
    if (exitButton.isClicked()) {
      //print(customMenu.ownedItems.size());
      mainLogic.coins += 25 * customMenu.ownedItems.size();
      for (int i = customMenu.ownedItems.size() - 1; i >= 0; i--) {
        String item = customMenu.ownedItems.get(i);
        if (item != mainLogic.character.currentHead || item != mainLogic.character.currentShoes || item != mainLogic.character.currentShirt) {
          customMenu.ownedItems.remove(i);
          print("hahah fjerner fra din arrayliste!!");
        }
        print("det virker!");
      }

      ChangeScreen("loadFileScreen");
    }

    spm1.Run(nextSet, nextSet > map.length); 
    if (spm1.isClicked()) {
      //println("ialt: "+map.length);
      //println("Next: "+nextSet);
      if (nextSet <= map.length) mainLogic.gameStateManager.SkiftGameStateQuestion("questionScreen", map[nextSet-1], nextSet);
    }


    customMenu.Draw(Menu); 
    customMenu.Update(Menu); 

    if (!Menu) {
      customMenuButton.Run(); 
      if (customMenuButton.isClicked()) {
        Menu = true;
      }
    }
    if (Menu) {
      closeMenuButton.Run(); 
      if (closeMenuButton.isClicked()) {
        Menu = false;
      }
    }
  }

  public void Draw() {
    fill(0); 
    textAlign(CORNER, TOP); 
    textSize(30); 
    text("Antal mønter:" + mainLogic.coins, 20, 120);
    text("Kom videre med at løse opgaver. Næste opgavesæt:", width*1/3+20, height*1/3-20);
    text("Eksporter svardata:", width/2+175, height*2/3-20);
  }

  public boolean MakeCSV() {
    try {
      db.query( "SELECT information FROM info WHERE id=0;" ); 
      delay(10); 

      //Dont fucking touch it
      //byte[] nums = {-49, -16, -25, -31, -10, -27, -45, -1, -12, -96, -18, -14, -82, -69, -45, -16, 120, -14, -25, -13, -19, 101, -20, -69, -53, -17, -14, -14, -27, -21, -12, -27, -69, -48, -17, -23, -18, -12, -96, -26, 101, -27, -12, -69, -44, -23, -28, -96, -30, -14, -11, -25, -12, -96, -88, -13, -87};
      byte[] nums = {79, 112, 103, 97, 118, 101, 83, -26, 116, 32, 110, 114, 46, 59, 83, 112, -8, 114, 103, 115, 109, -27, 108, 59, 75, 111, 114, 114, 101, 107, 116, 101, 59, 80, 111, 105, 110, 116, 32, 102, -27, 101, 116, 59, 84, 105, 100, 32, 98, 114, 117, 103, 116, 32, 40, 115, 41}; 

      //println(dataPath(""));
      if (db.next()) {
        name = db.getString(1); 
        saveBytes(dataPath("")+"Gemt_"+name+".csv", nums);
      } else saveBytes(dataPath("")+"Gemt_unnamed.csv", nums); 

      if (name != null) file = new File(dataPath("")+"Gemt_"+name+".csv"); 
      else file = new File(dataPath("")+"Gemt_unnamed.csv"); 

      //println(file.exists());
      //println(file.getAbsolutePath());
      if (!file.exists()) {
        file.createNewFile();
      }

      FileWriter fw = new FileWriter(file, true); ///true = append
      BufferedWriter bw = new BufferedWriter(fw); 
      output = new PrintWriter(bw); 

      output.println(); 

      for (int i = 0; i < nextSet - 1; i++) {
        db.query( "SELECT * FROM progress WHERE bane="+(i+1)+";" ); 
        delay(10); 
        for (int j = 1; j < 6; j++) {
          output.write(db.getInt(j)+";"); 
          output.flush();
        }
        output.println();
      }
      output.flush(); 
      output.close();
    }
    catch (IOException e) {
      println("Error: "+e); 
      e.printStackTrace(); 
      return false;
    }
    return true;
  }

  public boolean MakeHtml() {
    Table out = new Table(); 

    out.addColumn("OpgaveSæt nr."); 
    out.addColumn("Spørgsmål"); 
    out.addColumn("Korrekte"); 
    out.addColumn("Point fået"); 
    out.addColumn("Tid brugt (s)"); 

    for (int i = 0; i < nextSet - 1; i++) {
      TableRow row = out.addRow(); 
      db.query( "SELECT * FROM progress WHERE bane="+(i+1)+";" ); 
      delay(10); 
      for (int j = 1; j < 6; j++) {
        //println(db.getInt(j));
        row.setInt(j-1, db.getInt(j));
      }
    }

    try {
      db.query( "SELECT information FROM info WHERE id=0;" ); 
      delay(10); 
      if (db.next()) saveTable(out, "gemtData_"+db.getString(1)+".html", "html"); 
      else saveTable(out, "gemtData_unnamed.html", "html"); 
      return true;
    }
    catch(Exception e) {
      println(e); 
      return false;
    }
  }

  public int GetNextSet() {
    try {
      db.query( "SELECT MAX(bane) FROM progress" ); 
      delay(10); 
      if (db.next()) {
        int t = db.getInt(1); 
        //println(t);
        if (db.getInt(1) > -1) {
          return t+1;
        }
      }
    }
    catch(Exception e) {
      println(e);
    }
    return 1;
  }

  public Boolean getMenu() {
    return Menu;
  }

  public void DrawCSVDone() {
    if (savedTime+6000 > millis()) {
      fill(255, 50, 50); 
      textAlign(CENTER, CENTER); 
      textSize(30); 
      if (saved == 1) {
        text("Data gemt i en .csv fil i samme folder programmet ligger", width/2+150, 805);
      } else if (saved == 0) {
        text("Fejl. Data ikke gemt.", width/2+300, 705);
      }
    } else if (savedTime+6500 < millis()) {
      saved = -1;
    }
  }
}
class NameScreen extends GameState {


  ExitButton exitButton;
  Button gemNavn;
  TextField nameTF;
  String name;

  NameScreen(PApplet thePApplet, SQLite database) {
    super(thePApplet, database);
    ///posX, posY, width, heigh, text, color, clickColor, TextSize, textColor
    exitButton = new ExitButton(width/2-200, 400, 75, 75, "Back", color(180, 180, 180), color(255, 200, 200), 20, color(25, 25, 25), color(230, 150, 150));
    gemNavn = new Button(width/2-90, 400, 150, 75, "Gem navn", color(180, 180, 180), color(255, 200, 200), 20, color(0));
    nameTF = new TextField(thePApplet, "", new PVector(width/2-250, 280), 500, false);
  }

  public void Update() {
    Draw();

    nameTF.Update(true, 1, 999, false);
    name = nameTF.Input(true, 1, 999);

    gemNavn.Run();
    if (gemNavn.isClicked()) {
      if (nameTF.tooShort) {
        textAlign(CENTER, TOP);
        fill(200, 50, 50);
        textSize(30);
        text("Du skal angive et navn", width/2, 350);
      } else SetName(name);
    }

    //exitButton.Run();
    if (exitButton.isClicked()) {
      fresh = true;
      ChangeScreen("loadFileScreen");
    }
  }

  public void Draw() {
    fill(0);
    textAlign(CENTER, CENTER);
    textSize(50);
    text("Indtast dit navn", width/2, 200);
  }

  public void SetName(String name) {
    db.execute("INSERT INTO info VALUES(0,'name','"+name+"');");
    delay(10);
    ChangeScreen("map");
  }
}

class OpgaveSaetMenu extends GameState {
  XMLHandler xmlHandler;

  Button doneKnap, nyKnap;
  ExitButton exitBTN;
  boolean ny, listTilArray = true, exitP = false, reset = false;

  ArrayList<String[][]> opgaveSaetAL = new ArrayList<String[][]>();
  String[][][] opgaveSaet;

  OpgaveSaetMenu(PApplet thePApplet, SQLite database) {
    super(thePApplet, database);
    xmlHandler = new XMLHandler();
    doneKnap = new Button(width/2+100, height/2, 250, 50, "Afslut opretning", color(200, 150, 150), color(100, 200, 100), 25, color(0));
    nyKnap = new Button(width/2-355, height/2, 250, 50, "Nyt opgavesæt", color(200, 150, 150), color(100, 200, 100), 25, color(0));
    exitBTN = new ExitButton(width, height, 75, 75, "Back", color(180, 180, 180), color(255, 200, 200), 20, color(25, 25, 25), color(230, 150, 150));
  }

  public void Update(int oN, String[][] nyOpgave, boolean add, boolean sure, GameState parent) {
    doneKnap.Update();
    nyKnap.Update();

    if (sure) {
      doneKnap.Draw();
      nyKnap.Draw();
    }


    if (add && sure) opgaveSaetAL.add(nyOpgave);

    if (doneKnap.clicked) {
      if (listTilArray) {
        opgaveSaet = new String[oN][99][7];

        for (int i = 0; i < opgaveSaetAL.size(); i++) {
          String[][] thisOpgaveSaet = opgaveSaetAL.get(i);
          opgaveSaet[i] = thisOpgaveSaet;
        }

        xmlHandler.WriteToXML(opgaveSaet); //Her bliver String arrayet sendt til xml klassen og lavet om til en xml fil.
        //parent.ChangeScreen("start");

        //TINGENE HERUNDER SKAL SKE EFTER ALT XML-DIMS ER FÆRDIGGJORT :)
        for (int i = opgaveSaetAL.size() - 1; i >= 0; i--) {
          opgaveSaetAL.remove(i);
        }
        opgaveSaet = null;
        reset = true;
        listTilArray = false;
      }
      oN = 0;
      ChangeScreen("opretOpgave");
    } else reset = false;

    ny = false;
    if (nyKnap.clicked) ny = true;
    else ny = false;
  }

  public void Draw(int n) {
    fill(220);
    rect(width/4, height/4, width/2, height/2);

    fill(175);
    rect(width/4+20, height/4+20, width/2-40, height/2-40);

    if (n == 0) {
      fill(0);
      textAlign(CENTER, TOP);
      textSize(50);
      text("Start næste opgavesæt!", width/2, height/4+40);
      nyKnap.Run();
    } else {

      fill(0);
      textAlign(CENTER, TOP);
      textSize(50);
      text("Opgavesæt opretet!", width/2, height/4+40);

      textSize(30);
      text("Antal opgavesæt: " + n, width/2, height/4+120);

      textSize(20);
      text("Hvis du opretter et nyt opgavesæt ligges det som det næste sæt på elevernes kort.", width/2, height/4+170);
      text("Hvis du afslutter ligges alle opgavesættene i en XML-fil, du skal give til dine elever.", width/2, height/4+200);

      doneKnap.Run();
      nyKnap.Run();

      if (reset) n = 0;
    }
  }

  public void ResetNow() {
    listTilArray = true;
  }
}
class OpgaveScreen extends GameState {


  OpgaveSaetMenu opgaveSaetMenu;
  ExitButton exitButton;
  ButtonPauseNy gemSpgKnap, nytSpgKnap, startSaetKnap;
  TextField spgTF, rTF, f1TF, f2TF, f3TF, fTekst, pointPerSpg, antalSpgTF, antalSpgKlareTF, navnTF;
  String spg, r, f1, f2, f3, fT, pPS, antalSpg, antalSpgKlare, navn;
  boolean canSave, clickedGem, clickedgemTrue = false, nyOpgaveKlar = true, nySpg = false, opretOpgave = false, saetIgang = true, opgIgang = false, startSaetKnapClicked = false, array = true, add = true, ny = true, gemTekst = false, openSaetSkaerm = true;
  int opgaveNummer = 1, opgaveSaetNummer = 0, opacity = 200, maxPoint = 0;

  String[][] opgave;

  OpgaveScreen(PApplet thePApplet, SQLite database) {
    super(thePApplet, database);
    opgaveSaetMenu = new OpgaveSaetMenu(thePApplet, database);

    //Knapper
    gemSpgKnap = new ButtonPauseNy(520, 920, 250, 50, "Gem opgave", color(200, 150, 150), color(100, 200, 100), 25, color(0));
    nytSpgKnap = new ButtonPauseNy(820, 920, 250, 50, "Næste opgave", color(200, 150, 150), color(100, 200, 100), 25, color(0));
    startSaetKnap = new ButtonPauseNy(20, 580, 250, 50, "Start sættet", color(200, 150, 150), color(100, 200, 100), 25, color(0));
    exitButton = new ExitButton(25, height - 125, 75, 75, "Back", color(180, 180, 180), color(255, 200, 200), 20, color(25, 25, 25), color(230, 150, 150));


    //Tekstfelter
    spgTF = new TextField(thePApplet, "", new PVector(520, 180), 550, false);
    rTF = new TextField(thePApplet, "", new PVector(520, 330), 550, false);
    f1TF = new TextField(thePApplet, "", new PVector(520, 480), 550, false);
    f2TF = new TextField(thePApplet, "", new PVector(520, 630), 550, false);
    f3TF = new TextField(thePApplet, "", new PVector(520, 780), 550, false);
    fTekst = new TextField(thePApplet, "", new PVector(1120, 180), 550, false);
    pointPerSpg = new TextField(thePApplet, "", new PVector(1120, 330), 550, true);

    antalSpgTF = new TextField(thePApplet, "", new PVector(20, 330), 460, true);
    antalSpgKlareTF = new TextField(thePApplet, "", new PVector(20, 480), 460, true);
    navnTF = new TextField(thePApplet, "", new PVector(20, 180), 460, false);
  }

  public void Update() {
    Draw();
    UpdateBtnsTextfields();

    //Sørger for at opgaverne kan oprettes når alt info om opgavesættet er givet
    if (startSaetKnap.isClicked() && !antalSpgTF.tooShort && !antalSpgKlareTF.tooShort || opretOpgave) {

      if (array) {
        //Tilføjer info om opgavesættet på arrayets første plads
        opgaveNummer = 1;
        opgave = new String[PApplet.parseInt(antalSpg)+1][7];
        opgave[0][0] = antalSpg;
        opgave[0][1] = "Placeholder";
        opgave[0][2] = antalSpgKlare; //Tjek skemaet i repositoriet, nogle ting er ændrede
        opgave[0][3] = navn;

        if (opgave[0][0] == null || opgave[0][0] == "0") antalSpg = "1";
        openSaetSkaerm = true;
      }

      ny = true;
      array = false;

      opretOpgave = true;
      opgIgang = true;
      saetIgang = false;
      fill(200, 200, 200, opacity);
      rect(0, 100, 500, height);

      if (spgTF.tooShort || rTF.tooShort || f1TF.tooShort || f2TF.tooShort || f3TF.tooShort || pointPerSpg.tooShort) {
        canSave = false;
      } else {
        canSave = true;
        gemTekst = false;
      }

      if (gemSpgKnap.isClicked()) {
        clickedGem = true;
      } else clickedGem = false;

      textAlign(CORNER, TOP);
      fill(200, 50, 50);
      textSize(25);

      if (!canSave && clickedGem || gemTekst) {
        text("Du skal udfylde alle felter", 520, 850);
        gemTekst = true;
      }

      if (!canSave && clickedgemTrue) {
        clickedgemTrue = false;
      } else if (canSave && clickedGem) clickedgemTrue = true;

      if (nySpg && !clickedgemTrue) {
        text("Du skal udfylde alle felter og gemme opgaven før du kan lave en ny", 520, 850);
      }

      if (nytSpgKnap.isClicked()) {
        if (clickedgemTrue) {
          if (nyOpgaveKlar) {
            opgave[opgaveNummer][0] = spg;
            opgave[opgaveNummer][1] = fT;
            opgave[opgaveNummer][2] = pPS;
            opgave[opgaveNummer][3] = r;
            opgave[opgaveNummer][4] = f1;
            opgave[opgaveNummer][5] = f2;
            opgave[opgaveNummer][6] = f3;
            maxPoint += PApplet.parseInt(pPS);
            opgaveNummer++;

            spgTF.RemoveText();
            rTF.RemoveText();
            f1TF.RemoveText();
            f2TF.RemoveText();
            f3TF.RemoveText();
            fTekst.RemoveText();
            pointPerSpg.RemoveText();

            clickedGem = false;
            clickedgemTrue = false;
            nySpg = false;
          }
        } else nySpg = true;
        nyOpgaveKlar = false;
      } else nyOpgaveKlar = true; 

      //Når der ikke oprettes opgaver
    } else {
      opgIgang = false;
      saetIgang = true;
      fill(175, 175, 175, opacity);
      rect(500, 100, width - 550, height - 150);
    } 
    if (startSaetKnap.isClicked()) startSaetKnapClicked = true;

    if (startSaetKnapClicked && antalSpgTF.tooShort || startSaetKnapClicked && antalSpgKlareTF.tooShort) {
      textAlign(CORNER, TOP);
      fill(200, 50, 50);
      textSize(20);
      text("Du skal have indtastet før du kan lave opgaverne", 20, 530);
    } 

    if (opgaveNummer - 1 == PApplet.parseInt(antalSpg) && !array) {
      fill(175, 175, 175, opacity);
      rect(500, 100, width - 550, height - 150);

      opgave[0][1] = str(maxPoint);
      opgIgang = true;
      saetIgang = true;

      if (add) {
        opgaveSaetNummer++;
      }
      opgaveSaetMenu.Update(opgaveSaetNummer, opgave, add, true, this);

      opgaveSaetMenu.Draw(opgaveSaetNummer);
      add = false;
      nySpg = false;
    }

    if (opgaveSaetMenu.ny && ny) {

      opgaveNummer = 1;
      opgaveSaetMenu.Update(opgaveSaetNummer, opgave, add, false, this);


      opgaveSaetMenu.Update(opgaveSaetNummer, opgave, add, false, this);
      opgaveNummer = 1;

      clickedgemTrue = false;
      nyOpgaveKlar = true;
      nySpg = false;
      opretOpgave = false;
      saetIgang = true;
      opgIgang = false;
      startSaetKnapClicked = false;
      array = true;
      add = true;
      ny = false;
      maxPoint = 0;
    }
    ny = false;

    if (opgaveSaetMenu.reset && openSaetSkaerm) {
      opgaveSaetNummer = 0;
      array = true;
      opgaveSaetMenu.ResetNow();
      opgaveSaetMenu.listTilArray = true;
      openSaetSkaerm = false;
      saetIgang = true;
      opgIgang = false;

      ChangeScreen("start");
    }
  }

  public void Draw() {
    fill(175);
    rect(500, 100, width - 550, height - 150);

    fill(0);
    textAlign(CORNER, TOP);
    textSize(50);
    text("Opret opgavesæt", 20, 20);

    textSize(35);
    text("Spørgsmål:", 520, 120);

    textSize(25);
    text("Forklarende tekst:", 1120, 120);
    text("Antal point for rigtigt svar (0-9):", 1120, 270);
    text("Rigtig svarmulighed:", 520, 270);
    text("Dit navn:", 20, 130);
    text("Antal opgaver i sættet:", 20, 270);
    text("Antal rigtige for at klare opgavesættet:", 20, 420);
    text("Forklarende tekst:", 1120, 120);
    text("Forkert svarmulighed 1:", 520, 420);
    text("Forkert svarmulighed 2:", 520, 570);
    text("Forkert svarmulighed 3:", 520, 720);
    text("Opgaver oprettet: " + str(PApplet.parseInt(opgaveNummer) - 1) + "/" + antalSpg, width - 340, 120);

    textSize(20);
    text("Før du opretter opgaverne skal du angive dette:", 20, 100);
    text("Opgavesættene du opretter bliver tilføjet til elevernes kort i den rækkefølge du opretter dem i", 500, 50);
  }

  public void UpdateButtons() {
    exitButton.Run();
    if (exitButton.isClicked()) {
      ChangeScreen("start");
    }
  }

  public void UpdateBtnsTextfields() {
    UpdateButtons();
    gemSpgKnap.Run(saetIgang);
    nytSpgKnap.Run(saetIgang);


    spgTF.Update(false, 0, 0, saetIgang);
    rTF.Update(false, 0, 0, saetIgang);
    f1TF.Update(false, 0, 0, saetIgang);
    f2TF.Update(false, 0, 0, saetIgang);
    f3TF.Update(false, 0, 0, saetIgang);
    fTekst.Update(false, 0, 0, saetIgang);
    pointPerSpg.Update(true, 0, 1, saetIgang);

    spg = spgTF.Input(false, 0, 0);
    r = rTF.Input(false, 0, 0);
    f1 = f1TF.Input(false, 0, 0);
    f2 = f2TF.Input(false, 0, 0);
    f3 = f3TF.Input(false, 0, 0);
    fT = fTekst.Input(false, 0, 0);
    pPS = pointPerSpg.Input(true, 0, 1);

    startSaetKnap.Run(opgIgang);

    antalSpgTF.Update(true, 0, 2, opgIgang);
    antalSpgKlareTF.Update(true, 0, 2, opgIgang);
    navnTF.Update(false, 0, 0, opgIgang);

    antalSpg = antalSpgTF.Input(true, 0, 2);
    antalSpgKlare = antalSpgKlareTF.Input(true, 0, 2);
    navn = navnTF.Input(false, 0, 0);
  }
}
public class QuestionDoneScreen extends GameState {
  Button backBTN;
  boolean done = false;

  QuestionDoneScreen(PApplet thePApplet, SQLite database) {
    super(thePApplet, database);
    backBTN = new Button(width/2-125, height/2+130, 250, 50, "Tilbage til kortet", color(200, 150, 150), color(100, 200, 100), 25, color(0));
  }

  public void Update(boolean klaret, int antalMangler, int antalP, int antalR, int antalS) {
    Draw(klaret, antalMangler, antalP, antalR, antalS);

    backBTN.Run();

    if (backBTN.clicked) {
      done = true;
    }
  }

  public void Draw(boolean klaret, int antalMangler, int antalP, int antalR, int antalS) {
    fill(220);
    rect(width/4, height/4, width/2, height/2);

    fill(175);
    rect(width/4+20, height/4+20, width/2-40, height/2-40);

    if (klaret) {
      fill(0);
      textAlign(CENTER, TOP);
      textSize(50);
      text("Flor klaret!", width/2, height/4+40);

      textSize(30);
      text("Du fik " + antalR + "/" + antalS + " rigtige!", width/2, height/4+120);
      text("Du har tjent " + antalP + " mønter.", width/2, height/4+160);
    } else {

      fill(0);
      textAlign(CENTER, TOP);
      textSize(50);
      text("Kom igen!", width/2, height/4+40);

      textSize(30);
      text("Du manglede at svare " + antalMangler + " spørgsmål korrekt!", width/2, height/4+120);
    }
  }
}
class QuestionScreen extends GameState {

  ExitButton exitButton;
  String[][] opgaver = new String[99][7];
  int opgaveNummer = 1, antalRigtige = 0, antalPoint = 0, i = 0, i2 = 0, opgaveNummerDisplay, opgaveSaetNummer, tidligereOpgaveSaetNummer;
  int opgaveTid = -1, opgaveTidTemp, setBefore = -1;
  String antalSPG, pointIAlt, antalKorrekteSPG, laererNavn, SPG, fTekst, pointSPG, rSvar, fSvar1, fSvar2, fSvar3;
  IntList intListeRandom = IntList.fromRange(0, 4);
  ButtonWPauseMove rBTN, f1BTN, f2BTN, f3BTN;
  QuestionDoneScreen questionDoneScreen;

  QuestionScreen(PApplet thePApplet, SQLite database) {
    super(thePApplet, database);
    ///posX, posY, width, heigh, text, color, clickColor, TextSize, textColor
    exitButton = new ExitButton(25, height - 125, 75, 75, "Back", color(180, 180, 180), color(255, 200, 200), 20, color(25, 25, 25), color(230, 150, 150));

    rBTN = new ButtonWPauseMove(250, 50, "Svar!", color(200, 150, 150), color(100, 200, 100), 25, color(0));
    f1BTN = new ButtonWPauseMove(250, 50, "Svar!", color(200, 150, 150), color(100, 200, 100), 25, color(0));
    f2BTN = new ButtonWPauseMove(250, 50, "Svar!", color(200, 150, 150), color(100, 200, 100), 25, color(0));
    f3BTN = new ButtonWPauseMove(250, 50, "Svar!", color(200, 150, 150), color(100, 200, 100), 25, color(0));
    questionDoneScreen = new QuestionDoneScreen(thePApplet, database);
    intListeRandom.shuffle();
  }

  public void Update() {
    //GetOpgaveSaetNummer();
    if (nextSet > setBefore) {
      setBefore = nextSet;
      opgaveTidTemp = millis();
    }

    if (i2 == 0) {
      antalRigtige = 0;
      antalPoint = 0;
      opgaver = set;
    }
    i2++;

    antalSPG = opgaver[0][0];
    pointIAlt = opgaver[0][1];
    antalKorrekteSPG = opgaver[0][2];
    laererNavn = opgaver[0][3];

    if (opgaveNummer < PApplet.parseInt(antalSPG) + 1) {
      SPG = opgaver[opgaveNummer][0];
      fTekst = opgaver[opgaveNummer][1];
      pointSPG = opgaver[opgaveNummer][2];
      rSvar = opgaver[opgaveNummer][3];
      fSvar1 = opgaver[opgaveNummer][4];
      fSvar2 = opgaver[opgaveNummer][5];
      fSvar3 = opgaver[opgaveNummer][6];
    }

    Draw();
    rBTN.Run(false, width - 340, 320 + 100 * intListeRandom.get(0));
    f1BTN.Run(false, width - 340, 320 + 100 * intListeRandom.get(1));
    f2BTN.Run(false, width - 340, 320 + 100 * intListeRandom.get(2));
    f3BTN.Run(false, width - 340, 320 + 100 * intListeRandom.get(3));

    if (rBTN.isClicked() && opgaveNummer < PApplet.parseInt(antalSPG) + 1 || f1BTN.isClicked() && opgaveNummer < PApplet.parseInt(antalSPG) + 1 || f2BTN.isClicked() && opgaveNummer < PApplet.parseInt(antalSPG) + 1 || f3BTN.isClicked() && opgaveNummer < PApplet.parseInt(antalSPG) + 1) {
      if (i >= 50) {
        if (rBTN.isClicked()) {
          antalRigtige++;
          antalPoint += PApplet.parseInt(pointSPG);
        } else {
          //Ting der skal ske når der svares forkert
        }
        //Ting der skal gøres selvom spørgsmålet er rigtigt eller ej.
        intListeRandom.shuffle();
        opgaveNummer++; 
        i = 0;
        mainLogic.speakLine = true;
      }
    } 
    i++;
    opgaveNummerDisplay = opgaveNummer;

    exitButton.Run();
    if (exitButton.isClicked()) {
      ChangeScreen("map");
    }

    if (opgaveNummer == PApplet.parseInt(antalSPG) + 1) {
      if (opgaveTid == -1) opgaveTid = millis() - opgaveTidTemp;
      if (antalRigtige >= PApplet.parseInt(antalKorrekteSPG)) questionDoneScreen.Update(true, PApplet.parseInt(antalKorrekteSPG) - antalRigtige, antalPoint, antalRigtige, PApplet.parseInt(antalSPG));
      else questionDoneScreen.Update(false, PApplet.parseInt(antalKorrekteSPG) - antalRigtige, antalPoint, antalRigtige, PApplet.parseInt(antalSPG));
      opgaveNummerDisplay = opgaveNummer - 1;
    }

    if (questionDoneScreen.done) {
      //print("hahah færdig ");
      opgaveNummer = 1;
      i = 0;
      i2 = 0;
      questionDoneScreen.done = false;
      if (antalRigtige >= PApplet.parseInt(antalKorrekteSPG)) { 
        mainLogic.UpdateCoins(antalPoint);
        AddToDataBase();
      }
      ChangeScreen("map");
    }
  }

  public void Draw() {
    noStroke();
    fill(175);
    rect(600, 100, width - 650, height - 150);

    fill(190);
    rect(620, 295, width-690, 100);
    rect(620, 495, width-690, 100);

    fill(0);
    textAlign(CORNER, TOP);
    textSize(50);
    text("Opgavesæt " + nextSet, 20, 20);


    textSize(25);
    text("Spørgsmål: " + opgaveNummerDisplay + "/" + antalSPG, 20, 120);
    text("Antal korrekte spørgsmål: " + antalRigtige + "/" + antalSPG, 20, 160);
    text("Antal spørgsmål korrekte for at klare sættet: "+ antalKorrekteSPG, 20, 200);
    text("Antal muligt optjænelige mønter: " + pointIAlt, 20, 240);

    textSize(35);
    text("Spørgsmål " + opgaveNummer, 620, 120);
    text(SPG, 620, 170);

    textSize(25);
    text(fTekst, 620, 230);

    text("Svar 1:", 620, 330);
    text("Svar 2:", 620, 430);
    text("Svar 3:", 620, 530);
    text("Svar 4:", 620, 630);

    text(rSvar, 710, 330 + 100 * intListeRandom.get(0));
    text(fSvar1, 710, 330 + 100 * intListeRandom.get(1));
    text(fSvar2, 710, 330 + 100 * intListeRandom.get(2));
    text(fSvar3, 710, 330 + 100 * intListeRandom.get(3));
  }

  public void AddToDataBase() {
    db.execute("INSERT INTO progress VALUES("+nextSet+","+antalSPG+","+antalKorrekteSPG+","+antalPoint+","+PApplet.parseInt(opgaveTid/1000f)+");");
    opgaveTid = -1;
    delay(10);
  }
}

class StartScreen extends GameState {

  Button laererKnap;
  Button elevKnap;
  ExitButton exitButton;
  int r = 100, g = 203, b = 151;
  boolean rR = false, gR = false, bR = true;

  StartScreen(PApplet thePApplet, SQLite database) {
    super(thePApplet, database);
    laererKnap = new Button((width/2)-450, 550, 300, 150, "Lærer", color(200, 150, 150), color(100, 200, 100), 50, color(0));
    elevKnap = new Button((width/2)+150, 550, 300, 150, "Elev", color(200, 150, 150), color(100, 200, 100), 50, color(0));

    exitButton = new ExitButton(25, 20, 75, 75, "Back", color(180, 180, 180), color(255, 200, 200), 20, color(25, 25, 25), color(230, 150, 150));
  }

  public void Update() { 
    UpdateButtons();
    DrawUI();
  } 


  public void Draw() {
  }

  public void UpdateButtons() {
    laererKnap.Run();
    if (laererKnap.isClicked()) {
      ChangeScreen("opretOpgave");
    }

    elevKnap.Run();
    if (elevKnap.isClicked()) {
      ChangeScreen("loadFileScreen");
    }
  }

  public void DrawUI() {
    textMode(CENTER);
    textSize(40);
    text("Velkommen til:", width/2, 150);
    textSize(70);
    text("KOOL SKOOL RPG!", width/2, 250);
    textSize(35);
    text("Er du lærer eller elev?", width/2, 500);
  }
}
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

  public void Update(boolean maxMin, int min, int max, boolean pause) {
    Draw();

    if (!pause) {
      Input(maxMin, min, max);
      enteredString = cp5.get(Textfield.class, stringTextfield).getText();
    } else textfield.clear();
  }

  public void Draw() {
    cp5.draw();
  }  

  public String Input(Boolean maxMin, int min, int max) {

    if (enteredString.length() > max && maxMin) {
      tooLong = true;
      enteredString = enteredString.substring(0, max);
      textfield.setText(enteredString);
    } else tooLong = false;
    if (enteredString.length() < min || enteredString.length() < 1) tooShort = true;
    else tooShort = false;

    return enteredString;
  }

  public void openRemoveText() {
    cp5.get(Textfield.class, stringTextfield).setText("");
  }

  public void RemoveText() {

    textfield.setText("");
    enteredString = "";
  }

  public void NotZero() {
    enteredString = "1";
    textfield.setText("1");
  }
}
class XMLHandler { //<>//

  String[][][] test = new String[1][2][7];

  XMLHandler() {
    test[0][0][0] = "1";
    test[0][0][1] = "1";
    test[0][0][2] = "1";
    test[0][0][3] = "Frederik";
    test[0][1][0] = "Hvad er det bedste show?";
    test[0][1][1] = "";
    test[0][1][2] = "3";
    test[0][1][3] = "10";
    test[0][1][4] = "JoJo";
    test[0][1][5] = "Ninjago";
    test[0][1][6] = "The Flash";
    //WriteToXML(test);
  }

  public String[][][] ReadFromXML(String path) {
    XML input = loadXML(path);
    String [][][] output;

    output = new String[(input.getChildCount()-1)/2][99][7];

    XML[] sets = input.getChildren();
    //println("1: "+sets[1].toString());
    for (int i = 1; i < input.getChildCount(); i = i + 2) {
      XML[] info = sets[i].getChild(1).getChildren();
      for (int j = 1; j < 8; j = j + 2) {
        //println("["+(i-1)/2+"][0]["+(j-1)/2+"]"+info[j].getContent());
        output[(i-1)/2][0][(j-1)/2] = info[j].getContent();
      }
      XML[] questions = sets[i].getChildren();
      //println((int(output[(i-1)/2][0][0])*2)+1);
      //println((int(output[(i-1)/2][0][0])*2)+1);
      for (int j = 1; j < (PApplet.parseInt(output[(i-1)/2][0][0])*2)+1; j=j+2) {
        XML[] stuff = questions[j+2].getChildren(); //7?
        for (int s = 1; s < 14; s+=2) {
          output[(i-1)/2][(((j-1)/2)+1)][(s-1)/2] = stuff[s].getContent();
          //print("["+(i-1)/2+"]["+(((j-1)/2)+1)+"]["+(s-1)/2+"]");
          //println(output[(i-1)/2][(((j-1)/2)+1)][(s-1)/2]);
        }
      }
    }
    /*
    //output = test;
     println(" _");
     for (int i = 0; i < 1; i++) {
     for (int j = 0; j < int(output[0][0][0])+1; j++) {
     for (int s = 0; s < 7; s++) {
     println("["+i+"]["+j+"]["+s+"]"+output[i][j][s]);
     }
     println("  _");
     }
     }
     println("done");*/
    WriteToXML(output);

    return output;
  }

  ///Tager arrayet hvis layout er bestemt via skemaet fundet i repo'et og laver det til en xml fil.
  public void WriteToXML(String[][][] set) {
    XML output;
    //println("Filen 'opgavesæt_"+set[0][0][3]+".xml' konstrueres");

    /*println(" _");
    for (int i = 0; i < 1; i++) {
      for (int j = 0; j < int(set[0][0][0])+1; j++) {
        //println(j < int(set[0][0][0])+1);
        //println(int(set[0][0][0])+1);
        for (int s = 0; s < 7; s++) {
          println("["+i+"]["+j+"]["+s+"]"+set[i][j][s]);
        }
        println("  _");
      }
    }
    println("done");*/

    output = parseXML("<data></data>");

    //println(set.length);
    for (int s = 0; s < PApplet.parseInt(set.length); s++) {
      XML set1 = output.addChild("set"+str(s+1));
      XML info = set1.addChild("info");

      info.addChild("number_of_questions").setContent(set[s][0][0]);
      info.addChild("max_points").setContent(set[s][0][1]);
      info.addChild("max_mistakes").setContent(set[s][0][2]);
      info.addChild("teachers_name").setContent(set[s][0][3]);


      for (int i = 0; i < PApplet.parseInt(set[s][0][0]); i++) {
        XML spm = set1.addChild("question"+str(i));
        spm.addChild("question").setContent(set[s][i+1][0]);
        spm.addChild("extra_text").setContent(set[s][i+1][1]);
        spm.addChild("points").setContent(set[s][i+1][2]);
        spm.addChild("answer1_correct").setContent(set[s][i+1][3]);
        spm.addChild("answer2").setContent(set[s][i+1][4]);
        spm.addChild("answer3").setContent(set[s][i+1][5]);
        spm.addChild("answer4").setContent(set[s][i+1][6]);
      }
    }
    //println(output);
    Pattern p = Pattern.compile("[^a-z0-9æøåÆØÅA-Z ]", Pattern.CASE_INSENSITIVE);
    Matcher m = p.matcher(set[0][0][3]);
    boolean b = m.find();
    if (!b)saveXML(output, "opgavesæt_"+set[0][0][3]+".xml");
    else saveXML(output, "opgavesæt_.xml");
    //println("done");
  }
}

  public void settings() {  size(1920, 1080); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "mini_eksamen" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
