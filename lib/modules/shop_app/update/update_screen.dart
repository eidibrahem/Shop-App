
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/layout/shop_app/cubit/cubit.dart';
import 'package:untitled/layout/shop_app/cubit/states.dart';
import 'package:untitled/layout/shop_app/shop_layout.dart';
import 'package:untitled/shared/network/local/cache_helper.dart';

import '../../../shared/componants/componant.dart';

class UpdateScreen extends StatelessWidget {
  var formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var nameController = TextEditingController();
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var phoneController = TextEditingController();
    return BlocProvider(
      create: (BuildContext context) => ShopCubit(),
      child: BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {
        
        },
        builder: (context, state) {
           if (CacheHelper.getData1(key: 'name') != null) {
                nameController.text = CacheHelper.getData1(key: 'name');
                emailController.text = CacheHelper.getData1(key: 'email');
                phoneController.text = CacheHelper.getData1(key: 'phone');
              }

          return Scaffold(
            appBar: AppBar(
              title: Text('Updat Profile',),

            ),
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
                          'Edit profile',
                          style:
                              Theme.of(context).textTheme.headline4?.copyWith(
                                    color: Colors.black,
                                  ),
                        ),
                        Text(
                          'Edit profile now to browse our hot ofers',
                          style:
                              Theme.of(context).textTheme.bodyText1?.copyWith(
                                    color: Colors.grey,
                                  ),
                        ),
                        defaultFormFieldX(
                          Controller: nameController,
                          type: TextInputType.emailAddress,
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'please enter your Name ';
                            }
                          },
                          color: Colors.black,
                          label: 'Name',
                          prefix: Icons.contacts_outlined,
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
                          prefix: Icons.contact_mail_outlined,
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        defaultFormFieldX(
                        
                          Controller: passwordController,
                          ispass: ShopCubit.get(context).ispass,
                          type: TextInputType.visiblePassword,
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'password is to short ';
                            }
                          },
                          color: Colors.black,
                          label: 'password',
                          prefix: Icons.lock_person_outlined,
                          suffix: ShopCubit.get(context).suffix,
                          suffixpressed: () {
                            ShopCubit.get(context).changePasssVisibility();
                          },
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        defaultFormFieldX(
                          Controller: phoneController,
                          type: TextInputType.emailAddress,
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'please enter your Phone';
                            }
                          },
                          color: Colors.black,
                          label: 'Phone',
                          prefix: Icons.contact_phone_outlined,
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                       defaultButton(
                              onPress: () {
                                if (formkey.currentState!.validate()) {
                                 
                                  CacheHelper.saveData(
                                      key: 'email',
                                      value: emailController.text);
                                       CacheHelper.saveData(
                  key: 'name', value:nameController.text
                  );

              CacheHelper.saveData(
                  key: 'phone', value: phoneController.text).then((value) => {
                     ShopCubit.get(context).emitState1(),
                     ShowToast(
                  text: 'Updated Successfly ', state: ToastStates.SUCCESS),
                  navigatAndFinsh(context,ShopLayout(token) )
                  });
                                }
                              },
                              text: 'UPDATE',
                              isUperCse: true),
                         
                        SizedBox(
                          height: 15.0,
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
