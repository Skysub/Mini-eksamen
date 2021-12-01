class XMLHandler {

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
    WriteToXML(test);
  }

  ///Tager arrayet hvis layout er bestemt via skemaet fundet i repo'et og laver det til en xml fil.
  public void WriteToXML(String[][][] set) {
    XML output;
    //println("Filen 'opgavesæt_"+set[0][0][3]+".xml' konstrueres");

    output = parseXML("<data></data>");

    for (int s = 0; s < int(set.length); s++) {
      XML set1 = output.addChild("set"+str(s+1));
      XML info = set1.addChild("info");

      info.addChild("number_of_questions").setContent(set[s][0][0]);
      info.addChild("max_points").setContent(set[s][0][1]);
      info.addChild("max_mistakes").setContent(set[s][0][2]);
      info.addChild("teachers_name").setContent(set[s][0][3]);


      for (int i = 0; i < int(set[s][0][0]); i++) {
        XML spm = set1.addChild("question"+str(i));
        spm.addChild("question").setContent(set[s][1][0]);
        spm.addChild("extra_text").setContent(set[s][1][1]);
        spm.addChild("points").setContent(set[s][1][2]);
        spm.addChild("answer1_correct").setContent(set[s][1][3]);
        spm.addChild("answer2").setContent(set[s][1][4]);
        spm.addChild("answer3").setContent(set[s][1][5]);
        spm.addChild("answer4").setContent(set[s][1][6]);
      }
    }
    //println(output);
    saveXML(output, "opgavesæt_"+set[0][0][3]+".xml");
    //println("done");
  }
}
