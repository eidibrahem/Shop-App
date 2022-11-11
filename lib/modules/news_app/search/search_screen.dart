import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/shared/componants/componant.dart';
import 'package:untitled/shared/cubit/cubit.dart';
import 'package:untitled/shared/cubit/stats.dart';
class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<NewsCubit,NewStates>(
        listener: (context,state){},
        builder: (context,state){
          var cubit=NewsCubit.get(context);
          var list =cubit.searchNews;

          return Scaffold(
            backgroundColor: Colors.green[100],

            appBar: AppBar(),
            body:   Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    child:defaultFormFieldX(



                      //  cursorColor: Colors.pink ,
                        Controller:cubit.searchController,
                        type: TextInputType.text,
                      label: "search",
                        validator:  ( value) {
                                       if(value!.isEmpty){
                                   return 'title must not be empty';
                                               }},

                 context: context,
                      onchanged: (value)
                      {
                        cubit.getSearch(value);
                        print(value);


                      },
                      color: Colors.blueAccent,


                      prefix: Icons.search ,

                    ) ,
                  ),
                ),
                Container(
       child: Expanded(
         child: ConditionalBuilder(
                  condition: list.length == 0,
            builder: (context) =>  Center(child: CircularProgressIndicator()),
            fallback: (context) => Center( child:  ListView.separated(
              physics: BouncingScrollPhysics(),

              itemBuilder: (context,index)=>buildArticleItems(list[index],context)     ,
                separatorBuilder: (context,index)=> myDivider(),
               itemCount: list.length),

            ),

                    ),
       ) ,)

              ],
            )

          );

          // if( list.length == 0 )
          //   return Center(child: CircularProgressIndicator()) ;
          // else
          //   return ListView.separated(
          //       physics: BouncingScrollPhysics(),
          //
          //       itemBuilder: (context,index)=>buildArticleItem(list[index],context)     ,
          //       separatorBuilder: (context,index)=> myDivider(),
          //       itemCount: list.length);
        });}

}