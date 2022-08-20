

//https://newsapi.org/v2/everything?q=apple&apiKey=330450d5ca2a4142ab73943340aef00b

import 'package:bmicalc/shared/components/component.dart';

import '../../modules/shop_app/login_screen/login_screen.dart';
import '../networks/local/cache_helper.dart';

void signOut(context){
  CacheHelper.removeData(key: 'token').then((value){
    if(value ==true){
      navigateAndFinish(context: context,widget: ShopLoginScreen());
    }
  });
}
// TextButton(
// onPressed: (){
// CacheHelper.removeData(key: 'token').then((value){
// if(value ==true){
// navigateAndFinish(context: context,widget: ShopLoginScreen());
// }
// });
// },
// child: Text("SIGN OUT"),
// ),

String? token='';
