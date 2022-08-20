
import 'package:bmicalc/shared/components/component.dart';
import 'package:bmicalc/shared/components/const.dart';
import 'package:bmicalc/shared/cubit/cubit.dart';
import 'package:bmicalc/shared/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:intl/intl.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

class HomeLayout extends StatelessWidget {
  HomeLayout({Key? key}) : super(key: key);

  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();

  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AppCubit>(
      create: (context) => AppCubit()..createDataBase(),
      child: BlocConsumer<AppCubit, AppStates>(listener: (context, state) {
        if (state is AppInserDataBaseState) {
          Navigator.pop(context);
          timeController.text = "";
          titleController.text = "";
          dateController.text = "";
        }
      }, builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);
        return Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            title: Text(cubit.titles[cubit.currentIndex]),
          ),
          body: ConditionalBuilder(
            condition: state is! AppGetDataBaseLoadingState,
            builder: ((context) => cubit.screens[cubit.currentIndex]),
            fallback: (context) =>
                Center(child: const CircularProgressIndicator()),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              if (cubit.isBottomSheetShown) {
                if (formKey.currentState!.validate()) {
                  cubit.insertToDataBase(
                      title: titleController.text,
                      time: timeController.text,
                      date: dateController.text);
                }
              } else {
                scaffoldKey.currentState!
                    .showBottomSheet(
                      (context) => Container(
                        padding: const EdgeInsets.all(20),
                        child: Form(
                          key: formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              defaultFormField(
                                controller: titleController,
                                type: TextInputType.text,
                                validate: (value) {
                                  if (value.isEmpty) {
                                    return "title must not be empty";
                                  }
                                  return null;
                                },
                                label: "Task Title",
                                prefix: Icons.title,
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              defaultFormField(
                                controller: timeController,
                                type: TextInputType.datetime,
                                onTap: () {
                                  showTimePicker(
                                          context: context,
                                          initialTime: TimeOfDay.now())
                                      .then((value) {
                                    timeController.text =
                                        value!.format(context).toString();
                                  });
                                },
                                validate: (value) {
                                  if (value.isEmpty) {
                                    return "time must not be empty";
                                  }
                                  return null;
                                },
                                label: "Task Time",
                                prefix: Icons.watch_later_outlined,
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              defaultFormField(
                                controller: dateController,
                                type: TextInputType.datetime,
                                onTap: () {
                                  showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime.parse("2022-05-03"),
                                  ).then((value) {
                                    dateController.text =
                                        DateFormat.yMMMd().format(value!);
                                  });
                                },
                                validate: (value) {
                                  if (value.isEmpty) {
                                    return "date must not be empty";
                                  }
                                  return null;
                                },
                                label: "Task Date",
                                prefix: Icons.calendar_today,
                              ),
                            ],
                          ),
                        ),
                      ),
                      elevation: 15,
                    )
                    .closed
                    .then((value) {
                  cubit.changeBottomShettState(isShow: false, icon: Icons.edit);
                });
                cubit.changeBottomShettState(isShow: true, icon: Icons.add);
              }
            },
            child: Icon(cubit.fabIcon),
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: AppCubit.get(context).currentIndex,
            onTap: (index) {
              AppCubit.get(context).changeIndex(index);
              // setState(() {
              //   currentIndex = index;
              // });
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.menu),
                label: "Tasks",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.check_circle_outline),
                label: "Done",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.archive_outlined),
                label: "Archived",
              ),
            ],
          ),
        );
      }),
    );
  }
}
