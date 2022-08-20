import 'package:bmicalc/layout/shop_app/cubit/states.dart';
import 'package:bmicalc/models/shop_app/categorise_model.dart';
import 'package:bmicalc/models/shop_app/home_models.dart';
import 'package:bmicalc/models/shop_app/login_model.dart';
import 'package:bmicalc/modules/shop_app/cateogries/cateogries_screen.dart';
import 'package:bmicalc/modules/shop_app/favorites/favorites_screen.dart';
import 'package:bmicalc/modules/shop_app/products/products_screen.dart';
import 'package:bmicalc/modules/shop_app/setting_screen/settings.dart';
import 'package:bmicalc/shared/components/const.dart';
import 'package:bmicalc/shared/networks/end_points.dart';
import 'package:bmicalc/shared/networks/remote/dio_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/shop_app/change_favorites_model.dart';
import '../../../models/shop_app/favorites_modal.dart';

class ShopCubit extends Cubit<ShopStates>{
  ShopCubit() : super(ShopInitialStates());

  static ShopCubit get(context)=>BlocProvider.of(context);
  int currentIndex=0;
  List<Widget>screens=[
    const ProductsScreen(),
    const CategoriesScreen(),
    const FavoritesScreen(),
     SettingsScreen(),
  ];
 void changeBottomNav(int index){
   currentIndex=index;
   emit(ShopChangeNavBarStates());
 }
  HomeModel ?homeModel;

 Map<int ,bool>favorites={};
 void getHomeData(){
   emit(ShopLoadingHomeStates());
   DioHelper.getData(url: HOME,token: token).then((value){

     homeModel=HomeModel.fromJson(value.data);
     // print(homeModel?.data.banners[0].image);

     homeModel?.data.products.forEach((element) {
       favorites.addAll({element.id:element.inFavorites});
     });
     print(favorites.toString());
     emit(ShopSuccessHomeStates());

   }).catchError((error){
     print(error.toString());
     emit(ShopErrorHomeStates());
   });
 }


  CategoriseModel ?categoriseModel;
  void getCategoriseData(){
    DioHelper.getData(url: GET_CATEGORISE,lang: 'en').then((value){

      categoriseModel=CategoriseModel.fromJson(value.data);
      emit(ShopSuccessCategoriseStates()
      );
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorCategoriseStates());
    });
  }

  ChangeFavoritesModal? favoritesModal;

  void changeFavorites(int productId){
    favorites[productId]=!  favorites[productId]!;
    emit(ShopChangeFavoritesStates());
    DioHelper.postData(
        url: FAVORITES,
        token: token,
        data:{
          'product_id':productId,

    }).then((value) {
      favoritesModal=ChangeFavoritesModal.fromJson(value.data);
      print(value.data);
      if(!favoritesModal!.status){
        favorites[productId]=!  favorites[productId]!;

      }
      else{
        getFavoritesData();
      }
      emit(ShopSuccessChangeFavoritesStates(favoritesModal));

    }).catchError((error){
      favorites[productId]=!  favorites[productId]!;
      emit(ShopErrorChangeFavoritesStates());

    });
  }


  FavoritesModel ?favoritesModel;
  void getFavoritesData() {
    emit(ShopLoadingGetFavoritesStates());
    DioHelper.getData(url: FAVORITES, token: token, lang: 'en').then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data) ;
      print(value.data.toString());
      emit(ShopSuccessGetFavoritesStates());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorGetFavoritesStates());
    });
  }


 late ShopLoginModel userModal;
  void getProfileData() {
    emit(ShopLoadingUserDataStates());
    DioHelper.getData(url: PROFILE, token: token, lang: 'en').then((value) {
      userModal = ShopLoginModel.fromJson(value.data) ;
      print(userModal.data!.name.toString());
      emit(ShopSuccessUserDataStates());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorUserDataStates());
    });
  }

  void getUpdateData({required String name,required String email, required String phone}) {
    emit(ShopLoadingUpdateStates());
    DioHelper.putData(url: UPDATE_PROFILE, token: token, lang: 'en',data: {
      'name':name,
      'email':email,
      'phone':phone

    }).then((value) {
      userModal = ShopLoginModel.fromJson(value.data) ;
      print(userModal.data!.name.toString());
      emit(ShopSuccessUpdateStates(userModal));
    }).catchError((error) {
      print(error.toString());

      emit(ShopErrorUpdateStates());
    });
  }
}