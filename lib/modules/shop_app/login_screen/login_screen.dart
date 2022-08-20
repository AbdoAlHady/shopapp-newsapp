import 'package:bmicalc/layout/shop_app/shop_layout.dart';
import 'package:bmicalc/modules/shop_app/login_screen/cubit/cubit.dart';
import 'package:bmicalc/modules/shop_app/login_screen/cubit/states.dart';
import 'package:bmicalc/modules/shop_app/register_screen/shop_register_screen.dart';
import 'package:bmicalc/shared/components/component.dart';
import 'package:bmicalc/shared/networks/local/cache_helper.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '';
import 'package:flutter/material.dart';

import '../../../shared/components/const.dart';

class ShopLoginScreen extends StatelessWidget {
  ShopLoginScreen({Key? key}) : super(key: key);
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
        listener: (context, state) {
          if (state is ShopLoginSuccesslState) {
            if (state.loginModel.status == true) {
              print(state.loginModel.message);
              print(state.loginModel.data!.token);
              CacheHelper.saveData(
                      key: 'token', value: state.loginModel.data!.token)
                  .then((value) {
                    token=state.loginModel.data!.token;
                navigateAndFinish(context: context, widget: const ShopLayout());
              });
            } else {
              print(state.loginModel.message);
              ShowToast(
                  text: '${state.loginModel.message}',
                  state: ToastStates.ERROR);
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("LOGIN",
                            style: Theme.of(context)
                                .textTheme
                                .headline4!
                                .copyWith(color: Colors.black)),
                        Text(
                          "Login now to browse our hot offers",
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    color: Colors.grey,
                                  ),
                        ),
                        const SizedBox(height: 30.0),
                        defaultFormField(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          validate: (value) {
                            if (value.isEmpty) {
                              return 'please enter your email address';
                            }
                            return null;
                          },
                          label: 'Email Address',
                          prefix: Icons.email_outlined,
                        ),
                        const SizedBox(height: 15),
                        defaultFormField(
                            controller: passwordController,
                            type: TextInputType.visiblePassword,
                            validate: (value) {
                              if (value.isEmpty) {
                                return 'please enter your password';
                              }
                              return null;
                            },
                            isPassword: ShopLoginCubit.get(context).isPassword,
                            label: 'Password',
                            prefix: Icons.lock_outline,
                            sufix: ShopLoginCubit.get(context).suffix,
                            sufixPressed: () {
                              ShopLoginCubit.get(context)
                                  .changePasswordVisibility();
                            },
                            onSubmit: (value) {
                              if (formKey.currentState!.validate()) {
                                ShopLoginCubit.get(context).userLogin(
                                    email: emailController.text,
                                    password: passwordController.text);
                              }
                            }),
                        const SizedBox(height: 30),
                        ConditionalBuilder(
                          condition: state is! ShopLoginLoadinglState,
                          builder: (BuildContext context) {
                            return defaultButton(
                              function: () {
                                if (formKey.currentState!.validate()) {
                                  ShopLoginCubit.get(context).userLogin(
                                      email: emailController.text,
                                      password: passwordController.text);
                                }
                              },
                              text: 'login',
                              isUpperCase: true,
                            );
                          },
                          fallback: (BuildContext context) =>
                              Center(child: CircularProgressIndicator()),
                        ),
                        const SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            const Text("Don't have an account?"),
                            defaultTextButton(
                              function: () {
                                navigateTo(
                                    context: context,
                                    widget:  ShopRegisterScreen());
                              },
                              text: 'register',
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
