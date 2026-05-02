

import '../../domain/repo/favourite_repo.dart';
import '../remote_data_source/favourite_remote_datasource.dart';

class FavouriteRepoImpl implements FavouriteRepo {
  final FavouriteRemoteDataSource remote = FavouriteRemoteDataSource();

  @override
  Future<void> toggleFavourite(String productId) async {
    final currentFavs = await remote.getFavourites().first;

    if (currentFavs.contains(productId)) {
      await remote.removeFavourite(productId);
    } else {
      await remote.addFavourite(productId);
    }
  }

  @override
  Stream<List<String>> getFavourites() {
    return remote.getFavourites();
  }
}