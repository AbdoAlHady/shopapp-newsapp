import 'package:bmicalc/models/shop_app/search_modal.dart';
import 'package:bmicalc/modules/shop_app/search/cubit/cubit.dart';
import 'package:bmicalc/modules/shop_app/search/cubit/states.dart';
import 'package:bmicalc/shared/components/component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../layout/shop_app/cubit/cubit.dart';
import '../../../shared/styles/colors.dart';

class ShopSearchScreen extends StatelessWidget {
  ShopSearchScreen({Key? key}) : super(key: key);
  var formKey = GlobalKey<FormState>();
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
              appBar: AppBar(),
              body: Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      defaultFormField(
                        controller: searchController,
                        type: TextInputType.text,
                        validate: (value) {
                          if(value.isEmpty){
                            return 'enter text to search';
                          }
                          return null;
                        },
                        label: "Search",
                        prefix: Icons.search,
                        onSubmit: (value){
                          SearchCubit.get(context).search(text: value) ;
                        }
                      ),
                      SizedBox(height: 10,),
                      if(state is ShopSearchLoadingState)
                        const LinearProgressIndicator(),
                      if(state is ShopSearchSuccessState)
                      Expanded(
                        child: ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) => buildSearchItem(SearchCubit.get(context).searchModal.data!.data![index],context),
                          separatorBuilder: (context, index) => myDivider(),
                          itemCount: SearchCubit.get(context).searchModal.data!.data!.length,
                        ),
                      ),

                    ],
                  ),
                ),
              ));
        },
      ),
    );
  }
  Widget buildSearchItem(Product modal,context) =>
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
                        modal.image.toString()),
                    height: 120,
                    width: 120,
                    fit: BoxFit.cover,
                  ),
                ],
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      modal.name.toString(),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 14, height: 1.3),
                    ),
                    Spacer(),
                    Row(
                      children: [
                        Text(
                          "${modal.price}",
                          style: const TextStyle(
                              fontSize: 12, color: defaultColor),
                        ),
                        const SizedBox(width: 5),
                        const Spacer(),
                        IconButton(
                          onPressed: () {
                            ShopCubit.get(context).changeFavorites(modal.id!.toInt());
                            //print(model.id.toString());
                          },
                          icon:  CircleAvatar(
                            radius: 14,
                            backgroundColor: ShopCubit.get(context).favorites[modal.id] !=false?defaultColor:Colors.grey ,
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
