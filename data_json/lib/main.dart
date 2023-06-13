import 'dart:convert';
import 'package:data_json/user.dart';
import 'package:flutter/material.dart';

void main(List<String> args) {
  return runApp(const Myapp());
}

class Myapp extends StatefulWidget {
  const Myapp({super.key});
  @override
  State<Myapp> createState() {
    return _MyappState();
  }
}

class _MyappState extends State<Myapp> {
  var jsonString =
      jsonEncode({"name": "John Smith", "email": "john@example.com"});

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> user = jsonDecode(jsonString);
    var userdata = User.fromJson(user);
    double borderradius = 20;
    print('Howdy ${userdata.name}!');
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Datalog",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ),
        body: FutureBuilder(
            future:
                DefaultAssetBundle.of(context).loadString('assets/data.json'),
            builder: ((context, snapshot) {
              var data = json.decode(snapshot.data.toString());

              if ((data == null)) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(50.0),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        // children: [
                        //   List.generate(text.length, (index) {
                        //   return
                        //   Text(text[index].toString());
                        //   } ,
                        //   for(var i in text)Text(i.toString()),
                        //   Text((data[0]["name"] != null) ? data[0]["name"].toString()
                        //       : 'null'),
                        // ],
                        children: List.generate(
                          data.length,
                          (index) => Padding(
                            padding: EdgeInsets.all(borderradius),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(5)),
                              padding: const EdgeInsets.all(20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    data[index]["_id"].toString(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    data[index]["phone"].toString(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    data[index]["name"].toString(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }
            })),
      ),
    );
  }
}

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
