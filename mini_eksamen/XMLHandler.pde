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
    WriteToXML(test);
  }

  String[][][] ReadFromXML(String path) {
    XML input = loadXML(path);
    String [][][] output;

    output = new String[(input.getChildCount()-1)/2][99][7];

    XML[] sets = input.getChildren();
    //println("1: "+sets[1].toString());
    for (int i = 1; i < input.getChildCount(); i = i + 2) {
      XML[] info = sets[i].getChild(1).getChildren();
      for (int j = 1; j < 8; j = j + 2) {
        output[(i-1)/2][0][(j-1)/2] = info[j].getContent();
      }
      XML[] questions = sets[i].getChildren();
      for (int j = 1; j < (int(output[(i-1)/2][0][0])*2)+1; j+=2) {
        XML[] stuff = questions[(j*2)+1].getChildren();
        for (int s = 1; s < 14; s+=2) {
          output[(i-1)/2][((j-1)/2)+1][(s-1)/2] = stuff[s].getContent();
        }
      }
    }
    /*
    //output = test;
    for (int i = 0; i < 1; i++) {
      for (int j = 0; j < 2; j++) {
        for (int s = 0; s < 7; s++) {
          println("["+i+"]["+j+"]["+s+"]"+output[i][j][s]);
        }
        println("  _");
      }
    }
    println("done");
    WriteToXML(output);
    */
    return output;
  }

  ///Tager arrayet hvis layout er bestemt via skemaet fundet i repo'et og laver det til en xml fil.
  public void WriteToXML(String[][][] set) {
    XML output;
    //println("Filen 'opgavesæt_"+set[0][0][3]+".xml' konstrueres");

    output = parseXML("<data></data>");

    //println(set.length);
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
