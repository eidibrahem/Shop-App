import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hexcolor/hexcolor.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:untitled/layout/shop_app/cubit/cubit.dart';
import 'package:untitled/layout/shop_app/cubit/states.dart';
import 'package:untitled/models/Categories_modele.dart';
import 'package:untitled/models/home_moodel.dart';
import 'package:untitled/shared/componants/componant.dart';
import 'package:untitled/shared/styles/colors.dart';

import '../product_detail/product_page_detail.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: ((context, state) {
        if (state is ShopSeccesChangFavoritesState) {
          if (state.modele.status == true) //must be false
          {
            ShowToast(text: state.modele.message, state: ToastStates.ERROR);
          }
          ;
        }
      }),
      builder: (context, state) {
        var cubit = ShopCubit.get(context);

        return ConditionalBuilder(
          condition: cubit.homeModel != null && cubit.categoriesModel != null,
          builder: ((context) =>
              productsBuilder(cubit.homeModel, cubit.categoriesModel, context)),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget productsBuilder(HomeModel? homeModel, CategoriesModel? categoriesModel,
          BuildContext context) =>
      SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
              color: HexColor('#F1F6F9'),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Container(width: 120,
                  // height: 120,
                  //  child: Image(image: NetworkImage(homeModel!.data!.banners![0].image.toString())))

                  CarouselSlider(
                      items: homeModel!.data!.banners!
                          .map(
                            (e) => Image(
                              image: NetworkImage(e.image.toString()),
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          )
                          .toList(),
                      options: CarouselOptions(
                        height: 250,
                        aspectRatio: 16 / 9,
                        viewportFraction: .8,
                        initialPage: 0,
                        enableInfiniteScroll: true,
                        reverse: false,
                        autoPlay: true,
                        autoPlayInterval: Duration(seconds: 3),
                        autoPlayAnimationDuration: Duration(milliseconds: 1500),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enlargeCenterPage: true,
                        scrollDirection: Axis.horizontal,
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Categories',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 122,
                          child: ListView.separated(
                            physics: BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) =>
                                BuildCategoriesItem(
                              categoriesModel!.data!.data![index],
                            ),
                            itemCount: categoriesModel!.data!.data!.length,
                            separatorBuilder: (context, index) => SizedBox(
                              width: 10,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: Colors.grey[300],
                    child: GridView.count(
                      shrinkWrap: true,
                      mainAxisSpacing: 1.0,
                      crossAxisSpacing: 1.0,
                      childAspectRatio: 1 / 1.67,
                      physics: NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      children: List.generate(
                          homeModel.data!.products!.length,
                          (index) => buldGridProduct(
                              homeModel.data!.products![index], context)),
                    ),
                  )
                ],
              )));

  Widget BuildCategoriesItem(DataModel Model) => Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.red, width: 2),
          color: Colors.red,
        ),
        child: Column(
          children: [
            Container(
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(18.0)),
              child: Image(
                image: NetworkImage(Model.image.toString()),
                fit: BoxFit.cover,
                height: 100,
                width: 100,
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.red, width: 2),
                  color: Colors.red,
                ),
                alignment: Alignment.center,
                width: 100,
                child: Text(Model.name.toString(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      );

  Widget buldGridProduct(Products model, context) => Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
             onTap: () {
                        navigatTo(context,ProductPageDetail(model) );
                      },
            child: Stack(
              children: [
                Image(
                  image: NetworkImage(model.image.toString()),
                  width: double.infinity,
                  height: 200,
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
                      ' ${model.discount} % OFF',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  )
              ],
            ),
          ),
          Padding(
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
                    model.name.toString(),
                    maxLines: 2,
                    
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14,
                      height: 1.3,
                    ),
                  ),
                ),
                
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
                            color:ShopCubit.get(context).favorites![model.id]!
                                  ? Colors.yellow
                                  : Colors.grey,
                          ),
                        ))
                  ],
                ),
              ],
            ),
          )
        ],
      ));
}
