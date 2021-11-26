class XMLHandler {

  String[][] test = new String[2][7];

  XMLHandler() {
    test[0][0] = "1";
    test[0][1] = "0";
    test[0][2] = "Frederik";
    test[1][0] = "Hvad er det bedste show?";
    test[1][1] = "";
    test[1][2] = "3";
    test[1][3] = "10";
    test[1][4] = "Thee Flash";
    test[1][5] = "Ninjago";
    test[1][6] = "JoJo";
    WriteToXML(test);
  }

  ///Tager arrayet hvis layout er bestemt via skemaet fundet i repo'et og laver det til en xml fil.
  public void WriteToXML(String[][] set) {
    XML output;

    output = parseXML("<data></data>");
    XML set1 = output.addChild("set1");
    XML info = set1.addChild("info");

    info.addChild("number_of_questions").setContent(set[0][0]);
    info.addChild("max_mistakees").setContent(set[0][1]);
    info.addChild("teachers_name").setContent(set[0][2]);


    for (int i = 0; i < int(set[0][0]); i++) {
      XML spm = set1.addChild("question"+str(i));
      spm.addChild("question").setContent(set[1][0]);
      spm.addChild("extra_text").setContent(set[1][1]);
      spm.addChild("number_of_answers").setContent(set[1][2]);
      spm.addChild("max_points").setContent(set[1][3]);

      for (int j = 0; j < int(set[1][2]); j++) { //<>//
        spm.addChild("answer"+str(j+1)).setContent(set[1][j + 4]);
      }
    }

    //println(output);
    saveXML(output, "opgavesæt_"+set[0][3]+".xml");
  }
}
