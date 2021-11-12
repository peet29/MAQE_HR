import 'dart:convert';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
        Text(
          num.toString(),
          style: TextStyle(
            color: color,
            fontSize: 35,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          text,
          style: const TextStyle(fontSize: 15),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
          future:
              http.get(Uri.parse('https://maqe.github.io/json/holidays.json')),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            final response = snapshot.data;

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            final jsonResponse =
                jsonDecode(response.body) as Map<String, dynamic>;
            final totalDay = jsonResponse['total_day'] ?? '';
            final totalDayLeft = jsonResponse['total_day_left'] ?? '';
            final totalDayUsed = jsonResponse['total_day_used'] ?? '';
            double height = AppBar().preferredSize.height;

            return Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 150,
                  color: const Color.fromARGB(100, 203, 236, 255),
                ),
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: height,
                        ),
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: SizedBox(
                              width: double.infinity,
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Text(
                                    'My holiday',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      _showNumber(
                                          totalDay, Colors.black, 'Total'),
                                      Container(
                                        margin: const EdgeInsets.all(24.0),
                                        height: 50,
                                        color: Colors.grey,
                                        width: 1,
                                      ),
                                      _showNumber(
                                          totalDayUsed, Colors.blue, 'Used'),
                                      Container(
                                        margin: const EdgeInsets.all(24.0),
                                        height: 50,
                                        color: Colors.grey,
                                        width: 1,
                                      ),
                                      _showNumber(
                                          totalDayLeft, Colors.orange, 'Left'),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      OutlinedButton.icon(
                                        style: OutlinedButton.styleFrom(
                                          backgroundColor: Colors.blue,
                                          side: const BorderSide(
                                              width: 1.0, color: Colors.blue),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                        ),
                                        onPressed: () {},
                                        icon: const Icon(
                                          FontAwesomeIcons.plus,
                                          size: 20,
                                          color: Colors.white,
                                        ),
                                        label: const Text(
                                          'Leave',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      OutlinedButton.icon(
                                        style: OutlinedButton.styleFrom(
                                          side: const BorderSide(
                                              width: 1.0, color: Colors.blue),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                        ),
                                        onPressed: () {},
                                        icon:
                                            const Icon(FontAwesomeIcons.random),
                                        label: const Text('Leave'),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            const Expanded(child: Text('My request')),
                            TextButton.icon(
                                onPressed: () {},
                                icon: const Icon(FontAwesomeIcons.calendar),
                                label: const Text('Public holidays'))
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        enableFeedback: false,
        type: BottomNavigationBarType.fixed,
        fixedColor: Colors.blue,
        unselectedItemColor: Colors.black,
        currentIndex: 0,
        items: [
          BottomNavigationBarItem(
            activeIcon: SizedBox(
              width: 30,
              child: Stack(
                fit: StackFit.loose,
                children: [
                  const Icon(FontAwesomeIcons.home),
                  Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      height: 3,
                      width: 3,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.green,
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20))),
                    ),
                  )
                ],
              ),
            ),
            label: '',
            icon: const Icon(FontAwesomeIcons.home),
          ),
          const BottomNavigationBarItem(
            label: '',
            icon: Icon(FontAwesomeIcons.calendar),
          ),
          const BottomNavigationBarItem(
            label: '',
            icon: Icon(FontAwesomeIcons.plus),
          ),
          const BottomNavigationBarItem(
            label: '',
            icon: Icon(FontAwesomeIcons.userFriends),
          ),
          const BottomNavigationBarItem(
            label: '',
            icon: Icon(FontAwesomeIcons.user),
          )
        ],
      ),
    );
  }
}
