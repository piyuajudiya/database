import 'package:database/main.dart';
import 'package:database/mydb.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class view extends StatefulWidget {
  String? data;

  view(this.data);

  @override
  State<view> createState() => _viewState();
}

class _viewState extends State<view> {
  List<Map<String, Object?>> list = [];
  String p = "";

  data() {
    if (widget.data == "fav") {
      p = "select * from student where fav=1";
    } else {
      p = "select * from student";
    }

    mydatabase my = mydatabase();
    my.database().then((value) {
      value.rawQuery(p).then((value) {
        setState(() {
          list = value as List<Map<String, Object?>>;
        });
        print(list);
      });
    });
  }

  mydatabase m = mydatabase();
  TextEditingController t = TextEditingController();
  TextEditingController t1 = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    data();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
              return view("fav");
            },));
          }, icon: Icon(Icons.favorite))
        ],
      ),
      body: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          Map m = list[index];
          return InkWell(
            onTap: () {},
            child: ListTile(
              title: Text('${m['name']}'),
              subtitle: Text('${m['id']}'),
              leading: Text('${m['mail']}'),
              trailing: Wrap(
                children: [
                  m['fav'] == 0
                      ? IconButton(
                      onPressed: () {
                        String p =
                            "update student set fav=1 where id=${m['id']} ";
                        mydatabase my = mydatabase();
                        my.database().then((value) {
                          value.rawQuery(p).then((value) {
                            data();
                          });
                        });
                      },
                      icon: Icon(Icons.favorite))
                      : IconButton(
                      onPressed: () {
                        String p =
                            "update student set fav=0 where id=${m['id']} ";
                        mydatabase my = mydatabase();
                        my.database().then((value) {
                          value.rawQuery(p).then((value) {
                            data();
                          });
                        });
                      },
                      icon: Icon(Icons.favorite_border_outlined)),
                  InkWell(
                    onTap: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(
                        builder: (context) {
                          return demo(
                            map: m,
                            method: "update",
                          );
                        },
                      ));
                    },
                    child: Container(
                      child: Icon(Icons.edit),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      mydatabase my = mydatabase();
                      my.database().then((value) {
                        Map m = list[index];
                        String d = "delete from student where id = ${m['id']}";
                        value.rawDelete(d).then((value) {
                          print(value);
                          data();
                        });
                      });
                    },
                    child: Container(
                      child: Icon(Icons.delete),
                      decoration: BoxDecoration(),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
