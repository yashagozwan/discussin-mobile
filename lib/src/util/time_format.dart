import 'package:timeago/timeago.dart' as timeago;

String timeFormat(int createdAt) {
  final timestamp = DateTime.fromMillisecondsSinceEpoch(createdAt);
  return timeago.format(timestamp);
}
