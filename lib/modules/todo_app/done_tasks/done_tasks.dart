import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/components/component.dart';
import '../../../shared/cubit/cubit.dart';
import '../../../shared/cubit/states.dart';


class DoneTasksScrees extends StatelessWidget {
  const DoneTasksScrees({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ListView.separated(
          itemBuilder: (context, index) {
            return buildTaskItem(
                AppCubit.get(context).doneTasks[index], context);
          },
          separatorBuilder: (context, index) {
            return Container(
              width: double.infinity,
              height: 1,
              color: Colors.grey[300],
            );
          },
          itemCount: AppCubit.get(context).doneTasks.length,
        );
      },
    );
  }
}
