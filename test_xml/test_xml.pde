// The following short XML file called "mammals.xml" is parsed 
// in the code below. It must be in the project's "data" folder.
//
// <?xml version="1.0"?>
// <mammals>
//   <animal id="0" species="Capra hircus">Goat</animal>
//   <animal id="1" species="Panthera pardus">Leopard</animal>
//   <animal id="2" species="Equus zebra">Zebra</animal>
// </mammals>
class a{
  void setup() {
    XML xml = loadXML("C:\\Users\\tilfa\\Documents\\GitHub\\Mini-eksamen\\test_xml\\data\\test.xml");
    XML[] sets = xml.getChildren();
    int spm;
    // 
    println((xml.getChildCount()-1)/2);
    for (int i = 1; i < xml.getChildCount(); i = i + 2) {
      //println("i = "+i+": "+xml.getChildren()[i].toString());
      XML info = sets[i];
      println("i = "+i+": "+info.toString());
      println("");
      XML[] infom = sets[i].getChild(1).getChildren();
      spm = int(infom[1].getContent());
      for (int j = 1; j < 8; j = j + 2) {
        println("j = "+j+": "+infom[j].getContent());
      }
      println(spm);
      XML[] questions = sets[i].getChildren();
      for (int j = 1; j < (spm*2)+1; j+=2) {
        XML[] stuff = questions[(j*2)+1].getChildren();
        for (int s = 1; s < 14; s+=2) {
          println("s = "+s+": "+stuff[s].getContent());
        }
      }
    }
    println("_Done");
  }
}
