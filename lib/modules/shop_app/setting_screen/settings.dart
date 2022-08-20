import 'package:bmicalc/layout/shop_app/cubit/cubit.dart';
import 'package:bmicalc/layout/shop_app/cubit/states.dart';
import 'package:bmicalc/shared/components/component.dart';
import 'package:bmicalc/shared/components/const.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({Key? key}) : super(key: key);
  var formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var modal = ShopCubit.get(context).userModal;
        emailController.text = modal.data!.email;
        phoneController.text = modal.data!.phone;
        nameController.text = modal.data!.name;
        return ConditionalBuilder(
          condition: ShopCubit.get(context).userModal != null,
          builder: (context) {
            return Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [

                      if(state is ShopLoadingUpdateStates)
                      const LinearProgressIndicator(),
                      const SizedBox(
                        height: 20,
                      ),
                      defaultFormField(
                        controller: nameController,
                        type: TextInputType.name,
                        validate: (value) {
                          if (value.isEmpty) {
                            return "name must not be empty";
                          }
                          return null;
                        },
                        label: "Name",
                        prefix: Icons.person,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      defaultFormField(
                        controller: emailController,
                        type: TextInputType.emailAddress,
                        validate: (value) {
                          if (value.isEmpty) {
                            return "email must not be empty";
                          }
                          return null;
                        },
                        label: "Email Address",
                        prefix: Icons.email,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      defaultFormField(
                        controller: phoneController,
                        type: TextInputType.phone,
                        validate: (value) {
                          if (value.isEmpty) {
                            return "phone must not be empty";
                          }
                          return null;
                        },
                        label: "Phone",
                        prefix: Icons.phone,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      defaultButton(
                          function: () {
                            if (formKey.currentState!.validate()) {
                              ShopCubit.get(context).getUpdateData(
                                  name: nameController.text,
                                  email: emailController.text,
                                  phone: phoneController.text);
                            }
                          },
                          text: "update"),
                      const SizedBox(
                        height: 20,
                      ),
                      defaultButton(
                          function: () => signOut(context), text: "logOut")
                    ],
                  ),
                ),
              ),
            );
          },
          fallback: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
