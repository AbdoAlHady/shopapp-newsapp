import 'package:bmicalc/modules/social_app/social_register/cubit/states.dart';
import 'package:bmicalc/shared/networks/remote/dio_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../shared/networks/end_points.dart';

class SocialRegisterCubit extends Cubit<SocialRegisterStates> {
  SocialRegisterCubit() : super(SocialRegisterInitialState());

  static SocialRegisterCubit get(context) => BlocProvider.of(context);


  void userRegister({required String email,required String password,required String name,required String phone}) {
    emit(SocialRegisterLoadinglState());


    FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password).then((value){
      print(value.user!.email);
      print(value.user!.uid);
      emit(SocialRegisterSuccesslState());
    }).catchError((error){
      emit(SocialRegisterErrorlState(error));

    });
  }



  IconData suffix=Icons.visibility;
  bool isPassword=true;
  void changePasswordVisibility(){
    isPassword=!isPassword;
    suffix= isPassword?Icons.visibility :Icons.visibility_off_outlined;
    emit(SocialRegisterChangePasswordVisibility());
  }

}
