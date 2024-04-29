import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/layout/cubit/cubit.dart';
import 'package:untitled1/layout/cubit/state.dart';
import 'package:untitled1/model/getCartModel.dart';
import 'package:untitled1/modules/cart/cartId.dart';
import 'package:untitled1/shared/components.dart';

class CartScreen extends StatelessWidget {

  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<HomeCubit,HomeStates>(
        builder:(context,state) =>Scaffold(
          appBar: AppBar(
            title:  containerItem(HomeCubit.get(context).getCartModel!,context),
            centerTitle: true,
          ),
          body: HomeCubit.get(context).getCartModel == null? const Center(child: CupertinoActivityIndicator()):
          Container(
            color: Colors.grey[100],
            child: Column(
              children: [
                if (state is HomeGetCartLoadingState)
                  const LinearProgressIndicator(),
                Expanded(
                  child: ListView.separated(
                      itemBuilder: (context,index) =>cartItem(HomeCubit.get(context).getCartModel!.data!.cartItems![index],context) ,
                      separatorBuilder: (context,index)=>const SizedBox(height: 2,),
                      itemCount:HomeCubit.get(context).getCartModel!.data!.cartItems!.length,
                  ),
                ),
              ],
            ),
          ),
        ),
        listener: (context,state){
        });
  }
}

Widget cartItem(CartItems cartItems,context) => InkWell(
  onTap: (){
    navigateTo(context, CartIdScreen(model: cartItems));
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
          '${cartItems.product?.image}',
        ),
          height: 200,
          width: 150,

        ),
        const SizedBox(width: 20),
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
                    'EGP ${cartItems.product?.price?.round()}',
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
                  cartItems.product?.name ?? '',
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
                if (cartItems.product?.price != cartItems.product?.oldPrice?.round())
                  Container(
                    padding: const EdgeInsets.all(3),
                    decoration: const BoxDecoration(
                      color: Colors.red
                    ),
                    child: const Text(
                      'DISCOUNT',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                        color: Colors.white
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
            builder: (BuildContext context)
            {

              return BlocProvider(create: (BuildContext context) => HomeCubit(),
                child: BlocConsumer<HomeCubit,HomeStates>(builder: (context,state) =>Padding(
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
                      }, child: const Row(
                        children: [
                          Icon(
                              CupertinoIcons.arrow_right
                          ),
                          SizedBox(
                            width: 2,
                          ),
                          Text(
                              'CHECKOUT'
                          )
                        ],
                      ),),
                      const SizedBox(
                        height: 20,
                      ),
                      TextButton(onPressed: (){
                        HomeCubit.get(context).postCart(productId: cartItems.product!.id!);

                        if (state is HomePostCartSuccessState)
                        {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text(
                              'Deleted Successfully'
                          )));
                        }
                      }, child: const Row(
                        children: [
                          Icon(
                              Icons.delete_outline
                          ),
                          SizedBox(
                            width: 2,
                          ),
                          Text(
                              'Remove from bag'
                          )
                        ],
                      ),)
                    ],
                  ),
                ), listener: (context,state){}),

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

Widget containerItem(GetCartModel model,context) =>  Row(
  children: [
    const Text(
        'Total'
    ),
    const SizedBox(
      width: 20,
    ),
    Text(
        '${model.data?.total}'
    ),
    const SizedBox(
      width: 40,
    ),
    TextButton(
      onPressed: (){
        HomeCubit.get(context).postAddresses;
      },
      child: Container(
        width: 130,
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          border: Border.all(
              style: BorderStyle.solid
          ),
          color: CupertinoColors.black
        ),
        child: const Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'CHECKOUT',
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                color: Colors.white
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Icon(
                CupertinoIcons.money_dollar,
              color: Colors.white,
            )
          ],
        ),
      ),
    )
  ],
);


