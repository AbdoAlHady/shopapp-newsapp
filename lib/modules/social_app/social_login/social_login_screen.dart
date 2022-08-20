
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/components/component.dart';
import '../social_register/social_register_screen.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';
class SocialLoginScreeen extends StatelessWidget {
   SocialLoginScreeen({Key? key}) : super(key: key);
  var formKey=GlobalKey<FormState>();
   var emailController = TextEditingController();
   var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>SocialLoginCubit(),
      child: BlocConsumer<SocialLoginCubit,SocialLoginStates>(
        listener: (context, state) {
          if(state is SocialLoginErrorlState){
            showToast(Message: state.error.toString(), state: ToastStates.ERROR);
          }
          else{
            showToast(Message: 'login success', state: ToastStates.SUCCESS);
          }

        },
        builder:  (context, state) {
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
                          "Login now to communicate with friends",
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
                            isPassword: SocialLoginCubit.get(context).isPassword,
                            label: 'Password',
                            prefix: Icons.lock_outline,
                            sufix: SocialLoginCubit.get(context).suffix,
                            sufixPressed: () {
                              SocialLoginCubit.get(context)
                                  .changePasswordVisibility();
                            },
                            onSubmit: (value) {
                              // if (formKey.currentState!.validate()) {
                              //   SocialLoginCubit.get(context).userLogin(
                              //       email: emailController.text,
                              //       password: passwordController.text);
                              // }
                            }),
                        const SizedBox(height: 30),
                        ConditionalBuilder(
                          condition: state is! SocialLoginLoadinglState,
                          builder: (BuildContext context) {
                            return defaultButton(
                              function: () {
                                if (formKey.currentState!.validate()) {
                                  SocialLoginCubit.get(context).userLogin(
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
                                    widget:  SocialRegisterScreen());
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
