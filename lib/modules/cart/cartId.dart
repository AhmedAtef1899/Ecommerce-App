
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:untitled1/layout/cubit/cubit.dart';
import 'package:untitled1/layout/cubit/state.dart';
import 'package:untitled1/model/getCartModel.dart';
import 'package:untitled1/model/productModel.dart';
import 'package:untitled1/modules/address.dart';
import 'package:untitled1/shared/components.dart';

class CartIdScreen extends StatelessWidget {
  final CartItems model;

  const CartIdScreen({super.key, required this.model});

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
              var imagesController = PageController();
              return Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: PageView.builder(
                        itemBuilder: (context, index) => Image(
                          image: NetworkImage(
                            model.product!.images![index] ?? '',
                          ),
                        ),
                        itemCount: model.product!.images?.length ?? 0,
                        physics: const BouncingScrollPhysics(),
                        controller: imagesController,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SmoothPageIndicator(
                          controller: imagesController,
                          count: model.product!.images!.length,
                          effect: const ExpandingDotsEffect(
                            dotColor: Colors.grey,
                            activeDotColor: Colors.deepOrange,
                            dotHeight: 10,
                            dotWidth: 10,
                            spacing: 5,
                            expansionFactor: 5,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      model.product!.name ?? '',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text(
                          'EGP ${model.product!.price}',
                          style: const TextStyle(
                              color: Colors.red,
                              fontSize: 15
                          ),
                        ),
                        if (model.product!.price != model.product!.oldPrice)
                          Text(
                            'EGP ${model.product!.oldPrice}',
                            style: const TextStyle(
                                decoration: TextDecoration.lineThrough
                            ),
                          ),
                        if (model.product!.price != model.product!.oldPrice)
                          const SizedBox(
                            width: 10,
                          ),
                        if (model.product!.price != model.product!.oldPrice)
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
                        navigateTo(context, AddressScreen());
                      },
                      child: Container(
                        color: CupertinoColors.black,
                        padding: const EdgeInsets.all(15),
                        child: const Row(
                          children: [
                            Text(
                              'CHECKOUT',
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
                                    model.product!.description ?? '',
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
