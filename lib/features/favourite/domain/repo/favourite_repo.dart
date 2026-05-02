abstract class FavouriteRepo {
  Future<void> toggleFavourite(String productId);
  Stream<List<String>> getFavourites();
}