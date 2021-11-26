public static class XMLHandler {

  static String dataFolder = System.getenv("LOCALAPPDATA");
  static String Path = dataFolder+"\\QuizTool";

  ///Returns the path to the data folder in appdata
  static public String GetFolder(){
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

  public String[][] ReadXMLFile() {
    return new String[0][0];
  }
}
