



import 'package:hive/hive.dart';


part 'contact.g.dart';


@HiveType(typeId: 1)
class Contact {
  @HiveField(0)
  String name;
  @HiveField(1)
  String address;

  Contact(this.name, this.address);
}