/// _id : "5f327b011b36ce000cdcefe8"
/// title : "Title"
/// message : "To all recepients"
/// notification_id : "e197c052-e30b-49e3-8cb1-1e546f809f32"
/// created : "2020-08-11T11:03:29.940Z"
/// __v : 0

class FusionNotification {
  String _id;
  String _title;
  String _message;
  String _notificationId;
  String _created;
  int _v;

  String get id => _id;
  String get title => _title;
  String get message => _message;
  String get notificationId => _notificationId;
  String get created => _created;
  int get v => _v;

  FusionNotification({
      String id, 
      String title, 
      String message, 
      String notificationId, 
      String created, 
      int v}){
    _id = id;
    _title = title;
    _message = message;
    _notificationId = notificationId;
    _created = created;
    _v = v;
}

  FusionNotification.fromJson(dynamic json) {
    _id = json["_id"];
    _title = json["title"];
    _message = json["message"];
    _notificationId = json["notification_id"];
    _created = json["created"];
    _v = json["__v"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["_id"] = _id;
    map["title"] = _title;
    map["message"] = _message;
    map["notification_id"] = _notificationId;
    map["created"] = _created;
    map["__v"] = _v;
    return map;
  }

}