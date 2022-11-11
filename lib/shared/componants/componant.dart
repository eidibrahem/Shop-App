import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../modules/news_app/wepView/wep_view.dart';
import '../../modules/shop_app/login/shop_login_screen.dart';
import '../network/local/cache_helper.dart';
import '../network/local/cache_helper.dart';

Widget buildArticleItem(list, context) => InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => webViews(
              url: list['url'],
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  image: DecorationImage(
                    image: NetworkImage('${list['image']}'),
                    fit: BoxFit.cover,
                  )),
            ),
            SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: Container(
                height: 120.0,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        '${list['title']}',
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                    Text(
                      '${list['publishedAt']}',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
Widget myDivider() => Padding(
      padding: const EdgeInsetsDirectional.only(start: 20.0),
      child: Container(
        width: double.infinity,
        height: 1.0,
        color: Colors.grey[300],
      ),
    );

Widget buildArticleItems(article, context) => InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => webViews(url: article['url'])),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Container(
              width: 120.0,
              height: 120.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  10.0,
                ),
                image: DecorationImage(
                  image: NetworkImage('${article['urlToImage']}'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: Container(
                height: 120.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        '${article['title']}',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      '${article['publishedAt']}',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: 15.0,
            ),
          ],
        ),
      ),
    );

Widget defaultFormFieldX({
  required TextEditingController Controller,
  required TextInputType type,
  BuildContext? context,
  Function? onsubmit(String v)?,
  Function? onchanged(String v)?,
  VoidCallback? suffixpressed,
  VoidCallback? ontap,
  TextStyle? style,
  required String? validator(String? v)?,
  String? label,
  IconData? prefix,
  IconData? suffix,
  bool ispass = false,
  Color? color,
  Color? iconColor,
  Color? hoverColor,
  Color? fillColor,
  Color? prefixIconColor,
  Color? focusColor,
  Color? cursorColor,
}) =>
    TextFormField(
      controller: Controller,
      keyboardType: type,
      onFieldSubmitted: onsubmit,
      onTap: ontap,

      obscureText: ispass,
      onChanged: onchanged,
      validator: validator,
      cursorColor: cursorColor,
      // style:Theme.of(context!).textTheme.bodyText2 ,

      decoration: InputDecoration(
          labelText: label,
          iconColor: iconColor,
          hoverColor: hoverColor,
          focusColor: focusColor,
          fillColor: fillColor,
          prefixIconColor: prefixIconColor,
          border: OutlineInputBorder(),
          prefixIcon: Icon(
            prefix,
          ),
          suffixIcon: IconButton(
            onPressed: suffixpressed,
            icon: Icon(
              suffix,
            ),
          )),
    );

Widget defaultButton(
        {double width = double.infinity,
        Color? background = Colors.blue,
        bool isUperCse = true,
        required void Function()? onPress(),
        required String text,
        double radius = 3.0}) =>
    Container(
        width: width,
        decoration: BoxDecoration(
            color: background, borderRadius: BorderRadius.circular(radius)),
        child: TextButton(
            onPressed: onPress,
            child: Text(
              isUperCse ? text.toUpperCase() : text,
              style: TextStyle(color: Colors.white),
            )));

Widget defaultTextButton({
  required void Function()? onPress(),
  required String text,
}) =>
    TextButton(onPressed: onPress, child: Text(text.toUpperCase()));

void navigatTo(context, Widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => Widget));

void navigatAndFinsh(context, Widget) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => Widget),
      (route) => false,
    );

void ShowToast({required String text, required ToastStates state}) =>
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: ChooseToastColor(state),
        textColor: Colors.white,
        fontSize: 16.0);

enum ToastStates { SUCCESS, ERROR, WARNING }

Color ChooseToastColor(ToastStates? states) {
  Color color = Colors.grey;
  switch (states!) {
    case (ToastStates.SUCCESS):
      color = Colors.green;
      break;
    case (ToastStates.ERROR):
      color = Colors.red;
      break;
    case (ToastStates.WARNING):
      color = Colors.yellow;
      break;
  }
  return color;
}

Widget logout(context) => Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          ' ',
        ),
        Center(
            child: defaultButton(
              width: 100,
                onPress: () {
                  CacheHelper.removeData(key: 'token').then((value)
                 {
                    token = '';
                    name = '';
                    email = '';
                    phone = '';
                    if (value == true) {
                      navigatAndFinsh(context, ShopLoginScreen());
                    }
                  });
                },
                text: 'logout',
                isUperCse: true)),
      ],
    );
void printFullText(String? text) {
  final pattern = RegExp('.{1,25000}');
  pattern.allMatches(text!).forEach((element) => print(element.group(0)));
}

String token = '';

String name = '';
String email = '';
String phone = '';
