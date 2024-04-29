import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:untitled1/layout/cubit/cubit.dart';
import 'package:untitled1/layout/cubit/state.dart';
import 'package:untitled1/model/getProfileModel.dart';
import 'package:untitled1/shared/components.dart';

class ProfileScreen extends StatelessWidget {
  final GetProfileModel model;
   ProfileScreen({super.key, required this.model});
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var emailController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    nameController.text = model.data?.name ?? '';
    phoneController.text = model.data?.phone ?? '';
    emailController.text = model.data?.email ?? '';
    return BlocProvider(create: (BuildContext context) => HomeCubit()..getProfile(),
      child: BlocConsumer<HomeCubit,HomeStates>(builder: (context,state) => Scaffold(
            appBar: AppBar(
              backgroundColor: HexColor('1C4966'),
              title: const Text(
                'Profile',
                style: TextStyle(
                  color: CupertinoColors.white
                ),
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: HexColor('1C4966'),
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      )
                    ),
                    child:  Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Update your Account',
                            style: TextStyle(
                                fontSize: 40,
                                color: Colors.white,
                                fontWeight: FontWeight.w800
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Update your Account',
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.grey[300],
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          defaultForm(label: 'Name',
                              prefix: CupertinoIcons.person_alt,
                              type: TextInputType.name,
                              controller: nameController,
                              validate: (value){
                                if (value.isEmpty)
                                {
                                  return 'Empty';
                                }
                                return null;
                              }
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          defaultForm(label: 'Phone',
                              prefix: CupertinoIcons.phone,
                              type: TextInputType.phone,
                              controller: phoneController,
                              validate: (value){
                                if (value.isEmpty)
                                {
                                  return 'Empty';
                                }
                                return null;
                              }
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          defaultForm(label: 'Email',
                              prefix: Icons.email_outlined,
                              type: TextInputType.emailAddress,
                              controller: emailController,
                              validate: (value){
                                if (value.isEmpty)
                                {
                                  return 'Empty';
                                }
                                return null;
                              }
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                         if (state is HomePutUpdateLoadingState)
                            const LinearProgressIndicator(),
                          const SizedBox(
                            height: 10,
                          ),
                          defaultButton(text: 'UPDATE',background: HexColor('1C4966'), function: (){
                            HomeCubit.get(context).putProfile(name: nameController.text,
                                phone: phoneController.text,
                                email: emailController.text
                            );
                          }
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ) ,
      ),
          listener: (context,state){

          }),
    );
  }
}


