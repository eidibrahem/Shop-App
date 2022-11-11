import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/shared/componants/componant.dart';
import 'package:untitled/shared/cubit/cubit.dart';
import 'package:untitled/shared/cubit/stats.dart';

class BusinessScreen extends StatelessWidget {
  const BusinessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<NewsCubit,NewStates>(
    listener: (context,state){},
    builder: (context,state){
    var cubit=NewsCubit.get(context);
    var list =cubit.businessNews;

    if(list.length == 0)
    return Center(child: CircularProgressIndicator()) ;
    else
      return ListView.separated(
           physics: BouncingScrollPhysics(),

          itemBuilder: (context,index)=>buildArticleItem(list[index],context)     ,
          separatorBuilder: (context,index)=> myDivider(),
          itemCount: list.length);
  });}
}

