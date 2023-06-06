import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class Centralvalue {
  var val = [];
  var images = [];
  var links = [];
}

class _HomepageState extends State<Homepage> {
  var val = [];
  var images = [];
  var links = [];
  Centralvalue common = Centralvalue();
  TextEditingController textcontrol = TextEditingController();
  String displaytext = '';
  Future fetchJson() async {
    final response = await http.get(Uri.parse(
        'https://api.edamam.com/search?q=chicken&app_id=292ff540&app_key=389aa8ecd494756a7cef3337a9b4b9a4	&from=0&to=100&calories=591-722&health=alcohol-free'));
    if (response.statusCode == 200) {
      final jsondata = json.decode(response.body);
      setState(() {
        for (var i = 0; i < jsondata['hits'].length; i++) {
          common.val.add(jsondata["hits"][i]['label']);
          common.images.add(jsondata["hits"][i]['image']);
        }
      });
    } else {}
  }

  void snapdata(http.Response snapshot2) {
    final jsondata = json.decode(snapshot2.body);
    for (var i = 0; i < jsondata['hits'].length; i++) {
      val.add(jsondata['hits'][i]['recipe']['label']);
      images.add(jsondata['hits'][i]['recipe']['image']);
      links.add(jsondata['hits'][i]['recipe']['url']);
    }
  }

  List<Widget> children = [];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.fill,
              image: NetworkImage(
                'https://th.bing.com/th/id/OIP.PzKXUw9xlDt_LyGGVTgD3gHaLH?pid=ImgDet&rs=1',
              ))),
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
                  'https://api.edamam.com/search?q=${(displaytext == "" ? "chicken" : displaytext)}&app_id=292ff540&app_key=389aa8ecd494756a7cef3337a9b4b9a4	&from=0&to=10&calories=591-722&health=alcohol-free')),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  var snapshot2 = snapshot.data!;
                  snapdata(snapshot2);
                  for (var index = 0; index < val.length; index = index + 2) {
                    List<Widget> sideElements = [];
                    for (var i = 0; i < 2; i++) {
                      var samp = Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Stack(children: [
                            ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(images[index + i])),
                            Positioned(
                              bottom: 0,
                              child: Container(
                                height: MediaQuery.of(context).size.height / 8,
                                decoration: BoxDecoration(
                                    color: const Color.fromARGB(
                                        255, 255, 255, 255),
                                    borderRadius: BorderRadius.circular(5)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    val[index + i],
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 20,
                              child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (BuildContext context) {
                                        return WebView(
                                          javascriptMode:
                                              JavascriptMode.unrestricted,
                                          initialUrl: links[index + i],
                                        );
                                      }),
                                    );
                                  },
                                  child: const Text('Get recipe')),
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
              })
        ],
      ),
    ));
  }
}