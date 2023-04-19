// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:uuid/uuid.dart';

class Todo {
  final String id;
  final String title;
  final String description;
  final String createdAt;
  final String? status;
  Todo({
    required this.title,
    required this.description,
    required this.createdAt,
    this.status,
  }) : id = const Uuid().v4();
}

/**Home Screen -> List TODOs, bottom Sheet - Filters , Tab Bar - Categories -> Categories - Completed, Pending, iN Progress -> Filters -> Created_at, Status, Label
Add Screen -> Seprate Screen -> Todo Label, Category .
Edit Sceen ->  Notes need to be  Modified. */