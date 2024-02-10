abstract class IFavoriteButtonCheckContentIfFavoriteDataSource {
  Future<bool> checkItemIfFavorite(String content);

}

class FavoriteButtonCheckContentIfFavoriteDataSource implements IFavoriteButtonCheckContentIfFavoriteDataSource {
  @override
  Future<bool> checkItemIfFavorite(String content) async {
    //TODO implement
    return true;
  }
  
}
