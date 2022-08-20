import 'package:bmicalc/shared/components/component.dart';
import 'package:bmicalc/shared/components/const.dart';
import 'package:bmicalc/shared/cubit/states.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/cubit/cubit.dart';



class NewTasksScreen extends StatelessWidget {
  const NewTasksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConditionalBuilder(
      condition: AppCubit.get(context).newTasks.isNotEmpty,
      builder: (context) => BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return ListView.separated(
            itemBuilder: (context, index) {
              return buildTaskItem(
                  AppCubit.get(context).newTasks[index], context);
            },
            separatorBuilder: (context, index) {
              return Container(
                width: double.infinity,
                height: 1,
                color: Colors.grey[300],
              );
            },
            itemCount: AppCubit.get(context).newTasks.length,
          );
        },
      ),
      fallback: (context) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(
              Icons.menu,
              size: 100,
              color: Colors.grey,
            ),
            Text(
              "No Task Yet, Please Add Some Task",
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
