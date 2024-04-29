
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:untitled1/layout/cubit/cubit.dart';
import 'package:untitled1/layout/cubit/state.dart';
import 'package:untitled1/model/GetFovriteModel.dart';
import 'package:untitled1/model/getCartModel.dart';
import 'package:untitled1/model/productModel.dart';
import 'package:untitled1/shared/components.dart';

class FavoriteIdScreen extends StatelessWidget {
  final FavData model;

  const FavoriteIdScreen({super.key, required this.model});


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => HomeCubit(),
      child: BlocConsumer<HomeCubit, HomeStates>(
        builder: (context, state) => Scaffold(
          appBar: AppBar(

          ),
          body: Builder(
            builder: (context) {
              return Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                   Image(image: NetworkImage(
                     model.product?.image ?? ''
                   ),
                     width: double.infinity,
                   ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      model.product?.name ?? '',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text(
                          'EGP ${model.product?.price}',
                          style: const TextStyle(
                              color: Colors.red,
                              fontSize: 15
                          ),
                        ),
                        if (model.product?.price != model.product?.oldPrice)
                          Text(
                            'EGP ${model.product?.oldPrice}',
                            style: const TextStyle(
                                decoration: TextDecoration.lineThrough
                            ),
                          ),
                        if (model.product?.price != model.product?.oldPrice)
                          const SizedBox(
                            width: 10,
                          ),
                        if (model.product?.price != model.product?.oldPrice)
                          Container(
                            color: Colors.red,
                            width: 100,
                            alignment: Alignment.center,
                            child: const Text(
                              'DISCOUNT',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextButton(
                      onPressed: (){
                        HomeCubit.get(context).postCart(productId: model.id!);
                      },
                      child: Container(
                        color: CupertinoColors.black,
                        padding: const EdgeInsets.all(15),
                        child: const Row(
                          children: [
                            Text(
                              'ADD TO BAG',
                              style: TextStyle(
                                  color: CupertinoColors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400
                              ),
                            ),
                            Spacer(),
                            Icon(
                              CupertinoIcons.arrow_right,
                              color: CupertinoColors.white,
                            )
                          ],
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return SingleChildScrollView(
                              child: Container(
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(20),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Text(
                                    model.product?.description ?? '',
                                    style: Theme.of(context).textTheme.bodyLarge,
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                      child: const Text('Show Description',style: TextStyle(
                          fontSize: 17
                      ),),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        listener: (context, state) {
          if (state is HomePostCartSuccessState)
          {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(
                    '${HomeCubit.get(context).postResponseModel?.message}'
                ))
            );
          }
        },
      ),
    );
  }
}
