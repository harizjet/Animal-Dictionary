import 'package:flutter/material.dart';

import 'package:spreadsheet_decoder/spreadsheet_decoder.dart';
import 'package:flutter/services.dart';
import 'output.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Zoo Dictionary',
      theme: ThemeData(
        primaryColor: Color(0xff2931a5),
        textTheme: TextTheme(
          headline6: TextStyle(
            fontSize: 27,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      home: MyHomePage(title: 'Zoo Dictionary'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  static bool found = false;
  final String title;
  static Map<String, String> animals = {};
  static List<String> closestinput = [];

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController searchname = TextEditingController();

  var excelfile;

  Future readExcel() async {
    ByteData data = await rootBundle.load("assets/Animal_Information.xlsx");
    var bytes =
        await data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    var decoder = await SpreadsheetDecoder.decodeBytes(bytes, update: true);

    var table = await decoder.tables['Animal_Information'];

    return table;
  }

  Future animalData(String input) async {
    var table = await readExcel();
    for (int row = 0; row < table.rows.length; row++) {
      if (table.rows[row][0].toUpperCase() == input.toUpperCase()) {
        for (int col = 0; col < table.maxCols; col++) {
          if (table.rows[row][col] != null) {
            MyHomePage.animals[table.rows[row - 1][col]] =
                table.rows[row][col].toString().replaceAll('|', ',');
            MyHomePage.found = true;
          }
        }
        return MyHomePage.animals;
      }

      if (table.rows[row][0].toUpperCase().split(
              ' ')[table.rows[row][0].toUpperCase().split(' ').length - 1] ==
          input.split(' ')[input.split(' ').length - 1]) {
        MyHomePage.closestinput.add(table.rows[row][0].toUpperCase());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
        alignment: Alignment.center,
        child: TextField(
          controller: searchname,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.message),
            labelText: "Search an animal:",
            suffixIcon: IconButton(
              icon: Icon(Icons.search),
              splashColor: Colors.blueAccent,
              onPressed: () async {
                var temp = await animalData(searchname.text);
                if (MyHomePage.found == true)
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Output(temp),
                    ),
                  );
                if (MyHomePage.found == false)
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => noOutput(
                          MyHomePage.found, MyHomePage.closestinput.toString()),
                    ),
                  );
              },
            ),
          ),
        ),
      ),
    );
  }
}
