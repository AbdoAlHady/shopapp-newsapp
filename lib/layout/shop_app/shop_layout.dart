import 'package:bmicalc/layout/shop_app/cubit/cubit.dart';
import 'package:bmicalc/layout/shop_app/cubit/states.dart';
import 'package:bmicalc/modules/shop_app/login_screen/login_screen.dart';
import 'package:bmicalc/modules/shop_app/search/shop_search.dart';
import 'package:bmicalc/shared/components/component.dart';
import 'package:bmicalc/shared/networks/local/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text('salla'),
            actions: [
              IconButton(onPressed: (){
                  navigateTo(context: context,widget:  ShopSearchScreen());
              },
                icon: const Icon(Icons.search),
              )
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index){
              cubit.changeBottomNav(index);
            },
            currentIndex: cubit.currentIndex,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home'
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.apps),
                  label: 'Categories'
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite),
                  label: 'Favorites'
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings),
                  label: 'Settings'
              ),

            ],
          ),
        );
      },
    );
  }
}
