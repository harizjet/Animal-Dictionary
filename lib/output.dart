import 'package:flutter/material.dart';

class Output extends StatefulWidget {
  Map animalnames = {};

  Output(this.animalnames);

  @override
  _OutputState createState() => _OutputState();
}

class _OutputState extends State<Output> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Animal Dictionary'),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: ListView.builder(
        itemCount: widget.animalnames.length,
        itemBuilder: (context, index) {
          var column = widget.animalnames.keys.elementAt(index);
          return Container(
            padding: EdgeInsets.all(15),
            color: Colors.green[100],
            child: Column(
              children: <Widget>[
                if (index == 0)
                  Align(
                    alignment: Alignment.topCenter,
                    child: RichText(
                      text: TextSpan(
                        text: widget.animalnames[column],
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                      ),
                    ),
                  ),
                if (index == 1)
                  Container(
                    color: Colors.green[100],
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: FittedBox(
                      child:
                          Image.network('${widget.animalnames[column].trim()}'),
                    ),
                  ),
                if (index != 1 && index != 0)
                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Colors.black26),
                      ),
                    ),
                    padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            "$column",
                            style: TextStyle(
                              color: Colors.grey[800],
                              fontSize: 15,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "${widget.animalnames[column]}",
                            style: TextStyle(
                              color: Colors.grey[800],
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class noOutput extends StatelessWidget {
  bool result;
  String suggestion;

  noOutput(this.result, this.suggestion);

  String resultword() {
    return ('Results not found');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Animal Dictionary'),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        color: Colors.green[100],
        child: Align(
          alignment: Alignment.topCenter,
          child: ListTile(
            title: RichText(
              text: TextSpan(
                text: resultword(),
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
            ),
            subtitle: RichText(
              text: TextSpan(
                text: 'Perhaps you means ${this.suggestion} ?',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
