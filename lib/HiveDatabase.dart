

import 'package:hive_flutter/adapters.dart';
import 'package:tamrin/LocalDatabase.dart';
import 'package:tamrin/data.dart';

class HiveDatabase extends LocalDatabase<Task>{
  static const String boxName = 'box1';
  Box<Task> box;

  HiveDatabase({required this.box});

  @override
  Future<void> deleteAll() {
    throw UnimplementedError();
  }

  @override
  Future<void> deleteItem(Task item) {
    // TODO: implement deleteItem
    throw UnimplementedError();
  }

  @override
  Future<void> deleteItemById(int key) {
    // TODO: implement deleteItemById
    throw UnimplementedError();
  }

  @override
  Future<List<Task>> getAllData(String searchTerm) async {
    var result= box.values.where((element) {
      return element.content.contains(searchTerm);
    },);
    return result.toList();
  }

  @override
  Future<Task?> getDataById(int id) {
    // TODO: implement getDataById
    throw UnimplementedError();
  }

}