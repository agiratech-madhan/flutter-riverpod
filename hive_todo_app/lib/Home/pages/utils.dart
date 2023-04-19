enum Status {
  all,
  pending,
  completed,
}

extension StatusExtension on Status {
  String get status {
    String status;
    switch (this) {
      case Status.pending:
        status = 'Pending';
        break;
      case Status.completed:
        status = "Completed";
        break;
      case Status.all:
        status = "All";
        break;
    }
    return status;
  }
}
