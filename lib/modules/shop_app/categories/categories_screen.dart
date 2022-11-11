import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/models/Categories_modele.dart';

import '../../../layout/shop_app/cubit/cubit.dart';
import '../../../layout/shop_app/cubit/states.dart';
import '../../../shared/componants/componant.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   return BlocConsumer<ShopCubit, ShopStates>(
      listener: ((context, state) {}),
      builder: (context, state) {
        var cubit = ShopCubit.get(context);

        return ConditionalBuilder(
          condition:cubit.categoriesModel!= null,
          builder: ((context) => ListView.separated(
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) => buldCatItim(cubit.categoriesModel!.data!.data![index]) , 
            separatorBuilder: (context, index) => myDivider(), 
            itemCount: cubit.categoriesModel!.data!.data!.length  )  
          ),
         fallback: (context) => Center(child: CircularProgressIndicator()));
      },
    );
  }

  Widget buldCatItim(DataModel Model)=>Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              decoration :BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                color: Colors.red,
                
                width:2),
               color:  Colors.red,
          ),
          alignment: Alignment.center,
           
              child: Row(
                children: [
                  Image(
                    fit: BoxFit.cover,
                    height: 80,
                    width: 80 ,
                    image: NetworkImage(Model.image.toString())),
                  SizedBox(width: 10,),
                  Text(Model.name.toString(),
                  style: TextStyle(color: Colors.white),
                  ),
                  Spacer(),
                  IconButton(onPressed: (){},color: Colors.white, icon: Icon(Icons.arrow_forward_ios_sharp))
                ],
              ),
            ),
          )
          ;
         
}
