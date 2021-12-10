// The following short XML file called "mammals.xml" is parsed 
// in the code below. It must be in the project's "data" folder.
//
// <?xml version="1.0"?>
// <mammals>
//   <animal id="0" species="Capra hircus">Goat</animal>
//   <animal id="1" species="Panthera pardus">Leopard</animal>
//   <animal id="2" species="Equus zebra">Zebra</animal>
// </mammals>

void setup() {
  XML xml = loadXML("C:\\Users\\tilfa\\Desktop\\test_xml\\data\\test.xml").getChild(1); //<>//
  //XML xml = input.getChild(1);
  
  XML[] sets = xml.getChildren();
  println(xml.toString());
  XML[] info = sets[0].getChild(0).getChildren();

  for (int i = 1; i < 5; i++) {
    println("i = "+i+": "+xml.getChildren()[i].toString());
  }
}

// Sketch prints:
// Goat
// Leopard
// Zebra
