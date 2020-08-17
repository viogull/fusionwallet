import 'package:fusion_wallet/core/models.dart';


/// notifications : [{"_id":"5f327b011b36ce000cdcefe8","title":"Title","message":"To all recepients","notification_id":"e197c052-e30b-49e3-8cb1-1e546f809f32","created":"2020-08-11T11:03:29.940Z","__v":0}]

class AdminNotificationsResponse {
  List<AdminNotification> notifications;

  AdminNotificationsResponse({
      this.notifications});

  AdminNotificationsResponse.fromJson(dynamic json) {
    if (json["notifications"] != null) {
      notifications = [];
      json["notifications"].forEach((v) {
        notifications.add(AdminNotification.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (notifications != null) {
      map["notifications"] = notifications.map((v) => v.toJson()).toList();
    }
    return map;
  }

}