// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project1/constant/components.dart';
import 'package:project1/model/categories.dart';
import 'package:project1/model/favorites.dart';
import 'package:project1/model/get_favorite.dart';
import 'package:project1/model/home_model.dart';
import 'package:project1/network/remote/dio_helper.dart';
import 'package:project1/presentaions/screen/layout/favorites_screen.dart';
import 'package:project1/presentaions/screen/layout/settings_screen.dart';

import '../../../../../model/profile_model.dart';
import '../../cateogrios_screen.dart';
import '../../products_screen.dart';

part 'layout_state.dart';

class LayoutCubit extends Cubit<LayoutState> {
  LayoutCubit() : super(LayoutInitial());

  static LayoutCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  List<Widget> bottomNavBar = const [
    ProductsScreen(),
    CateogriesScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ];

  List<BottomNavigationBarItem> items = const [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: 'HOME'),
    BottomNavigationBarItem(icon: Icon(Icons.apps), label: 'CTEGORIES'),
    BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'favorite'),
    BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'settings'),
  ];

  void changeIndex(int index) {
    currentIndex = index;
    emit(ChangeBottomNavState());
  }

  HomeModel? homeModel;
  Map<dynamic, bool> favorites = {};
  void getHomeDate() {
    emit(HomeLoadingState());

    DioHelper.getData(
      url: 'home',
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      homeModel!.data!.products?.forEach((element) {
        favorites.addAll({
          element.id: element.inFavorites,
        });
      });
      emit(HomeSuccessState());
    }).catchError((error) {
      emit(HomeErrorState(error.toString()));
    });
  }

  CategoriesModel? categoriesModel;
  void getCategoriesDate() {
    emit(CategoriesLoadingState());
    // print('loading done');
    DioHelper.getData(url: 'categories', token: token).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(SuccessCategoriesState());
    }).catchError((error) {
      emit(ErrorCategoriesState(error.toString()));
      print('this is my error' + error.toString());
    });
  }

  FavoritesModel? favoritesModel;

  void cahngeFavorites(int? productsId) {
    favorites[productsId] != favorites[productsId];
    DioHelper.getData(
      url: 'home',
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      homeModel!.data!.products?.forEach((element) {
        favorites.addAll({
          element.id: element.inFavorites,
        });
      });
      emit(HomeSuccessState());
    });

    DioHelper.postData(
      url: 'favorites',
      data: {
        'product_id': productsId,
      },
      token: token,
    ).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      print(value.data);
      if (favoritesModel?.status == false) {
        favorites[productsId] != favorites[productsId];
      } else {
        getFavoriteProducts();
      }
      emit(SuccessFavroitersState());
    }).catchError((error) {
      emit(ErrorFavroitersState(error.toString()));
    });
  }

  GetFavoriteModel? getFavoriteModel;

  void getFavoriteProducts() {
    emit(GetFavoriteLoadingState());

    DioHelper.getData(
      url: 'favorites',
      token: token,
    ).then((value) {
      getFavoriteModel = GetFavoriteModel.fromJson(value.data);
      emit(GetFavoriteSuccessState());
    }).catchError((error) {
      emit(GetFavoriteErrorState(error.toString()));
    });
  }

//todo : PROFILE
  ProfileModel? profileModel;
  void getUserData() {
    emit(ProfileLoadingState());
    DioHelper.getData(url: 'profile', token: token).then((value) {
      profileModel = ProfileModel.fromJson(value.data);
      print("hello ${profileModel!.data?.email}");
      emit(ProfileSusscesState(profileModel!));
    }).catchError((onError) {
      print(" THIS IS   PROFILE " + onError.toString());
      emit(ProfileErrorState(onError.toString()));
    });
  }
}
