import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Widget _showNumber(int num, Color color, String text) {
    return Column(
      children: [
        Text(num.toString()),
        Text(text),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: FutureBuilder(
        future:
            http.get(Uri.parse('https://maqe.github.io/json/holidays.json')),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          final data = snapshot.data;

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          return Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text('My holiday'),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              _showNumber(15, Colors.black, 'Total'),
                              _showNumber(8, Colors.blue, 'Used'),
                              _showNumber(7, Colors.black, 'Left'),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        },
      )),
    );
  }
}
