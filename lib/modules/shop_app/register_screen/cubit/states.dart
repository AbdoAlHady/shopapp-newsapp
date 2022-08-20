import 'package:bmicalc/models/shop_app/login_model.dart';

abstract class ShopRegisterStates{}
class ShopRegisterInitialState extends ShopRegisterStates{}
class ShopRegisterLoadinglState extends ShopRegisterStates{}
class ShopRegisterSuccesslState extends ShopRegisterStates{
  final ShopLoginModel RegisterModel;

  ShopRegisterSuccesslState(this.RegisterModel);
}
class ShopRegisterErrorlState extends ShopRegisterStates{
  final String error;

  ShopRegisterErrorlState(this.error);
}
class ShopRegisterChangePasswordVisibility extends ShopRegisterStates{

}