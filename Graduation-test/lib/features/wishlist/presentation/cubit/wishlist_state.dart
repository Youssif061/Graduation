part of 'wishlist_cubit.dart';

sealed class WishlistState {
  const WishlistState();
}

final class WishlistInitial extends WishlistState {
  const WishlistInitial();
}

final class WishlistLoading extends WishlistState {
  const WishlistLoading();
}

final class WishlistLoaded extends WishlistState {
  final List<WishlistItemModel> items;
  const WishlistLoaded(this.items);
}

final class WishlistError extends WishlistState {
  final String message;
  const WishlistError(this.message);
}
