import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:untitled/layout/shop_app/shop_layout.dart';
import 'package:untitled/modules/shop_app/login/cubit/cubit.dart';
import 'package:untitled/modules/shop_app/login/cubit/states.dart';
import 'package:untitled/modules/shop_app/shop_regester/shop_regester_screen.dart';
import 'package:untitled/shared/network/local/cache_helper.dart';

import '../../../shared/componants/componant.dart';

class ShopLoginScreen extends StatelessWidget {
  var formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    return BlocProvider(
      create: (BuildContext context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
        listener: (context, state) {
          if (state is ShopLoginSucccessState) {
            if (state.loginMoDel?.status == true) {
              print(state.loginMoDel?.message);
              print(state.loginMoDel?.data!.token);
              ShowToast(
                  text: state.loginMoDel!.message, state: ToastStates.SUCCESS);
              CacheHelper.saveData(
                      key: 'token', value: state.loginMoDel?.data!.token)
                  .then((value) => navigatAndFinsh(
                      context, ShopLayout(state.loginMoDel?.data!.token)));
              CacheHelper.saveData(
                  key: 'name', value: state.loginMoDel?.data!.name);

              CacheHelper.saveData(
                  key: 'phone', value: state.loginMoDel?.data!.phone);
            } else {
              print(state.loginMoDel?.message);
              ShowToast(
                  text: state.loginMoDel!.message, state: ToastStates.ERROR);
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'LOGIN',
                          style:
                              Theme.of(context).textTheme.headline4?.copyWith(
                                    color: Colors.black,
                                  ),
                        ),
                        Text(
                          'Login now to browse our hot ofers',
                          style:
                              Theme.of(context).textTheme.bodyText1?.copyWith(
                                    color: Colors.grey,
                                  ),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        defaultFormFieldX(
                          Controller: emailController,
                          type: TextInputType.emailAddress,
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'please enter your email address ';
                            }
                          },
                          color: Colors.black,
                          label: 'Email address',
                          prefix: Icons.email,
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        defaultFormFieldX(
                          onsubmit: (value) {
                            if (formkey.currentState!.validate()) {
                              ShopLoginCubit.git(context).userLogin(
                                  email: emailController.text,
                                  password: passwordController.text);
                            }
                          },
                          Controller: passwordController,
                          ispass: ShopLoginCubit.git(context).ispass,
                          type: TextInputType.visiblePassword,
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'password is to short ';
                            }
                          },
                          color: Colors.black,
                          label: 'password',
                          prefix: Icons.lock_outline,
                          suffix: ShopLoginCubit.git(context).suffix,
                          suffixpressed: () {
                            ShopLoginCubit.git(context).changePasssVisibility();
                          },
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        ConditionalBuilder(
                          condition: state is! ShopLogLodingState,
                          builder: (context) => defaultButton(
                              onPress: () {
                                if (formkey.currentState!.validate()) {
                                  ShopLoginCubit.git(context).userLogin(
                                      email: emailController.text,
                                      password: passwordController.text);
                                  CacheHelper.saveData(
                                      key: 'email',
                                      value: emailController.text);
                                }
                              },
                              text: 'login',
                              isUperCse: true),
                          fallback: (context) =>
                              Center(child: CircularProgressIndicator()),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Don\'t have an account?  '),
                              defaultTextButton(
                                  onPress: () {
                                    navigatTo(context, ShopRegesterScreen());
                                  },
                                  text: 'regester'),
                            ])
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
