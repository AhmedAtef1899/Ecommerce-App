import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/layout/cubit/cubit.dart';
import 'package:untitled1/layout/cubit/state.dart';
import 'package:untitled1/modules/profile.dart';
import 'package:untitled1/shared/components.dart';

class HomeLayoutScreen extends StatelessWidget {
  const HomeLayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (BuildContext context)=> HomeCubit()..getProduct()..getCategories()..getFavorite()..getCart()..getProfile(),
    child:BlocConsumer<HomeCubit,HomeStates>(builder: (context,state)=>Scaffold(
      appBar: AppBar(
        title: Text(
          HomeCubit.get(context).appBar[HomeCubit.get(context).currentIndex]
        ),
        actions: [
          IconButton(onPressed: (){
            navigateTo(context, ProfileScreen(model: HomeCubit.get(context).getProfileModel!));
          }, icon: const Icon(
            CupertinoIcons.profile_circled
          )),
          IconButton(onPressed: (){}, icon: const Icon(
            Icons.shopping_basket_outlined
          ))
        ],
      ),
      body: HomeCubit.get(context).screens[HomeCubit.get(context).currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: HomeCubit.get(context).currentIndex,
        items: HomeCubit.get(context).bottomBar,
        onTap: (index){
          HomeCubit.get(context).navBar(index);
        },
      ),
    ), listener: (context,state){}),
    );
  }
}
