part of 'layout_cubit.dart';

@immutable
abstract class LayoutState {}

class LayoutInitial extends LayoutState {}

class ChangeBottomNavState extends LayoutState {}

class HomeLoadingState extends LayoutState {}

class HomeSuccessState extends LayoutState {}

class HomeErrorState extends LayoutState {
  final String error;
  HomeErrorState(this.error);
}

class CategoriesLoadingState extends LayoutState {}

class SuccessCategoriesState extends LayoutState {}

class ErrorCategoriesState extends LayoutState {
  final String error;
  ErrorCategoriesState(this.error);
}

class SuccessFavroitersState extends LayoutState {}

class AddFavroitersState extends LayoutState {}

class ErrorFavroitersState extends LayoutState {
  final String error;
  ErrorFavroitersState(this.error);
}

class GetFavoriteLoadingState extends LayoutState {}

class GetFavoriteSuccessState extends LayoutState {}

class GetFavoriteErrorState extends LayoutState {
  final String error;
  GetFavoriteErrorState(this.error);
}

class ProfileLoadingState extends LayoutState {}

class ProfileSusscesState extends LayoutState {
  ProfileModel profileModel;
  ProfileSusscesState(this.profileModel);
}

class ProfileErrorState extends LayoutState {
  final String error;
  ProfileErrorState(this.error);
}
