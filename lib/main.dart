import 'package:flutter/material.dart';

const alpha = <int, String>{
  97: "a",
  98: "b",
  99: "c",
  100: "d",
  101: "e",
  102: "f",
  103: "g",
  104: "h",
  105: "i",
  106: "j",
  107: "k",
  108: "l",
  109: "m",
  110: "n",
  111: "o",
  112: "p",
  113: "q",
  114: "r",
  115: "s",
  116: "t",
  117: "u",
  118: "v",
  119: "w",
  120: "x",
  121: "y",
  122: "z",
};
void main() {
  runApp(const CaesarCypher());
}

class CaesarCypher extends StatefulWidget {
  const CaesarCypher({super.key});

  @override
  State<CaesarCypher> createState() => CaesarCypherState();
}

class CaesarCypherState extends State<CaesarCypher> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Center(
              child: Text(
                "Caesar Cypher",
                style: TextStyle(
                  fontSize: 35,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            bottom: TabBar(
              indicatorColor: Colors.indigo,
              tabs: [
                Tab(
                  icon: Icon(
                    Icons.enhanced_encryption_rounded,
                    color: Colors.pink,
                  ),
                  child: Text(
                    "Encrypting",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Tab(
                  icon: Icon(Icons.no_encryption_rounded, color: Colors.teal),
                  child: Text(
                    "Decrypting",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          body: TabBarView(children: [Encryptor(), Decryptor()]),
        ),
      ),
    );
  }
}

class Encryptor extends StatefulWidget {
  const Encryptor({super.key});

  @override
  State<Encryptor> createState() => EncryptorState();
}

class EncryptorState extends State<Encryptor> {
  final phrase = TextEditingController();
  final ckey = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return CryptWidget(action: "Encrypt", phrase: phrase, ckey: ckey);
  }
}

class Decryptor extends StatefulWidget {
  const Decryptor({super.key});

  @override
  State<Decryptor> createState() => DecryptorState();
}

class DecryptorState extends State<Decryptor> {
  final phrase = TextEditingController();
  final ckey = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return CryptWidget(action: "Decrypt", phrase: phrase, ckey: ckey);
  }
}

class CryptWidget extends StatefulWidget {
  const CryptWidget({
    super.key,
    required this.action,
    required this.phrase,
    required this.ckey,
  });

  final String action;
  final TextEditingController phrase;
  final TextEditingController ckey;

  @override
  State<CryptWidget> createState() => CryptWidgetState();
}

class CryptWidgetState extends State<CryptWidget> {
  String crypt = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                "Please Enter The Phrase You want To ${widget.action}",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 15),
              Card(
                margin: EdgeInsets.only(right: 45, left: 45, top: 15),
                child: TextField(
                  cursorColor: Colors.pinkAccent,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  controller: widget.phrase,
                ),
              ),
              SizedBox(height: 30),
              Text(
                "Please Enter The Key of ${widget.action}ion",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 15),
              Card(
                margin: EdgeInsets.only(right: 120, left: 120, top: 15),
                child: TextField(
                  cursorColor: Colors.pinkAccent,
                  textAlign: TextAlign.center,
                  maxLength: 2,
                  keyboardType: TextInputType.numberWithOptions(
                    signed: false,
                    decimal: false,
                  ),
                  controller: widget.ckey,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  String ph = widget.phrase.text.toLowerCase();
                  int ky = int.parse(widget.ckey.text);
                  if (ky.toString().isEmpty || ph.isEmpty) {
                    emptyfield();
                  } else {
                    if (ky < 1 || ky > 25) {
                      wrongKey();
                    } else if (!ph.contains(RegExp(r'[a-z]'))) {
                      wrongchar();
                    } else {
                      setState(() {
                        crypting(widget.action);
                      });
                    }
                  }
                },
                child: Text(
                  "${widget.action} it",
                  style: TextStyle(fontSize: 20, height: 2.5),
                ),
              ),
              SizedBox(height: 150),
              Text(
                "${widget.action}ed Text",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
              crypt.isNotEmpty
                  ? Card(
                    margin: EdgeInsets.all(30),
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        crypt,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }

  void crypting(String act) {
    crypt = "";
    List<bool> uppers = [];
    for (int j = 0; j < widget.phrase.text.length; j++) {
      (widget.phrase.text[j].toUpperCase() == widget.phrase.text[j])
          ? uppers.add(true)
          : uppers.add(false);
    }
    if (act == "Encrypt") {
      for (var letter in widget.phrase.text.toLowerCase().runes) {
        //print(letter);
        if (letter == 32) {
          crypt = "$crypt ";
        } else {
          if ((letter + int.parse(widget.ckey.text)) > 122) {
            letter = letter - 26;
          }
          if (alpha[letter + int.parse(widget.ckey.text)] != null) {
            crypt += (alpha[letter + int.parse(widget.ckey.text)]).toString();
          } else {
            crypt = "$crypt ";
          }
        }
      }
    } else if (act == "Decrypt") {
      for (var letter in widget.phrase.text.toLowerCase().runes) {
        //print(letter);
        if (letter == 32) {
          crypt = "$crypt ";
        } else {
          if ((letter - int.parse(widget.ckey.text)) < 97) {
            letter = letter + 26;
          }
          if (alpha[letter - int.parse(widget.ckey.text)] != null) {
            crypt += (alpha[letter - int.parse(widget.ckey.text)]).toString();
          } else {
            crypt = "$crypt ";
          }
        }
      }
    }
    widget.phrase.clear();
    widget.ckey.clear();
    String s = '';
    for (int i = 0; i < crypt.length; i++) {
      if (uppers[i] == true) {
        s += crypt[i].toUpperCase();
      } else if (crypt[i].runes == 32) {
        s += "$crypt[i] ";
      } else {
        s += crypt[i];
      }
    }
    crypt = s;
  }

  void wrongKey() {
    showDialog<String>(
      context: context,
      builder:
          (BuildContext context) => AlertDialog(
            title: const Text(
              'Invalid Key',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            content: const Text(
              'Please Enter a Key Between 1 & 25',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'OK'),
                child: const Text('OK'),
              ),
            ],
          ),
    );
  }

  void wrongchar() {
    showDialog<String>(
      context: context,
      builder:
          (BuildContext context) => AlertDialog(
            title: const Text(
              'Invalid character',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            content: const Text(
              'Please Enter only alphabet characters',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'OK'),
                child: const Text('OK'),
              ),
            ],
          ),
    );
  }

  void emptyfield() {
    showDialog<String>(
      context: context,
      builder:
          (BuildContext context) => AlertDialog(
            title: const Text(
              'Empty Fields',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            content: const Text(
              'Please Complete the Fields before pressing the button',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'OK'),
                child: const Text('OK'),
              ),
            ],
          ),
    );
  }
}
