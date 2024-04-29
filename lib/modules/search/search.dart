import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/layout/cubit/cubit.dart';
import 'package:untitled1/layout/cubit/state.dart';
import 'package:untitled1/model/searchModel.dart';
import 'package:untitled1/modules/search/searchId.dart';
import 'package:untitled1/shared/components.dart';

class SearchScreen extends StatelessWidget {
  var textController = TextEditingController();

  @override
  Widget build(BuildContext context)
  {
    return BlocConsumer<HomeCubit,HomeStates>(
        builder: (context,state) => Scaffold(
          body: Container(
            color: Colors.grey[100],
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: defaultForm(label: 'Search',
                      prefix: CupertinoIcons.search,
                      type: TextInputType.text,
                      controller: textController,
                      validate: (value)
                      {
                        if (value.isEmpty)
                        {
                          return 'Empty';
                        }
                        return null;
                      },
                      onSubmit: (value){
                        HomeCubit.get(context).postSearch(text: value);
                      }
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                if (state is HomePostSearchLoadingState)
                  const LinearProgressIndicator(),
                if (state is HomePostSearchSuccessState)
                  Expanded(
                    child: ListView.separated(itemBuilder: (context,index) =>
                    HomeCubit.get(context).favModel == null? const CupertinoActivityIndicator()
                        : searchItem(HomeCubit.get(context).searchModel!.data!.data![index],context),
                      separatorBuilder: (context,index)=>const SizedBox(height: 2,),
                      itemCount: HomeCubit.get(context).searchModel!.data!.data!.length,
                      physics: const BouncingScrollPhysics(),
                    ),
                  ),
              ],
            ),
          ),
        ),
        listener: (context,state){
        }
    );
  }
}

Widget searchItem(SearchData data,context) => InkWell(
  onTap: (){
    navigateTo(context, SearchIdScreen(model: data));
  },
  child: Container(
    padding: const EdgeInsets.all(30),
    height: 200,
    width: double.infinity,
    color: Colors.white,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image(image: NetworkImage(
          '${data.image}',
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
                    'EGP ${data.price}',
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
                  data.name ?? '',
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
              ],
            ),
          ),
        ),
        IconButton(onPressed: (){
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return  BlocProvider(create: (BuildContext context) => HomeCubit(),
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
                        HomeCubit.get(context).postCart(productId: data.id!);
                      }, child: const Row(
                        children: [
                          Icon(
                              CupertinoIcons.bag
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
                        HomeCubit.get(context).postFavorite(productId: data.id!);

                      }, child: const Row(
                        children: [
                          Icon(
                              Icons.favorite
                          ),
                          SizedBox(
                            width: 2,
                          ),
                          Text(
                              'Add to favorite'
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
