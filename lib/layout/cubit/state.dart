import 'package:untitled1/model/addFavoriteModel.dart';

abstract class HomeStates{}

class HomeInitialState extends HomeStates{}

class HomeNavBarState extends HomeStates{}

class HomeGetBannersSuccessState extends HomeStates{}
class HomeGetBannersErrorState extends HomeStates{}

class HomeGetProductLoadingState extends HomeStates{}
class HomeGetProductSuccessState extends HomeStates{}
class HomeGetProductErrorState extends HomeStates{}

class HomeGetCategoriesLoadingState extends HomeStates{}
class HomeGetCategoriesSuccessState extends HomeStates{}
class HomeGetCategoriesErrorState extends HomeStates{}

class HomePostFavouriteLoadingState extends HomeStates{}
class HomePostFavouriteSuccessState extends HomeStates{}
class HomePostFavoriteErrorState extends HomeStates{}

class HomeChangeFavoriteState extends HomeStates{}

class HomeGetFavoriteLoadingState extends HomeStates{}
class HomeGetFavoriteSuccessState extends HomeStates{}
class HomeGetFavoriteErrorState extends HomeStates{}

class HomeGetCartLoadingState extends HomeStates{}
class HomeGetCartSuccessState extends HomeStates{}
class HomeGetCartErrorState extends HomeStates{}

class HomePostCartLoadingState extends HomeStates{}
class HomePostCartSuccessState extends HomeStates{}
class HomePostCartErrorState extends HomeStates{}

class HomeGetProfileSuccessState extends HomeStates{}
class HomeGetProfileErrorState extends HomeStates{}

class HomePostSearchLoadingState extends HomeStates{}
class HomePostSearchSuccessState extends HomeStates{}
class HomePostSearchErrorState extends HomeStates{}

class HomePutUpdateLoadingState extends HomeStates{}
class HomePutUpdateSuccessState extends HomeStates{}
class HomePutUpdateErrorState extends HomeStates{}

class HomePostAddressLoadingState extends HomeStates{}
class HomePostAddressSuccessState extends HomeStates{}
class HomePostAddressErrorState extends HomeStates{}

class HomePostOrderLoadingState extends HomeStates{}
class HomePostOrderSuccessState extends HomeStates{}
class HomePostOrderErrorState extends HomeStates{}

