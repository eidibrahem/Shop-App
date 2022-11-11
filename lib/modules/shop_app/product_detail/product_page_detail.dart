import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/layout/shop_app/cubit/states.dart';
import 'package:untitled/models/home_moodel.dart';

import '../../../layout/shop_app/cubit/cubit.dart';
import '../../../shared/styles/colors.dart';
import '../../../shared/styles/styles.dart';

class ProductPageDetail extends StatelessWidget {
  const ProductPageDetail(this.model, {Key? key}) : super(key: key);
  final Products model;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: ((context, state) {}),
      builder: (context, state) {
        var cubit = ShopCubit.get(context);

        return Scaffold(
          appBar: AppBar(
            shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(15), ) ,
            backgroundColor: Colors.red,
            title: Text(model.name.toString(),maxLines: 1,overflow: TextOverflow.fade),
            leading: Builder(builder: ((context) {
              return InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Icon(Icons.arrow_back,color: Colors.white,),
              );
            })),
            actions: [
             
              IconButton(
                  onPressed: () {
                    ShopCubit.get(context).ChangeFavorites(model.id);
                  },
                  icon: CircleAvatar(
                    radius: 15.0,
                    backgroundColor:
                        ShopCubit.get(context).favorites![model.id]!
                            ? Colors.black.withOpacity(.6)
                            : Colors.white,
                    child: Icon(
                      Icons.star_purple500_sharp,
                      color: ShopCubit.get(context).favorites![model.id]!
                          ? Colors.yellow
                          : Colors.grey,
                    ),
                  ))
            ],
          ),
          body: SafeArea(child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            colors: [
              Color(0xfffbfbfb),
              Color(0xfff7f7f7),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          )),
          
          child:Stack(
            children: [
              

               Column(
                children: <Widget>[
                  Stack(
                    alignment: Alignment.bottomCenter,
                    children: <Widget>[
                      TitleText(
                        text: "AIP",
                        fontSize: 160,
                        color: LightColor.lightGrey,
                      ),
                     
                     Image(image: NetworkImage(model.image.toString(),),fit: BoxFit.cover,)
                    ],
                  ),
                  // _categoryWidget(),
                ],
              ),
              DraggableScrollableSheet(
                maxChildSize: .8,
                initialChildSize: .53,
                minChildSize: .53,
                builder: (context, scrollController) {
                  return Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40),
                        ),
                        color: Colors.white),
                    child: SingleChildScrollView(
                      controller: scrollController,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          SizedBox(height: 5),
                          Container(
                            alignment: Alignment.center,
                            child: Container(
                              width: 50,
                              height: 5,
                              decoration: BoxDecoration(
                                  color: LightColor.iconColor,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                            ),
                          ),
                          SizedBox(height: 10),
                          Container(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  width: 250,
                                  child: TitleText(
                                      text: model.name.toString(), fontSize: 25),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        TitleText(
                                          text: "\$ ",
                                          fontSize: 18,
                                          color: LightColor.red,
                                        ),
                                        TitleText(
                                          text: "${model.price.round()}",
                                          fontSize: 25,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Icon(Icons.star,
                                            color: LightColor.yellowColor,
                                            size: 17),
                                        Icon(Icons.star,
                                            color: LightColor.yellowColor,
                                            size: 17),
                                        Icon(Icons.star,
                                            color: LightColor.yellowColor,
                                            size: 17),
                                        Icon(Icons.star,
                                            color: LightColor.yellowColor,
                                            size: 17),
                                        Icon(Icons.star_border, size: 17),
                                      ],
                                    ),
                                  ],
                                ),
                                ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              TitleText(
                                text: "Available Size",
                                fontSize: 14,
                              ),
                              SizedBox(height: 20),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  sizeWidget("US 6"),
                                  sizeWidget("US 7", isSelected: true),
                                  sizeWidget("US 8"),
                                  sizeWidget("US 9"),
                                ],
                              )
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          availableColor(),
                          SizedBox(
                            height: 20,
                          ),
                          description(model.description),
                        ],
                      ),
                    ),
                  );
                },
              ),

              
            ],

          ) ,
          
          
          ) ),
      
        );
      },
    );
  }

  Widget description(String? description) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TitleText(
          text: "description",
          fontSize: 14,
        ),
        SizedBox(height: 20),
      Text(description.toString()),
      ],
    );
  }

   Widget availableColor() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TitleText(
          text: "Available Color",
          fontSize: 14,
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            colorWidget(LightColor.yellowColor, isSelected: true),
            SizedBox(
              width: 30,
            ),
            colorWidget(LightColor.lightBlue),
            SizedBox(
              width: 30,
            ),
            colorWidget(LightColor.black),
            SizedBox(
              width: 30,
            ),
            colorWidget(LightColor.red),
            SizedBox(
              width: 30,
            ),
            colorWidget(LightColor.skyBlue),
          ],
        )
      ],
    );
  }
   Widget colorWidget(Color color, {bool isSelected = false}) {
    return CircleAvatar(
      radius: 12,
      backgroundColor: color.withAlpha(150),
      child: isSelected
          ? Icon(
              Icons.check_circle,
              color: color,
              size: 18,
            )
          : CircleAvatar(radius: 7, backgroundColor: color),
    );
  }

  Widget sizeWidget(String text,
      {Color color = LightColor.iconColor, bool isSelected = false}) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(
            color: LightColor.iconColor,
            style: !isSelected ? BorderStyle.solid : BorderStyle.none),
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color:
            isSelected ? LightColor.orange :Colors.grey,
      ),
      child: TitleText(
        text: text,
        fontSize: 16,
        color: isSelected ? LightColor.background : LightColor.titleTextColor,
      ),
    );
  }
}

