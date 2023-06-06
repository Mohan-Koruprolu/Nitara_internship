import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  var val = [];
  var images = [];
  var links = [];
  TextEditingController textcontrol = TextEditingController();
  String displaytext = '';
  Future fetchJson() async {
    final response = await http.get(Uri.parse(
        'https://api.edamam.com/search?q=chicken&app_id=292ff540&app_key=389aa8ecd494756a7cef3337a9b4b9a4	&from=0&to=100&calories=591-722&health=alcohol-free'));
    if (response.statusCode == 200) {
      final jsondata = json.decode(response.body);
      setState(() {
        for (var i = 0; i < jsondata['hits'].length; i++) {
          val.add(jsondata["hits"][i]['label']);
          images.add(jsondata["hits"][i]['image']);
        }
      });
    } else {}
  }

  bool isloading = true;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: (isloading)
          ? Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextField(
                  controller: textcontrol,
                  decoration:
                      const InputDecoration(hintText: "Enter the item name "),
                ),
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        isloading = false;
                        displaytext = textcontrol.text;
                      });
                    },
                    child: const Text('search recipie'))
              ],
            )
          : FutureBuilder(
              future: http.get(Uri.parse(
                  'https://api.edamam.com/search?q=$displaytext&app_id=292ff540&app_key=389aa8ecd494756a7cef3337a9b4b9a4	&from=0&to=10&calories=591-722&health=alcohol-free')),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  var snapshot2 = snapshot.data!;
                  snapdata(snapshot2);
                  return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                    itemCount: val.length,
                    itemBuilder: (_, index) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Stack(children: [
                        ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(images[index])),
                        Positioned(
                          bottom: 20,
                          child: Container(
                            height: 30,
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 255, 255, 255),
                                borderRadius: BorderRadius.circular(5)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                val[index],
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 40,
                          child: ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (BuildContext context) {
                                    return WebView(
                                      javascriptMode:
                                          JavascriptMode.unrestricted,
                                      initialUrl: links[index],
                                    );
                                  }),
                                );
                              },
                              child: const Text('Get recipe')),
                        ),
                      ]),
                    ),
                  );
                } else {
                  return const CircularProgressIndicator();
                }
              }),
    );
  }

  void snapdata(http.Response snapshot2) {
    final jsondata = json.decode(snapshot2.body);
    for (var i = 0; i < jsondata['hits'].length; i++) {
      val.add(jsondata['hits'][i]['recipe']['label']);
      images.add(jsondata['hits'][i]['recipe']['image']);
      links.add(jsondata['hits'][i]['recipe']['url']);
    }
  }
}

// class _HomepageState extends State<Homepage> {
//   TextEditingController textcontrol = TextEditingController();
//   String displaytext = '';
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Container(
//         decoration: const BoxDecoration(color: Colors.red),
//         child: Column(
//           children: [
//             TextField(
//               controller: textcontrol,
//               style: const TextStyle(color: Colors.white),
//               decoration: const InputDecoration(
//                   filled: true,
//                   fillColor: Colors.blue,
//                   hintText: "Enter the item"),
//             ),
//             ElevatedButton(
//                 onPressed: () {
//                   setState(() {
//                     displaytext = textcontrol.text;
//                     // print(displaytext);
//                   });
//                 },
//                 child: const Text(
//                   'send data',
//                 )),
//             Text(
//               'displayed text is $displaytext',
//               style: const TextStyle(
//                   color: Color.fromARGB(255, 24, 0, 160), fontSize: 20),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

//https://github.com/flutter/flutter/issues/73109




// ListView.builder(
//                   itemCount: val.length,
//                   itemBuilder: (context, itembuilder) {
//                     return Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Container(
//                         decoration: BoxDecoration(
//                             color: Colors.blueGrey,
//                             borderRadius: BorderRadius.circular(10)),
//                         height: 200,
//                         child: Stack(children: [
//                           Row(
//                             children: [
//                               Image.network(images[itembuilder]),
//                               Padding(
//                                 padding:
//                                     const EdgeInsets.symmetric(horizontal: 25),
//                                 child: ElevatedButton(
//                                     onPressed: () {
//                                       Navigator.of(context).push(
//                                         MaterialPageRoute(
//                                             builder: (BuildContext context) {
//                                           return WebView(
//                                             javascriptMode:
//                                                 JavascriptMode.unrestricted,
//                                             onProgress: (value) {
//                                               if (value == 100) {
//                                                 setState(() {
//                                                   isloading = false;
//                                                 });
//                                               }
//                                             },
//                                             initialUrl: links[itembuilder],
//                                           );
//                                         }),
//                                       );
//                                     },
//                                     child: const Text('Get recipe')),
//                               )
//                             ],
//                           ),
//                           Positioned(
//                             bottom: 20,
//                             child: Container(
//                               padding:
//                                   const EdgeInsets.symmetric(horizontal: 10),
//                               decoration: BoxDecoration(
//                                   color:
//                                       const Color.fromARGB(255, 255, 255, 255),
//                                   borderRadius: BorderRadius.circular(10)),
//                               child: Text(
//                                 val[itembuilder],
//                               ),
//                             ),
//                           ),
//                         ]),
//                       ),
//                     );
//                   });