import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  var val = [];
  var images = [];
  Future fetchJson() async {
    final response = await http.get(
        Uri.parse('https://www.themealdb.com/api/json/v1/1/search.php?f=a'));
    if (response.statusCode == 200) {
      final jsondata = json.decode(response.body);
      setState(() {
        for (var i = 0; i < jsondata['meals'].length; i++) {
          val.add(jsondata["meals"][i]['strMeal']);
          images.add(jsondata["meals"][i]['strMealThumb']);
        }
        print(val);
        print(jsondata["meals"].length);
      });
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: http.get(Uri.parse(
            'https://www.themealdb.com/api/json/v1/1/search.php?f=a')),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            var snapshot2 = snapshot.data!;
            snapdata(snapshot2);
            return ListView.builder(
                itemCount: val.length,
                itemBuilder: (context, itembuilder) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(10)),
                      height: 200,
                      child: Row(
                        children: [
                          Stack(children: [
                            Image.network(images[itembuilder]),
                            Positioned(
                                bottom: 20,
                                child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                            255, 255, 255, 255),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Text(val[itembuilder])))
                          ]),
                          Container(
                            padding: const EdgeInsets.fromLTRB(30, 10, 20, 0),
                            child: const Text(
                              "Get the Recipie",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                  letterSpacing: 1.5),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                });
          } else {
            return const CircularProgressIndicator();
          }
        });
  }

  void snapdata(http.Response snapshot2) {
    final jsondata = json.decode(snapshot2.body);
    for (var i = 0; i < jsondata["meals"].length; i++) {
      val.add(jsondata["meals"][i]['strMeal']);
      images.add(jsondata["meals"][i]['strMealThumb']);
    }
  }
}
