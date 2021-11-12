class RequestListItem {
  final DateTime date;
  final String type;

  RequestListItem(this.date, this.type);
}

class LeaveRequest {
  final String status;
  final List<RequestListItem> requestList;

  LeaveRequest(this.status, this.requestList);
}
