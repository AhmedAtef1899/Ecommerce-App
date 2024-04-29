import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/layout/cubit/cubit.dart';
import 'package:untitled1/layout/cubit/state.dart';
import 'package:untitled1/model/GetFovriteModel.dart';
import 'package:untitled1/model/productModel.dart';
import 'package:untitled1/modules/favorite/favoriteId.dart';
import 'package:untitled1/modules/product/productId.dart';
import 'package:untitled1/shared/components.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context)
  {
    return BlocConsumer<HomeCubit,HomeStates>(
        builder: (context,state) => Scaffold(
          body: HomeCubit.get(context).favModel == null? const Center(child: CupertinoActivityIndicator())
              : Container(
            color: Colors.grey[100],
            child: Column(
              children: [
                if (state is HomeGetFavoriteLoadingState)
                  const LinearProgressIndicator(),
                Expanded(
                  child: ListView.separated(itemBuilder: (context,index) =>
                  HomeCubit.get(context).favModel == null? const CupertinoActivityIndicator()
                      : favoriteItem(HomeCubit.get(context).favModel!.data!.data![index],context),
                    separatorBuilder: (context,index)=>const SizedBox(height: 2,),
                    itemCount: HomeCubit.get(context).favModel!.data!.data!.length,
                    physics: const BouncingScrollPhysics(),
                  ),
                ),
              ],
            ),
          ),
        ),
        listener: (context,state){
          if (state is HomePostCartSuccessState)
          {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(
                    '${HomeCubit.get(context).postResponseModel?.message}'
                ))
            );
          }
        }
    );
  }
}

Widget favoriteItem(FavData getFavoriteModel,context) => InkWell(
  onTap: (){
    navigateTo(context, FavoriteIdScreen(model: getFavoriteModel));
  },
  child: Container(
    padding: const EdgeInsets.all(30),
    height: 210,
    width: double.infinity,
    color: Colors.white,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image(image: NetworkImage(
          '${getFavoriteModel.product?.image}',
          ),
          height: 200,
          width: 150,

        ),
        const SizedBox(width: 10),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  color: Colors.grey[100],
                  padding: const EdgeInsets.all(5),
                  height: 30,
                  child: Text(
                    'EGP ${getFavoriteModel.product?.price}',
                    style: const TextStyle(
                      color: Colors.red,
                      fontStyle: FontStyle.italic,
                      fontSize: 15
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  getFavoriteModel.product?.name ?? '',
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                const SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: (){
                    HomeCubit.get(context).postCart(productId: getFavoriteModel.product!.id!);
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      border: Border.all(
                        style: BorderStyle.solid
                      ),
                    ),
                    child: const Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'ADD TO BAG',
                          style: TextStyle(
                            fontWeight: FontWeight.w500
                          ),
                        ),
                        Spacer(),
                        Icon(
                          CupertinoIcons.bag
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        IconButton(onPressed: (){
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return  Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const Text(
                      'OPTIONS',
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 20
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextButton(onPressed: (){
                      HomeCubit.get(context).postCart(productId: getFavoriteModel.product!.id!);
                    }, child: const Row(
                      children: [
                        Icon(
                            CupertinoIcons.bag_badge_plus
                        ),
                        SizedBox(
                          width: 2,
                        ),
                        Text(
                            'Add to bag'
                        )
                      ],
                    ),),
                    const SizedBox(
                      height: 20,
                    ),
                    TextButton(onPressed: (){
                      HomeCubit.get(context).postFavorite(productId: getFavoriteModel.product!.id!);
                    }, child: const Row(
                      children: [
                        Icon(
                            Icons.delete_outline
                        ),
                        SizedBox(
                          width: 2,
                        ),
                        Text(
                            'Remove from favorite'
                        )
                      ],
                    ),)
                  ],
                ),
              );
            },
          );
        }, icon: const Icon(
            CupertinoIcons.list_bullet_indent,
        ))
      ],
    ),
  ),
);
