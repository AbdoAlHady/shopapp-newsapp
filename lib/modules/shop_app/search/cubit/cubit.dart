import 'package:bmicalc/models/shop_app/search_modal.dart';
import 'package:bmicalc/modules/shop_app/search/cubit/states.dart';
import 'package:bmicalc/shared/networks/remote/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../shared/components/const.dart';
import '../../../../shared/networks/end_points.dart';

class SearchCubit extends Cubit<SearchState>{
  SearchCubit() : super(ShopSearchInitialState());
  static SearchCubit get(context)=>BlocProvider.of(context);

 late SearchModal searchModal;
   void search({required String text}){
     emit(ShopSearchLoadingState());
     DioHelper.postData(url: SEARCH,
         token: token,

         data: {
         'text':text
     }).then((value) {
       searchModal=SearchModal.fromJson(value.data);
       emit(ShopSearchSuccessState());

     }).catchError((error){
       print(error.toString());
       emit(ShopSearchErrorState());
     });
   }

}