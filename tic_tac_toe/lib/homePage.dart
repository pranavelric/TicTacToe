import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool onTurn = true; //first player turn
  List<String> displayXO = ["", "", "", "", "", "", "", "", ""];
  int xScore = 0;
  int oScore = 0;
  int filledBoxes = 0;

  static var myNewFont = GoogleFonts.pressStart2P(
      textStyle: TextStyle(color: Colors.black, letterSpacing: 3));
  static var myNewFontWhite = GoogleFonts.pressStart2P(
    textStyle: TextStyle(color: Colors.white, letterSpacing: 3),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[700],
        title: Text(
          "Tic Tac Toe",
          style: myNewFontWhite.copyWith(fontSize: 20),
        ),
      ),
      backgroundColor: Colors.grey[900],
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      children: [
                        Text(
                          "Player X",
                          style: myNewFontWhite.copyWith(fontSize: 25),
                        ),
                        Text(
                          xScore.toString(),
                          style: myNewFontWhite.copyWith(fontSize: 25),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      children: [
                        Text(
                          "Player O",
                          style: myNewFontWhite.copyWith(fontSize: 25),
                        ),
                        Text(
                          oScore.toString(),
                          style: myNewFontWhite.copyWith(fontSize: 25),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: GridView.builder(
                itemCount: 9,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      _tapped(index);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey[700])),
                      child: Center(
                        child: Text(
                          displayXO[index],
                          style: TextStyle(color: Colors.white, fontSize: 40),
                        ),
                      ),
                    ),
                  );
                }),
          ),
          Expanded(child: Container()),
        ],
      ),
    );
  }

  void _tapped(int index) {
    setState(() {
      if (onTurn && displayXO[index] == "") {
        displayXO[index] = "X";
        filledBoxes += 1;
      } else if (!onTurn && displayXO[index] == "") {
        displayXO[index] = "O";
        filledBoxes += 1;
      }
      onTurn = !onTurn;
      _checkWinner();
    });
  }

  void _checkWinner() {
    //horizontal
    for (int i = 0; i <= 6; i += 3) {
      if (displayXO[i] == displayXO[i + 1] &&
          displayXO[i + 1] == displayXO[i + 2] &&
          displayXO[i] != "") return _showWinDialog(displayXO[i]);
    }
    //veritcal
    for (int i = 0; i <= 2; i++) {
      if (displayXO[i] == displayXO[i + 3] &&
          displayXO[i + 3] == displayXO[i + 6] &&
          displayXO[i] != "") return _showWinDialog(displayXO[i]);
    }

//diagonal
    if ((displayXO[0] == displayXO[4] &&
            displayXO[4] == displayXO[8] &&
            displayXO[4] != "") ||
        (displayXO[2] == displayXO[4] &&
            displayXO[4] == displayXO[6] &&
            displayXO[4] != "")) {
      return _showWinDialog(displayXO[4]);
    }

    //draw
    if (filledBoxes == 9) {
      _showDrawDialog();
    }
  }

  void _showDrawDialog() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Draw"),
            actions: [
              FlatButton(
                  onPressed: () {
                    _clearBoard();
                    Navigator.of(context).pop();
                  },
                  child: Text("Play again"))
            ],
          );
        });
  }

  void _showWinDialog(String winner) {
    if (winner == "X") {
      xScore++;
    } else {
      oScore++;
    }

    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Winner is $winner"),
            actions: [
              FlatButton(
                  onPressed: () {
                    _clearBoard();
                    Navigator.of(context).pop();
                  },
                  child: Text("Play again"))
            ],
          );
        });
  }

  void _clearBoard() {
    setState(() {
      for (int i = 0; i < 9; i++) {
        displayXO[i] = "";
      }
    });
    filledBoxes = 0;
  }
}
