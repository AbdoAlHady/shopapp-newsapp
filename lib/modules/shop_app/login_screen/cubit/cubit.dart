import 'package:bmicalc/modules/shop_app/login_screen/cubit/states.dart';
import 'package:bmicalc/shared/networks/remote/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../models/shop_app/login_model.dart';
import '../../../../shared/networks/end_points.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates> {
  ShopLoginCubit() : super(ShopLoginInitialState());

  static ShopLoginCubit get(context) => BlocProvider.of(context);
  ShopLoginModel? loginModel;

  void userLogin({required String email,required String password}) {
    emit(ShopLoginLoadinglState());
    DioHelper.postData(
      url: LOGIN,
      data: {
        'email':email,
        'password':password,
      },
    ).then((value) {
      print(value.data);
      loginModel=ShopLoginModel.fromJson(value.data);
      print(loginModel!.status);
      print(loginModel!.message);
      print(loginModel!.data!.token);
      emit(ShopLoginSuccesslState(loginModel!));
    }).catchError((error){
      emit(ShopLoginErrorlState(error.toString()));
    });
  }


  IconData suffix=Icons.visibility;
  bool isPassword=true;
  void changePasswordVisibility(){
    isPassword=!isPassword;
    suffix= isPassword?Icons.visibility :Icons.visibility_off_outlined;
    emit(ShopLoginChangePasswordVisibility());
  }

}
