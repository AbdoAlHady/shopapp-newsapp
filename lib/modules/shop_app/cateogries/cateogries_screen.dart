import 'package:bmicalc/layout/shop_app/cubit/cubit.dart';
import 'package:bmicalc/layout/shop_app/cubit/states.dart';
import 'package:bmicalc/models/shop_app/categorise_model.dart';
import 'package:bmicalc/shared/components/component.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context, state) {

      },
      builder:(context, state) {
        return ConditionalBuilder(
          condition: ShopCubit.get(context).categoriseModel!=null,
          builder: (context) {
            return ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) =>
                  buildCateItem(ShopCubit
                      .get(context)
                      .categoriseModel!
                      .data
                      .data[index]),
              separatorBuilder: (context, index) => myDivider(),
              itemCount: ShopCubit
                  .get(context)
                  .categoriseModel!
                  .data
                  .data
                  .length,
            );
          },
          fallback: (BuildContext context) {
            return const Center(child: CircularProgressIndicator());
          },


        );
      }
    );
  }
  Widget buildCateItem(DataModel model){
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children:  [
          Image(
            image: NetworkImage(
                model.image),
            width: 80,
            height: 80,
            fit: BoxFit.cover,
          ),
          const SizedBox(width: 20),
          Text(
            model.name,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const Spacer(),
          const Icon(Icons.arrow_forward_ios_outlined),
        ],
      ),
    );
  }
}
