import 'package:bmicalc/models/shop_app/favorites_modal.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../layout/shop_app/cubit/cubit.dart';
import '../../../layout/shop_app/cubit/states.dart';
import '../../../shared/components/component.dart';
import '../../../shared/styles/colors.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {

      },
      builder: (context, state) {
        return ConditionalBuilder(
          condition: state is ! ShopLoadingGetFavoritesStates,
          builder:(context)=> ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) => buildFavItem(ShopCubit.get(context).favoritesModel!.data.data![index],context),
            separatorBuilder: (context, index) => myDivider(),
            itemCount: ShopCubit.get(context).favoritesModel!.data.data!.length,
          ),
          fallback: (context)=>const Center(
           child:CircularProgressIndicator()
          ),
        );
      },

    );
  }

  Widget buildFavItem(modal,context) =>
      Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          height: 120,
          child: Row(
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                   Image(
                    image: NetworkImage(
                        modal!.product!.image.toString()),
                    height: 120,
                    width: 120,
                    fit: BoxFit.cover,
                  ),
                  if (modal.product!.discount != 0)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      color: Colors.red,
                      child: const Text(
                        "DISCOUNT",
                        style: TextStyle(color: Colors.white, fontSize: 10),
                      ),
                    )
                ],
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      modal.product!.name.toString(),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 14, height: 1.3),
                    ),
                    Spacer(),
                    Row(
                      children: [
                        Text(
                          "${modal.product!.price}",
                          style: const TextStyle(
                              fontSize: 12, color: defaultColor),
                        ),
                        const SizedBox(width: 5),
                        if (modal.product!.discount != 0)
                          Text(
                            "${modal.product!.oldPrice}",
                            style: const TextStyle(
                              fontSize: 10,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        const Spacer(),
                        IconButton(
                          onPressed: () {
                            ShopCubit.get(context).changeFavorites(modal.product!.id!.toInt());
                            //print(model.id.toString());
                          },
                          icon:  CircleAvatar(
                            radius: 14,
                            backgroundColor: ShopCubit.get(context).favorites[modal.product!.id] !=false?defaultColor:Colors.grey ,
                            child: const Icon(
                              Icons.favorite_border,
                              size: 15,
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );


}

