import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/layout/cubit/cubit.dart';
import 'package:untitled1/layout/cubit/state.dart';
import 'package:untitled1/model/bannerModel.dart';
import 'package:untitled1/model/productModel.dart';
import 'package:untitled1/modules/product/productId.dart';
import 'package:untitled1/shared/components.dart';

class ProductScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context)
  {
    return  BlocConsumer<HomeCubit,HomeStates>(builder: (context,state)=> Scaffold(
      body: HomeCubit.get(context).bannerModel == null || HomeCubit.get(context).homeModel == null?
      const Center(child: CupertinoActivityIndicator()) :
      bannerItem(HomeCubit.get(context).bannerModel!,HomeCubit.get(context).homeModel!),
    ),
        listener: (context,state){
          if (state is HomePostFavouriteSuccessState)
          {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(
                 '${HomeCubit.get(context).addFavouriteModel?.message}'
                ))
            );
          }
        });
  }
}

Widget bannerItem(BannerModel bannerModel, HomeModel homeModel) => Builder(
  builder: (context) {
    return SingleChildScrollView(
      child: Container(
        color: Colors.grey[200],
        child: Column(
          children: [
            CarouselSlider(
              items: bannerModel.data?.map((e) =>
                  Image(
                    image: NetworkImage(e.image ?? ''),
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
              ).toList() ?? [],
              options: CarouselOptions(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                height: 250,
                initialPage: 0,
                reverse: false,
                enableInfiniteScroll: true,
                viewportFraction: 1.0,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayAnimationDuration: const Duration(seconds: 1),
                autoPlayCurve: Curves.fastOutSlowIn,
                scrollDirection: Axis.horizontal,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            GridView.count(
              crossAxisCount: 2,
              childAspectRatio: 1 / 1.55,
              crossAxisSpacing: 1,
              mainAxisSpacing: 1,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: (homeModel.data?.products ?? []).map((model) => productItem(model , context)).toList(),
            ),
          ],
        ),
      ),
    );
  },
);



Widget productItem(Products model,context)=>InkWell(
  onTap: (){
    navigateTo(context,ProductId(model: model));
  },
  child: Container(
    color: Colors.white,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:
      [
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            Image(
              image: NetworkImage(
                  model.image ?? ''
              ),
              height: 200,
              width: double.infinity,
            ),
             Padding(
              padding: const EdgeInsets.all(8),
              child: IconButton(onPressed: (){
                HomeCubit.get(context).postFavorite(productId: model.id!);
              }, icon: Icon(
                model.inFavorites ?? false ? Icons.favorite : Icons.favorite_border,
                color: model.inFavorites ?? false ? Colors.red : Colors.grey,
              ),
              )
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 200,
                child: Row(
                  children: [
                    Text(
                      'EGP ${model.price?.round()}',
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 15
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    if (model.oldPrice != model.price)
                      Text(
                        'EGP ${model.oldPrice?.round()}',
                        style: const TextStyle(
                          decoration: TextDecoration.lineThrough,
                          fontSize: 11
                        ),
                      ),
                  ],
                ),
              ),
              if (model.oldPrice != model.price)
               Container(
                color: Colors.red,
                width: 100,
                alignment: Alignment.center,
                child: const Text(
                  'DISCOUNT',
                  style: TextStyle(
                      color: Colors.white
                  ),
                ),
              ),
              Text(
                model.name ?? '',
                style: Theme.of(context).textTheme.titleMedium,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    ),
  ),
);



