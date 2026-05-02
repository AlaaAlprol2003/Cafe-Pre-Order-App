import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repository/favourite_repo_impl.dart';
import 'favourite_state.dart';

class FavouriteCubit extends Cubit<FavouriteState> {
  final repo = FavouriteRepoImpl();

  FavouriteCubit() : super(FavouriteLoading()) {
    loadFavs();
  }

  void loadFavs() {
    repo.getFavourites().listen(
          (ids) => emit(FavouriteLoaded(ids)),
      onError: (e) => emit(FavouriteError(e.toString())),
    );
  }

  void toggle(String productId) async {
    try {
      await repo.toggleFavourite(productId);
    } catch (e) {
      emit(FavouriteError(e.toString()));
    }
  }
}