

import 'package:bmicalc/modules/counter_app/counters_screen/cubit.dart';
import 'package:bmicalc/modules/counter_app/counters_screen/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class CounterScreen extends StatelessWidget {
  CounterScreen({Key? key}) : super(key: key);
  int counter = 0;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<counterCubit>(
      create: (context) => counterCubit(),
      child: BlocConsumer<counterCubit, counterStates>(
        listener: (context, state) {
          if (state is CounterMinusState) {
            print('Minus state : ${state.counter}');
          }
          if (state is CounterPlusState) {
            print('Plus state : ${state.counter}');
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Counter screen"),
            ),
            body: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                      onPressed: () {
                        counterCubit.get(context).minus();
                      },
                      child: Text("Minus")),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    "${counterCubit.get(context).counter}",
                    style: const TextStyle(
                        fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  TextButton(
                      onPressed: () {
                        counterCubit.get(context).plus();
                      },
                      child: const Text("Plus")),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
