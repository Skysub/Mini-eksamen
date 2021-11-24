public static class XMLHandler {

  static public void SetUp() {
    String dataFolder = System.getenv("LOCALAPPDATA");

    File directory = new File(dataFolder+"\\QuizTool");
    if (!directory.exists()) {
      directory.mkdir();
    }
  }

  public String[][] ReadXMLFile() {
    return new String[0][0];
  }
}
