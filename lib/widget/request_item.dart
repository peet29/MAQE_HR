import 'package:flutter/material.dart';
import 'package:maqe_hr/data/leave_request.dart';

class RequestItem extends StatelessWidget {
  final LeaveRequest request;

  const RequestItem({Key? key, required this.request}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [Text('test')],
      ),
    );
  }
}
