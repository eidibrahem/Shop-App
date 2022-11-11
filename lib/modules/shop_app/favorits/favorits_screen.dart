import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/layout/shop_app/cubit/states.dart';
import 'package:untitled/models/home_moodel.dart';
import 'package:untitled/shared/componants/componant.dart';

import '../../../layout/shop_app/cubit/cubit.dart';
import '../../../shared/styles/colors.dart';

class FavoritsScreen extends StatefulWidget {
  const FavoritsScreen({Key? key}) : super(key: key);

  @override
  State<FavoritsScreen> createState() => _FavoritsScreenState();
}

class _FavoritsScreenState extends State<FavoritsScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: ((context, state) {}),
      builder: (context, state) {
        var cubit = ShopCubit.get(context);

        return ConditionalBuilder(
            condition: cubit.favoritesProduct != null,
            builder: ((context) => ListView.separated(
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) =>
                    BuildFavoritesItem(cubit.favoritesProduct![index]),
                separatorBuilder: (context, index) => myDivider(),
                itemCount: cubit.favoritesProduct!.length)),
            fallback: (context) => Center(child: CircularProgressIndicator()));
      },
    );
  }

  Widget BuildFavoritesItem(Products model) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          height: 120,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            
            children: [
              Container(
                width: 110,
                child: Stack(
                  children: [
                    Image(
                      fit: BoxFit.cover,
                      image: NetworkImage(model.image.toString()),
                      width: 110,
                      height: 110,
                    ),
                     if (model.discount != 0)
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(2)),
                        child: Text(
                          '${model.discount}% OFF',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      )
                  ],
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 12,
                    right: 12,
                    top: 12,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 30,
                        child: Text(
                          '${model.name}',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 14,
                            height: 1.3,
                          ),
                        ),
                      ),
                      Spacer(),
                      Row(
                        children: [
                          Text(
                            '${model.price.round()}',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 14,
                              color: defaultColor,
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          if (model.discount != 0)
                            Text(
                              '${model.oldPrice.round()}',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 12,
                                decoration: TextDecoration.lineThrough,
                                color: Colors.grey,
                              ),
                            ),
                          Spacer(),
                          IconButton(
                              onPressed: () {
                                ShopCubit.get(context).getHomeData2();
                                ShopCubit.get(context)
                                    .ChangeFavorites(model.id);
                              },
                              icon: CircleAvatar(
                                radius: 15.0,
                                backgroundColor: Colors.black.withOpacity(.6),
                                //  ShopCubit.get(context).favorites![model.id]!
                                //    ? Colors.black.withOpacity(.6)
                                //   : Colors.white,
                                child: Icon(
                                  Icons.star_purple500_sharp,
                                  color: Colors.yellow,
                                  //  ShopCubit.get(context).favorites![model.id]!
                                  //    ? Colors.yellow
                                  //  : Colors.grey,
                                ),
                              ))
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      );
}
