import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:maqe_hr/data/leave_request.dart';
import 'package:collection/collection.dart';
import 'package:intl/intl.dart';

class RequestItem extends StatelessWidget {
  final LeaveRequest request;

  const RequestItem({Key? key, required this.request}) : super(key: key);

  Widget _status() {
    switch (request.status) {
      case 'pending':
        return Row(
          children: const [
            Icon(
              FontAwesomeIcons.solidClock,
              size: 15,
              color: Colors.orange,
            ),
            SizedBox(
              width: 5,
            ),
            Text('Pending')
          ],
        );
      case 'approved':
        return Row(
          children: const [
            Icon(
              FontAwesomeIcons.solidCheckCircle,
              size: 15,
              color: Colors.green,
            ),
            SizedBox(
              width: 5,
            ),
            Text('Approved')
          ],
        );
      case 'canceled':
        return Row(
          children: const [
            Icon(
              FontAwesomeIcons.solidTimesCircle,
              size: 15,
              color: Colors.grey,
            ),
            SizedBox(
              width: 5,
            ),
            Text('Canceled')
          ],
        );
      default:
        return const SizedBox();
    }
  }

  Widget _icon(String type) {
    switch (type) {
      case 'remote':
        return const Icon(
          FontAwesomeIcons.desktop,
          size: 18,
        );
      case 'personal_leave':
        return const Icon(
          FontAwesomeIcons.plane,
          size: 18,
        );
      case 'switch_holiday':
        return const Icon(
          FontAwesomeIcons.random,
          size: 18,
        );
      case 'sick_leave':
        return const Icon(
          FontAwesomeIcons.medkit,
          size: 18,
        );
      default:
        return const SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    final group = request.requestList.groupListsBy((element) => element.type);

    return Opacity(
      opacity: request.status == 'canceled' ? 0.5 : 1,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      request.requestList
                              .where((e) => e.type.contains('leave'))
                              .isNotEmpty
                          ? 'Leave'
                          : 'Switch',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ...group.entries.map((e) {
                      if (e.value.length == 1) {
                        final data = e.value.first;
                        final dateText =
                            DateFormat('d MMM y').format(data.date);
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Row(
                            children: [
                              _icon(e.value.first.type),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(dateText),
                            ],
                          ),
                        );
                      } else if (e.value.length > 1) {
                        e.value.sortBy((element) => element.date);
                        final first = e.value.first;
                        final last = e.value.last;
                        if (first.date.month == last.date.month) {
                          final dateFormat =
                              DateFormat('d MMM y').format(last.date);
                          final dateText = '${first.date.day}-$dateFormat';
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Row(
                              children: [
                                _icon(e.value.first.type),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(dateText),
                              ],
                            ),
                          );
                        }
                      }

                      return const SizedBox();
                    })
                  ],
                ),
              ),
              _status()
            ],
          ),
        ),
      ),
    );
  }
}
