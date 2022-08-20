import 'package:bmicalc/models/shop_app/change_favorites_model.dart';
import 'package:bmicalc/models/shop_app/login_model.dart';

abstract class ShopStates{}

class ShopInitialStates extends ShopStates{}
class ShopChangeNavBarStates extends ShopStates{}
class ShopLoadingHomeStates extends ShopStates{}
class ShopSuccessHomeStates extends ShopStates{}
class ShopErrorHomeStates extends ShopStates{}
class ShopSuccessCategoriseStates extends ShopStates{}
class ShopErrorCategoriseStates extends ShopStates{}
class ShopSuccessChangeFavoritesStates extends ShopStates{
  final  ChangeFavoritesModal? modal;

  ShopSuccessChangeFavoritesStates(this.modal);
}
class ShopChangeFavoritesStates extends ShopStates{}

class ShopErrorChangeFavoritesStates extends ShopStates{}
class ShopSuccessGetFavoritesStates extends ShopStates{}
class ShopLoadingGetFavoritesStates extends ShopStates{}
class ShopErrorGetFavoritesStates extends ShopStates{}


class ShopSuccessUserDataStates extends ShopStates{}
class ShopLoadingUserDataStates extends ShopStates{}
class ShopErrorUserDataStates extends ShopStates{}

class ShopSuccessUpdateStates extends ShopStates{
  final ShopLoginModel loginModel;

  ShopSuccessUpdateStates(this.loginModel);
}
class ShopLoadingUpdateStates extends ShopStates{}
class ShopErrorUpdateStates extends ShopStates{}