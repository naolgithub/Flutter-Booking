import 'package:hive/hive.dart';

part 'makeplan_model.g.dart';

@HiveType(typeId: 1)
class MakePlanModel {
  @HiveField(0)
  // final String name;
  String booked_from;

  @HiveField(1)
  // final int age;
  String resourceTitle;

  @HiveField(2)
  String eventTitle;

  // @HiveField(3)
  // String createdAt;

  // @HiveField(4)
  // String updatedAt;
  // @HiveField(5)
  // String phoneNumber;
  MakePlanModel(
    // this.name,
    // this.age,
    this.booked_from,
    this.resourceTitle,
    this.eventTitle,
  );
}
