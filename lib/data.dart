

import 'package:hive_flutter/adapters.dart';


part 'data.g.dart';


@HiveType(typeId: 1)
class Task extends HiveObject{
  @HiveField(1)
  late int id;
  @HiveField(2)
  late String title;
  @HiveField(3)
  late String content;
  @HiveField(4)
  late bool isFinish;

  Task({required this.id,required this.title,required this.content,required this.isFinish});
}