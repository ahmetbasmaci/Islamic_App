abstract class IFavoriteButtonReadWriteDataSource {
  Future<void> removeItem(String content);
  Future<void> addItem(String content);
}

class FavoriteButtonReadWriteDataSource implements IFavoriteButtonReadWriteDataSource {
  @override
  Future<void> addItem(String content) async {
    //TODO implement
  }

  @override
  Future<void> removeItem(String content) async {
    //TODO implement
  }
}
