import 'package:database/mydb.dart';
import 'package:database/view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: demo(
      method: "insert",
    ),
  ));
}

class demo extends StatefulWidget {
  String? method;
  Map? map;

  demo({this.method, this.map});

  @override
  State<demo> createState() => _demoState();
}

class _demoState extends State<demo> {
  mydatabase my = mydatabase();
  TextEditingController t = TextEditingController();
  TextEditingController t1 = TextEditingController();
  TextEditingController t2 = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    my.database().then((value) {
      print(value);
      if (widget.map != null) {
        t.text = '${widget.map!['name']}';
        t1.text = '${widget.map!['contact']}';
        t2.text = '${widget.map!['mail']}';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            Container(
              child: TextField(
                controller: t,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black38),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                ),
              ),
              margin: EdgeInsets.all(10),
            ),
            Container(
              child: TextField(
                controller: t1,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black38),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                ),
              ),
              margin: EdgeInsets.all(10),
            ),
            Container(
              child: TextField(
                controller: t2,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black38),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                ),
              ),
              margin: EdgeInsets.all(10),
            ),
            Container(
              child: ElevatedButton(
                onPressed: () {
                  String name = t.text;
                  String contact = t1.text;
                  String mail = t2.text;
                  if (widget.method == "insert") {
                    my.database().then((value) {
                      String q =
                          "insert into student(id,name,contact,mail)values(null,'$name','$contact','$mail')";

                      value.rawInsert(q).then((value) {
                        print(value);
                        // if (value >= 1) {
                        //   Navigator.push(context, MaterialPageRoute(
                        //     builder: (context) {
                        //       return view("all");
                        //     },
                        //   ));
                        // }
                      });
                    });
                  } else {
                    String p =
                        "update student set name='${t.text}',contact='${t1.text}',mail='${t2.text}' where id='${widget.map!['id']}' ";
                    mydatabase m = mydatabase();
                    m.database().then((value) {
                      value.rawQuery(p).then((value) {
                        Navigator.pushReplacement(context, MaterialPageRoute(
                          builder: (context) {
                            return view("all");
                          },
                        ));
                      });
                    });
                  }
                },
                child: Text("${widget.method}"),
              ),
            ),
            Container(
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return view("all");
                      },
                    ));
                  },
                  child: Text("view")),
            )
          ],
        ));
  }
}
