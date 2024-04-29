import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/layout/cubit/cubit.dart';
import 'package:untitled1/layout/cubit/state.dart';
import 'package:untitled1/shared/components.dart';

class AddressScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var cityController = TextEditingController();
  var regionController = TextEditingController();
  var detailsController = TextEditingController();
  var notesController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (BuildContext context) => HomeCubit(),
      child: BlocConsumer<HomeCubit,HomeStates>(builder: (context,state)=>Scaffold(
        appBar: AppBar(

        ),
        body:  Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  defaultForm(label: 'Full Name',
                      prefix: CupertinoIcons.person,
                      type: TextInputType.name,
                      controller: nameController,
                      validate: (value){
                        if(value.isEmty)
                          {
                            return 'Empty';
                          }
                        return null;
                      }
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  defaultForm(label: 'City',
                      prefix: Icons.location_city_outlined,
                      type: TextInputType.text,
                      controller: cityController,
                      validate: (value){
                        if(value.isEmty)
                        {
                          return 'Empty';
                        }
                        return null;
                      }
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  defaultForm(label: 'Region',
                      prefix: Icons.home_outlined,
                      type: TextInputType.text,
                      controller: regionController,
                      validate: (value){
                        if(value.isEmty)
                        {
                          return 'Empty';
                        }
                        return null;
                      }
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  defaultForm(label: 'Details',
                      prefix: Icons.notes,
                      type: TextInputType.text,
                      controller: detailsController,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  defaultForm(label: 'Notes',
                      prefix: Icons.note_add_outlined,
                      type: TextInputType.name,
                      controller: notesController,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  defaultButton(text: 'Order', function: (){
                    HomeCubit.get(context).postAddress(name: nameController.text,
                        city: cityController.text,
                        region: regionController.text,
                        details: detailsController.text,
                        notes: notesController.text
                      );
                    HomeCubit.get(context).postOrder(
                        addressId: HomeCubit.get(context).postAddresses!.data!.id!,
                        paymentMethod: 1,
                        usePoint: false
                    );
                  })
                ],
              ),
            ),
          ),
        ),
      ), listener: (context,state){
        if (state is HomePostAddressSuccessState && state is HomePostOrderSuccessState )
          {
            // navigateTo(context, widget);
          }
      }),
    );
  }
}
