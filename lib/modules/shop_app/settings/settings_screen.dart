import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:untitled/layout/shop_app/cubit/cubit.dart';
import 'package:untitled/modules/shop_app/update/update_screen.dart';
import 'package:untitled/shared/componants/componant.dart';

import '../../../models/login_model.dart';
import '../../../shared/network/local/cache_helper.dart';
import '../login/cubit/cubit.dart';
import '../login/cubit/states.dart';
import '../login/shop_login_screen.dart';

class SettingsScreen extends StatelessWidget {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => ShopLoginCubit(),
        child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
            listener: (context, state) {},
            builder: (context, state) {
              if (CacheHelper.getData1(key: 'name') != null) {
                nameController.text = CacheHelper.getData1(key: 'name');
                emailController.text = CacheHelper.getData1(key: 'email');
                phoneController.text = CacheHelper.getData1(key: 'phone');
              }

              print('tttttttttttttttttttttt');

              return SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Form(
                        key: formKey,
                        child: Column(
                          children: [
                            Container(
                              height: 200,
                              child: SettingsList(
                                shrinkWrap: true,
                                contentPadding:
                                    const EdgeInsetsDirectional.all(0),
                                physics: NeverScrollableScrollPhysics(),
                                sections: [
                                  SettingsSection(
                                      title: Text('Common'),
                                      tiles: <SettingsTile>[
                                        SettingsTile.navigation(
                                          leading:
                                              Icon(Icons.language_outlined),
                                          title: Text('Language'),
                                          value: Text('English'),
                                        ),
                                        SettingsTile.switchTile(
                                          initialValue: true,
                                          onToggle: (value) {},
                                          title: Text('Enable ccustom theme'),
                                          leading: Icon(Icons.format_paint),
                                        )
                                      ]),
                                ],
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              height: 1.0,
                              color: Colors.grey[300],
                            ),
                            Container(
                              height: 200,
                              color: Colors.black,
                              child: SettingsList(
                                contentPadding:
                                    const EdgeInsetsDirectional.all(0),
                                physics: NeverScrollableScrollPhysics(),
                                sections: [
                                  SettingsSection(
                                      title: Text('Help And Support'),
                                      tiles: <SettingsTile>[
                                        SettingsTile.navigation(
                                          leading: Icon(Icons.help_center),
                                          title: Text('Help'),
                                        ),
                                        SettingsTile.navigation(
                                          title: Text('Support Mail'),
                                          leading: Icon(Icons.support_outlined),
                                        )
                                      ]),
                                ],
                              ),
                            ),
                            SizedBox(height: 20.0),
                            defaultFormFieldX(
                                Controller: nameController,
                                type: TextInputType.name,
                                validator: (String? value) {
                                  if (value!.isEmpty) {
                                    return 'please enter your name ';
                                  }
                                },
                                label: 'Name',
                                prefix: Icons.contacts_outlined),
                            SizedBox(height: 20.0),
                            defaultFormFieldX(
                                Controller: emailController,
                                type: TextInputType.emailAddress,
                                validator: (String? value) {
                                  if (value!.isEmpty) {
                                    return 'email address must notbe empty ';
                                  }
                                },
                                label: 'Emai Address',
                                prefix: Icons.contact_mail_outlined),
                            SizedBox(height: 20.0),
                            defaultFormFieldX(
                                Controller: phoneController,
                                type: TextInputType.phone,
                                validator: (String? value) {
                                  if (value!.isEmpty) {
                                    return ' phone must notbe empty ';
                                  }
                                },
                                label: 'Phone',
                                prefix: Icons.contact_phone_outlined),
                          ],
                        ),
                      ),
                    ),
                          Container(
                      width: double.infinity,
                      height: 1.0,
                      color: Colors.grey[300],
                    ),
                    InkWell(
                      onTap: () {
                        navigatTo(context, UpdateScreen());
                      },
                      child: Container(
                        color: Colors.grey[300],
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Container(
                            height: 45,
                            child: Row(
                              children: [
                                Icon(Icons.logout),
                                SizedBox(
                                  width: 15,
                                ),
                                Text('Updat Profile'),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                 Container(
                              width: double.infinity,
                              height: 1.0,
                              color: Colors.grey[300],
                            ),

                    Container(
                      width: double.infinity,
                      height: 1.0,
                      color: Colors.grey[400],
                    ),
                    InkWell(
                      onTap: () {
                        CacheHelper.removeData(key: 'token').then((value) {
                          token = '';
                          name = '';
                          email = '';
                          phone = '';
                          if (value == true) {
                            navigatAndFinsh(context, ShopLoginScreen());
                          }
                        });
                      },
                      child: Container(
                        color: Colors.grey[300],
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Container(
                            height: 45,
                            child: Row(
                              children: [
                                Icon(Icons.logout),
                                SizedBox(
                                  width: 15,
                                ),
                                Text('logout'),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              );
            }));
  } //HexColor('#F1F6F9'),
}
// s(context)