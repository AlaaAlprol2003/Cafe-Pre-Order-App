abstract class FavouriteState {}

class FavouriteLoading extends FavouriteState {}

class FavouriteLoaded extends FavouriteState {
  final List<String> ids;

  FavouriteLoaded(this.ids);
}

class FavouriteError extends FavouriteState {
  final String message;

  FavouriteError(this.message);
}