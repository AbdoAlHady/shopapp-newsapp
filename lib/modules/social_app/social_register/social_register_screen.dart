
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../shared/components/component.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';
class SocialRegisterScreen extends StatelessWidget {
  SocialRegisterScreen({Key? key}) : super(key: key);
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
   var nameController = TextEditingController();
   var phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
      create: (context) => SocialRegisterCubit(),
      child: BlocConsumer<SocialRegisterCubit,SocialRegisterStates>(
        listener: (context, state) {
          if(state is SocialRegisterSuccesslState) {
            //   if(state.RegisterModel.status!){
            //     CacheHelper.saveData(
            //         key: "token",
            //         value: state.RegisterModel.data!.token
            //     ).then((value){
            //       token=state.RegisterModel.data!.token.toString();
            //       navigateAndFinish(context: context, widget: const SocialLayout());
            //     });
            //   }
            //   else{
            //     print(state.RegisterModel.message!.toString());
            //     showToast(Message: state.RegisterModel.message!, state:ToastStates.ERROR );
            //
            //   }
            //
            // }
          }


        },
        builder: (context, state) {
          return  Scaffold(
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
                        Text("REGISTER",
                            style: Theme.of(context)
                                .textTheme
                                .headline4!
                                .copyWith(color: Colors.black)),
                        Text(
                          "Register now to communicate with friends",
                          style:
                          Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 30.0),

                        defaultFormField(
                          controller: nameController,
                          type: TextInputType.name,
                          validate: (value) {
                            if (value.isEmpty) {
                              return 'please enter your name';
                            }
                            return null;
                          },
                          label: 'Name',
                          prefix: Icons.person,
                        ),
                        const SizedBox(height: 15),
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
                          isPassword: SocialRegisterCubit.get(context).isPassword,
                          label: 'Password',
                          prefix: Icons.lock_outline,
                          sufix: SocialRegisterCubit.get(context).suffix,
                          sufixPressed: () {
                            SocialRegisterCubit.get(context)
                                .changePasswordVisibility();
                          },
                          onSubmit: (value) {


                          },
                        ),
                        const SizedBox(height: 15),

                        defaultFormField(
                          controller: phoneController,
                          type: TextInputType.phone,
                          validate: (value) {
                            if (value.isEmpty) {
                              return 'please enter your phone number';
                            }
                            return null;
                          },
                          label: 'Phone Number',
                          prefix: Icons.email_outlined,
                        ),

                        const SizedBox(height: 30),
                        ConditionalBuilder(
                          condition: state is !SocialRegisterLoadinglState,
                          builder: (BuildContext context) {
                            return defaultButton(
                              function: () {
                                if (formKey.currentState!.validate()) {
                                  SocialRegisterCubit.get(context).userRegister(
                                      email: emailController.text,
                                      password: passwordController.text,
                                    phone: phoneController.text,
                                    name: nameController.text
                                  );
                                  // navigateAndFinish(context: context, widget: const SocialLayout());
                                }
                              },
                              text: 'register ',
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
