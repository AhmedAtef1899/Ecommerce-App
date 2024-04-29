import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/layout/cubit/state.dart';
import 'package:untitled1/model/GetFovriteModel.dart';
import 'package:untitled1/model/addFavoriteModel.dart';
import 'package:untitled1/model/bannerModel.dart';
import 'package:untitled1/model/categoriesModel.dart';
import 'package:untitled1/model/getCartModel.dart';
import 'package:untitled1/model/getProfileModel.dart';
import 'package:untitled1/model/loginmodel.dart';
import 'package:untitled1/model/postAddresses.dart';
import 'package:untitled1/model/postCartModel.dart';
import 'package:untitled1/model/productModel.dart';
import 'package:untitled1/model/searchModel.dart';
import 'package:untitled1/modules/cart/cart.dart';
import 'package:untitled1/modules/categories.dart';
import 'package:untitled1/modules/favorite/favorite.dart';
import 'package:untitled1/modules/product/products.dart';
import 'package:untitled1/modules/search/search.dart';
import 'package:untitled1/shared/constants.dart';
import 'package:untitled1/shared/endPoints.dart';
import 'package:untitled1/shared/network/dioHelper.dart';

class HomeCubit extends Cubit<HomeStates>
{
  HomeCubit() : super(HomeInitialState());

  static HomeCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<BottomNavigationBarItem> bottomBar =
  [
    const BottomNavigationBarItem(
     label: 'Home',
      icon: Icon(
        CupertinoIcons.home,
      ),
    ),
    const BottomNavigationBarItem(icon: Icon(
      Icons.category_outlined,
      ),
        label: 'Categories'
    ),
    const BottomNavigationBarItem(icon: Icon(
        CupertinoIcons.search
      ),
        label: 'Search'
    ),
    const BottomNavigationBarItem(icon: Icon(
      Icons.favorite_border
      ),
        label: 'Favorite'
    ),
    const BottomNavigationBarItem(icon: Icon(
      CupertinoIcons.bag,
    ),
        label: 'Cart'
    ),
  ];

  List<Widget> screens =
  [
    ProductScreen(),
    const CategoriesScreen(),
    SearchScreen(),
    const FavoriteScreen(),
    const CartScreen()
  ];

  List <String> appBar = [
    'Arab House',
    'Categories',
    'Search',
    'Favorite',
    'Cart',
  ];


  void navBar(int index)
  {
    currentIndex = index;
    if (index == 0)
      {
        getProduct();
      }
    else if(index == 1)
      {
        getCategories();
      }
    else if(index == 2)
      {

      }
    else if (index == 3)
      {
        getFavorite();
      }
    else if (index == 4)
    {
      getCart();
    }

    emit(HomeNavBarState());
  }


  BannerModel? bannerModel;

  void getBanner() {
    dioHelper.getData(url: BANNERS, token: token).then((value) {
        bannerModel = BannerModel.fromJson(value.data!);
    }).catchError((onError){
      emit(HomeGetBannersErrorState());
    });
  }

  HomeModel? homeModel;

  void getProduct()
  {
    emit(HomeGetProductLoadingState());
    dioHelper.getData(url: HOME,token: token).then((value)
    {
      homeModel = HomeModel.fromJson(value.data);
      getBanner();
      emit(HomeGetProductSuccessState());
    }).catchError((onError){
      print(onError.toString());
      emit(HomeGetProductErrorState());
    });
  }

  CategoriesModels? categoriesModels;

  void getCategories()
  {
    emit(HomeGetCategoriesLoadingState());
    dioHelper.getData(url: CATEGORIES,token: token).then((value)
    {
      categoriesModels = CategoriesModels.fromJson(value.data);
      emit(HomeGetCategoriesSuccessState());
    }).catchError((onError){
      print(onError.toString());
      emit(HomeGetCategoriesErrorState());
    });
  }

  AddFavouriteModel? addFavouriteModel;
  Products? products;
  void postFavorite({
    required int productId
  }) {
    emit(HomePostFavouriteLoadingState());
    dioHelper.postData(url: FAVORITE,token: token, data: {
      'product_id': productId,
    }).then((value) {
      if (products != null) {
        products!.inFavorites = !(products!.inFavorites ?? false);
      }
      addFavouriteModel = AddFavouriteModel.fromJson(value.data);
      getFavorite();
      emit(HomePostFavouriteSuccessState());
    }).catchError((onError){
      print(onError.toString());
      emit(HomePostFavoriteErrorState());
    });
  }

  FavModel? favModel;

  void getFavorite()
  {
    emit(HomeGetFavoriteLoadingState());
    dioHelper.getData(
        url: FAVORITE,
        token: token
    ).then((value) {
      favModel = FavModel.fromJson(value.data);
      emit(HomeGetFavoriteSuccessState());

    }).catchError((onError){
      print(onError.toString());
      emit(HomeGetFavoriteErrorState());
    });
  }

  GetCartModel? getCartModel;
  
  void getCart()
  {
    emit(HomeGetCartLoadingState());
    dioHelper.getData(
        url: CART,
        token: token
    ).then((value) {
      getCartModel = GetCartModel.fromJson(value.data);
      emit(HomeGetCartSuccessState());
    }).catchError((onError){
      print(onError.toString());
      emit(HomeGetCartErrorState());
    });
  }


  PostResponseModel? postResponseModel;
  void postCart({
    required int productId
})
  {
    emit(HomePostCartLoadingState());
    dioHelper.postData(url: CART, data: {
      'product_id' : productId,
    },token: token
    ).then((value){
      if (products != null) {
        products!.inCart = !(products!.inCart ?? false);
      }
      postResponseModel = PostResponseModel.fromJson(value.data);
      getCart();
      emit(HomePostCartSuccessState());
    }).catchError((onError){
      print(onError.toString());
      emit(HomeGetCartErrorState());
    });
  }

  GetProfileModel? getProfileModel;

  void getProfile()
  {
    dioHelper.getData(url: PROFILE,token: token).then((value) {
      getProfileModel = GetProfileModel.fromJson(value.data);
      emit(HomeGetProfileSuccessState());
    }).catchError((onError){
      print(onError.toString());
      emit(HomeGetProductErrorState());
    });
  }

  LoginModel? updateModel;
  void putProfile({
    required String name,
    required String phone,
    required String email,
})
  {
    emit(HomePutUpdateLoadingState());
    dioHelper.putData(url: UPDATE,token: token, data: {
      'name':name,
      'phone':phone,
      'email':email,
    }).then((value){
      updateModel = LoginModel.fromJson(value.data);
      print(updateModel?.data?.token);
      emit(HomePutUpdateSuccessState());
    }).catchError((onError){
      emit(HomePutUpdateErrorState());
    });
  }
  SearchModel? searchModel;

  void postSearch({
    required String text
})
  {
    emit(HomePostSearchLoadingState());
    dioHelper.postData(url: SEARCH, data: {
      'text' : text
    }).then((value){
      searchModel = SearchModel.fromJson(value.data);
      emit(HomePostSearchSuccessState());
    }).catchError((onError){
      print(onError.toString());
      emit(HomePostSearchErrorState());
    });
  }

  PostAddresses? postAddresses;

  void postAddress({
    required String name,
    required String city,
    required String region,
    required String details,
    required String notes,
})
  {
    emit(HomePostAddressLoadingState());
    dioHelper.postData(url: ADDRESSES,token: token,
        data: {
          'name' : name,
          'city' : city,
          'region' : region,
          'details' : details,
          'notes' : notes,
        }
    ).then((value){
      postAddresses = PostAddresses.fromJson(value.data);
      emit(HomePostAddressSuccessState());
    }).catchError((onError){
      print(onError.toString());
      emit(HomePostAddressErrorState());
    });
  }

  void postOrder({
    required int addressId,
    required int paymentMethod,
    required bool usePoint,
})
  {
    emit(HomePostOrderLoadingState());
    dioHelper.postData(
        url: ORDER,
        token: token,
        data: {
          'address_id' : addressId,
          'payment_method' : paymentMethod,
          'use_points' : usePoint,
        }
    ).then((value) {

      emit(HomePostOrderSuccessState());
    }).catchError((onError)
    {
      emit(HomePostOrderErrorState());
    });
  }

}