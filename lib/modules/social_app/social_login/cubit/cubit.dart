import 'package:bmicalc/modules/social_app/social_login/cubit/states.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class SocialLoginCubit extends Cubit<SocialLoginStates> {
  SocialLoginCubit() : super(SocialLoginInitialState());

  static SocialLoginCubit get(context) => BlocProvider.of(context);

  void userLogin({required String email,required String password}) {
    emit(SocialLoginLoadinglState());
   FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password).then((value) {
      print(value.user?.uid);
      print(value.user?.email);

      emit(SocialLoginSuccesslState());
    }).catchError((error){
      emit(SocialLoginErrorlState(error.toString()));
    });
  }


  IconData suffix=Icons.visibility;
  bool isPassword=true;
  void changePasswordVisibility(){
    isPassword=!isPassword;
    suffix= isPassword?Icons.visibility :Icons.visibility_off_outlined;
    emit(SocialLoginChangePasswordVisibility());
  }

}
