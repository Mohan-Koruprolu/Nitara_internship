import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:hive/hive.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  var val = <String>[];
  var images = [];
  var links = [];
  TextEditingController textcontrol = TextEditingController();
  String displaytext = '';

  void snapdata(http.Response snapshot2) {
    final jsondata = json.decode(snapshot2.body);
    for (var i = 0; i < jsondata['hits'].length; i++) {
      val.add(jsondata['hits'][i]['recipe']['label'] as String);
      images.add(jsondata['hits'][i]['recipe']['image']);
      links.add(jsondata['hits'][i]['recipe']['url']);
    }
  }

  List<Widget> children = [];

  @override
  Widget build(BuildContext context) {
    if (displaytext != '') {
      dbstuff();
    }
    return SafeArea(
        child: Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
        Color.fromARGB(227, 0, 0, 0),
        Color.fromARGB(181, 32, 32, 32),
        Color.fromARGB(195, 68, 68, 68),
        Color.fromARGB(217, 79, 79, 79)
      ])),
      child: ListView(
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextField(
            controller: textcontrol,
            decoration: const InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: "Enter the item name "),
          ),
          ElevatedButton(
              onPressed: () {
                setState(() {
                  val = [];
                  images = [];
                  links = [];
                  children = [];
                  displaytext = textcontrol.text;
                });
              },
              child: const Text('search recipie')),
          FutureBuilder(
            future: http.get(Uri.parse(
                'https://api.edamam.com/search?q=${(displaytext == "" ? "" : displaytext)}&app_id=292ff540&app_key=389aa8ecd494756a7cef3337a9b4b9a4	&from=0&to=10&calories=591-722&health=alcohol-free')),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                var snapshot2 = snapshot.data!;
                snapdata(snapshot2);
                for (var index = 0; index < val.length; index = index + 2) {
                  List<Widget> sideElements = [];
                  for (var i = 0; i < 2; i++) {
                    var color2 = const Color.fromARGB(255, 255, 255, 255);
                    var samp = Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Stack(children: [
                          ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(images[index + i])),
                          Positioned(
                            bottom: 0,
                            child: InkWell(
                              onHover: (val) {
                                setState(() {
                                  color2 = (val) ? Colors.blue : Colors.green;
                                });
                              },
                              child: Container(
                                height: MediaQuery.of(context).size.height / 12,
                                width: MediaQuery.of(context).size.height / 9,
                                decoration: BoxDecoration(
                                    color: color2,
                                    borderRadius: BorderRadius.circular(5)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 6),
                                        child: Text(
                                          val[index + i],
                                          style: TextStyle(
                                              fontSize:
                                                  (val[index + i].length > 15)
                                                      ? 10
                                                      : MediaQuery.of(context)
                                                              .size
                                                              .width /
                                                          30),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: ElevatedButton(
                                          onPressed: () {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(builder:
                                                  (BuildContext context) {
                                                return WebView(
                                                  javascriptMode: JavascriptMode
                                                      .unrestricted,
                                                  initialUrl: links[index + i],
                                                );
                                              }),
                                            );
                                          },
                                          child: const Text(
                                            'Get recipe',
                                            style: TextStyle(
                                                textBaseline:
                                                    TextBaseline.alphabetic),
                                          )),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ]),
                      ),
                    );
                    sideElements.add(samp);
                  }
                  children.add(Row(
                    children: sideElements,
                  ));
                }
                return Column(
                  children: children,
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          )
        ],
      ),
    ));
  }

  void dbstuff() async {
    var box = await Hive.openBox('RecentWord');
    // box.put(TimeOfDay.now() as String, displaytext);
    print(box);
  }
}
