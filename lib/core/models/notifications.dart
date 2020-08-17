/// _id : "5f327b011b36ce000cdcefe8"
/// title : "Title"
/// message : "To all recepients"
/// notification_id : "e197c052-e30b-49e3-8cb1-1e546f809f32"
/// created : "2020-08-11T11:03:29.940Z"
/// __v : 0

class Notifications {
  String id;
  String title;
  String message;
  String notificationId;
  String created;
  int v;

  Notifications({
      this.id, 
      this.title, 
      this.message, 
      this.notificationId, 
      this.created, 
      this.v});

  Notifications.fromJson(dynamic json) {
    id = json["_id"];
    title = json["title"];
    message = json["message"];
    notificationId = json["notification_id"];
    created = json["created"];
    v = json["__v"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["_id"] = id;
    map["title"] = title;
    map["message"] = message;
    map["notification_id"] = notificationId;
    map["created"] = created;
    map["__v"] = v;
    return map;
  }

}