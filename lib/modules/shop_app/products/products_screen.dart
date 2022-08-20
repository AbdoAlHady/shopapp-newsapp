import 'package:bmicalc/layout/shop_app/cubit/cubit.dart';
import 'package:bmicalc/layout/shop_app/cubit/states.dart';
import 'package:bmicalc/models/shop_app/categorise_model.dart';
import 'package:bmicalc/models/shop_app/home_models.dart';
import 'package:bmicalc/shared/components/component.dart';
import 'package:bmicalc/shared/styles/colors.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if(state is ShopSuccessChangeFavoritesStates){
          if(!state.modal!.status){
            ShowToast(text: state.modal!.message, state: ToastStates.ERROR);
          }
        }
      },
      builder: (context, state) {
        return ConditionalBuilder(
          condition: ShopCubit.get(context).homeModel != null&&ShopCubit.get(context).categoriseModel!=null,
          builder: (context) => buildHomeItem(ShopCubit.get(context).homeModel,ShopCubit.get(context).categoriseModel,context),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget buildHomeItem(HomeModel? model,CategoriseModel? categorise,context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider(
            items: model!.data.banners.map((e) {
              return Image(
                image: NetworkImage(e.image),
                fit: BoxFit.cover,
              );
            }).toList(),
            options: CarouselOptions(
              height: 250,
              autoPlay: true,
              autoPlayAnimationDuration: const Duration(seconds: 1),
              scrollDirection: Axis.horizontal,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlayCurve: Curves.fastOutSlowIn,
              initialPage: 0,
              autoPlayInterval: const Duration(seconds: 3),
              viewportFraction: 1,
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Categorise",
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 24,
                  ),
                ),
                const SizedBox(height: 10),

                Container(
                  height: 100,
                  child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => buildCategorisItem(categorise!.data.data[index]),
                    separatorBuilder: (context, index) => const SizedBox(
                      width: 10,
                    ),
                    itemCount: categorise!.data.data.length,
                  ),
                ),
                const SizedBox(height: 10),

                const Text(
                  "New Products",
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 24,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Container(
            color: Colors.grey[300],
            child: GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              childAspectRatio: 1 / 1.58,
              crossAxisSpacing: 1,
              mainAxisSpacing: 1.1,
              children: List.generate(model.data.products.length,
                  (index) => buildGridProduct(model.data.products[index],context)),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildGridProduct(ProductModel model,context) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage(model.image),
                height: 200,
              ),
              if (model.discount != 0)
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
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 14, height: 1.3),
                ),
                Row(
                  children: [
                    Text(
                      model.price.toString(),
                      style: const TextStyle(fontSize: 12, color: defaultColor),
                    ),
                    const SizedBox(width: 5),
                    if (model.discount != 0)
                      Text(
                        model.oldPrice.toString(),
                        style: const TextStyle(
                          fontSize: 10,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {
                        ShopCubit.get(context).changeFavorites(model.id);
                        print(model.id.toString());
                      },
                      icon:  CircleAvatar(
                        radius: 14,
                        backgroundColor: ShopCubit.get(context).favorites[model.id]!=false?defaultColor:Colors.grey,
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
          )
        ],
      ),
    );
  }

  Widget buildCategorisItem(DataModel model) => Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
           Image(
            image: NetworkImage(
                model.image),
            width: 100,
            height: 100,
          ),
          Container(
            color: Colors.black.withOpacity(0.8),
            width: 100,
            child:  Text(
              model.name,
              style: const TextStyle(color: Colors.white),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          )
        ],
      );
}
