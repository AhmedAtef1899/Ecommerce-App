import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/layout/cubit/cubit.dart';
import 'package:untitled1/layout/cubit/state.dart';
import 'package:untitled1/model/categoriesModel.dart';
import 'package:untitled1/shared/components.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<HomeCubit,HomeStates>(builder: (context,state)=>Scaffold(
      body: Column(
        children: [
          HomeCubit.get(context).categoriesModels == null? const Center(child: CupertinoActivityIndicator()) :
          Expanded(
            child: ListView.separated(
              itemBuilder: (context,index)=>categoryList(HomeCubit.get(context).categoriesModels!.data!.catData[index],context),
              separatorBuilder: (context,index)=> line(),
              itemCount: HomeCubit.get(context).categoriesModels!.data!.catData.length,
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
            ),
          ),
        ],
      )
    ),
        listener: (context,state){});
  }
}

Widget categoryList(DataModel dataModel,context) => Row(
  children: [
    Image(image: NetworkImage('${dataModel.image}'),height: 100,width: 100,),
    const SizedBox(
      width: 20,
    ),
    Text(
      '${dataModel.name}',
      style: Theme.of(context).textTheme.titleLarge
    ),
    const Spacer(),
    IconButton(onPressed: (){}, icon: const Icon(
      Icons.arrow_forward_ios_outlined
    ))
  ],
);
