// ignore_for_file: public_member_api_docs, sort_constructors_first
class AppNotification {
  String title;
  String body;
  DateTime time;
  bool isRead = false;

  AppNotification({
    required this.title,
    required this.body,
    required this.time,
  });
}
