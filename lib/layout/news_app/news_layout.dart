import 'package:bmicalc/layout/news_app/cubit/cubit.dart';
import 'package:bmicalc/layout/news_app/cubit/states.dart';
import 'package:bmicalc/shared/components/component.dart';
import 'package:bmicalc/shared/cubit/cubit.dart';
import 'package:bmicalc/shared/networks/remote/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../modules/news_app/search/search_screen.dart';

class NewsLayout extends StatelessWidget {
  const NewsLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = NewsCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: const Text("News App"),
              actions: [
                IconButton(
                  onPressed: () {
                    navigateTo(context: context,widget: SearchScreen());
                  },
                  icon: const Icon(Icons.search),
                ),
                IconButton(
                  onPressed: () {
                    AppCubit.get(context).changeThemeMode();
                  },
                  icon:  const Icon(Icons.brightness_4_outlined),
                ),
              ],
            ),
            body: cubit.screens[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.changeBottomNavBAr(index);
              },
              items: cubit.bottomItems,
            ),
          );
        });
  }
}
