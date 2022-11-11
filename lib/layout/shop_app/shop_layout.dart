import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/layout/shop_app/cubit/cubit.dart';
import 'cubit/states.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout(this.token, {Key? key}) : super(key: key);
  final String? token;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        return (Scaffold(
          appBar: AppBar(
            title: Text('Salla  '),
          ),
          body: ShopCubit.get(context)
              .screens[ShopCubit.get(context).currentIndex],
          bottomNavigationBar: BottomNavigationBar(
           
            onTap: ((index) {
              print(token);
              ShopCubit.get(context).changCurrentIndexe(index);
            }),
            currentIndex: cubit.currentIndex,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.apps), label: 'products'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.category), label: 'categories'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite), label: 'favorits'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings), label: 'settings'),
            ],
          ),
        ));
      },
    );
  }
}
