


abstract class Repository<T>{

  Future<List<T>> getAllData(String searchTerm);

  Future<T?> getDataById(int id);

  Future<void> deleteItem(T item);

  Future<void> deleteItemById(int key);

  Future<void> deleteAll();

}