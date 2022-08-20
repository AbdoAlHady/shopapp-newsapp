import 'package:bmicalc/models/shop_app/login_model.dart';
import 'package:bmicalc/modules/shop_app/Register_screen/cubit/states.dart';
import 'package:bmicalc/shared/networks/remote/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../shared/networks/end_points.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStates> {
  ShopRegisterCubit() : super(ShopRegisterInitialState());

  static ShopRegisterCubit get(context) => BlocProvider.of(context);
  ShopLoginModel? RegisterModel;

  void userRegister({required String email,required String password,required String name,required String phone}) {
    emit(ShopRegisterLoadinglState());
    DioHelper.postData(
      url: REGISTER,
      data: {
        'email':email,
        'name':name,
        'phone':phone,
        'password':password,
      },
    ).then((value) {
      print(value.data);
      RegisterModel=ShopLoginModel.fromJson(value.data);
      print(RegisterModel!.status);
      print(RegisterModel!.message);
      print(RegisterModel!.data!.token);
      emit(ShopRegisterSuccesslState(RegisterModel!));
    }).catchError((error){
      emit(ShopRegisterErrorlState(error.toString()));
    });
  }


  IconData suffix=Icons.visibility;
  bool isPassword=true;
  void changePasswordVisibility(){
    isPassword=!isPassword;
    suffix= isPassword?Icons.visibility :Icons.visibility_off_outlined;
    emit(ShopRegisterChangePasswordVisibility());
  }

}
