import 'dart:convert';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:maqe_hr/data/leave_request.dart';
import 'package:maqe_hr/widget/request_item.dart';

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
          builder:
              (BuildContext context, AsyncSnapshot<http.Response> snapshot) {
            final response = snapshot.data;

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (response != null && response.statusCode == 200) {
              final jsonResponse =
                  jsonDecode(response.body) as Map<String, dynamic>;
              final totalDay = jsonResponse['total_day'] ?? '';
              final totalDayLeft = jsonResponse['total_day_left'] ?? '';
              final totalDayUsed = jsonResponse['total_day_used'] ?? '';
              final double height = AppBar().preferredSize.height;
              final List list = jsonResponse['leave_requests'] ?? [];
              final List<LeaveRequest> leaveList = list
                  .map((item) => LeaveRequest(
                      item['status'],
                      (item['request_list'] as List)
                          .map((e) => RequestListItem(
                              DateTime.parse(e['date']), e['type']))
                          .toList()))
                  .toList();

              return Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: 150,
                    color: const Color.fromARGB(255, 203, 236, 255),
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
                                          color: Colors.grey[300],
                                          width: 1,
                                        ),
                                        _showNumber(
                                            totalDayUsed,
                                            const Color.fromARGB(
                                                255, 41, 173, 255),
                                            'Used'),
                                        Container(
                                          margin: const EdgeInsets.all(24.0),
                                          height: 50,
                                          color: Colors.grey[300],
                                          width: 1,
                                        ),
                                        _showNumber(totalDayLeft, Colors.orange,
                                            'Left'),
                                      ],
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        OutlinedButton.icon(
                                          style: OutlinedButton.styleFrom(
                                            backgroundColor:
                                                const Color.fromARGB(
                                                    255, 41, 173, 255),
                                            side: const BorderSide(
                                              width: 1.0,
                                              color: Color.fromARGB(
                                                  255, 41, 173, 255),
                                            ),
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
                                              width: 1.0,
                                              color: Color.fromARGB(
                                                  255, 41, 173, 255),
                                            ),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                          ),
                                          onPressed: () {},
                                          icon: const Icon(
                                            FontAwesomeIcons.random,
                                            color: Color.fromARGB(
                                                255, 41, 173, 255),
                                          ),
                                          label: const Text('Switch'),
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
                              const Expanded(
                                  child: Text(
                                'My request',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )),
                              TextButton.icon(
                                  onPressed: () {},
                                  icon: const Icon(
                                    FontAwesomeIcons.calendar,
                                    color: Color.fromARGB(255, 41, 173, 255),
                                  ),
                                  label: const Text('Public holidays'))
                            ],
                          ),
                          ...leaveList.map((e) {
                            return RequestItem(
                              request: e,
                            );
                          })
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }

            return const Center(
              child: Text('Error'),
            );
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        enableFeedback: false,
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Colors.black,
        currentIndex: 0,
        selectedItemColor: const Color.fromARGB(255, 41, 173, 255),
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
          BottomNavigationBarItem(
            label: '',
            icon: Container(
              decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 41, 173, 255),
                  borderRadius: BorderRadius.all(Radius.circular(8))),
              width: 30,
              height: 30,
              child: const Icon(
                FontAwesomeIcons.plus,
                color: Colors.white,
              ),
            ),
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
