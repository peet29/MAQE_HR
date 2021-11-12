import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:maqe_hr/data/leave_request.dart';

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

  @override
  Widget build(BuildContext context) {
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
                    ...request.requestList.reversed.fold<List<Widget>>([],
                        (previousValue, element) {
                      previousValue.add(Text('test'));
                      return previousValue;
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
