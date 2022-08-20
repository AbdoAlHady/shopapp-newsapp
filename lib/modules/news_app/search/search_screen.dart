import 'package:bmicalc/layout/news_app/cubit/cubit.dart';
import 'package:bmicalc/layout/news_app/cubit/states.dart';
import 'package:bmicalc/shared/components/component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var list = NewsCubit.get(context).search;
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: defaultFormField(
                  controller: searchController,
                  type: TextInputType.text,
                  onChange: (value) {
                    NewsCubit.get(context).getSearch(value);
                  },
                  validate: (value) {
                    if (value.isEmpty) {
                      return 'search must not be empty';
                    }
                    return null;
                  },
                  label: "Search",
                  prefix: Icons.search,
                ),
              ),
              Expanded(
                child: buildArticleBuilder(
                  list: list,
                  context: context,
                  isSearch:true,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
