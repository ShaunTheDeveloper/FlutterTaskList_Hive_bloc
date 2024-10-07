


import 'package:flutter/cupertino.dart';
import 'package:tamrin/LocalDatabase.dart';

import 'Repository.dart';
import 'data.dart';

class RepositoryImpl extends ChangeNotifier implements Repository<Task>{
  LocalDatabase<Task> localDatabase;

  RepositoryImpl({required this.localDatabase});


  @override
  Future<void> deleteAll() {
    return localDatabase.deleteAll();

  }

  @override
  Future<void> deleteItem(Task item) {
    return localDatabase.deleteItem(item);
  }

  @override
  Future<void> deleteItemById(int key) {
    return localDatabase.deleteItemById(key);
  }

  @override
  Future<List<Task>> getAllData(String searchTerm)async {
    var list = localDatabase.getAllData(searchTerm);
    return list;
  }

  @override
  Future<Task?> getDataById(int id) {
    return localDatabase.getDataById(id);
  }


}