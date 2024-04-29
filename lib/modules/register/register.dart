
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:untitled1/layout/homeLayout.dart';
import 'package:untitled1/modules/login/cubit/cubit.dart';
import 'package:untitled1/modules/login/cubit/state.dart';
import 'package:untitled1/shared/components.dart';
import 'package:untitled1/shared/constants.dart';

import '../../shared/local/cacheHelper.dart';

class RegisterScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passController = TextEditingController();
  var phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context)
  {
    return BlocProvider(
      create:(BuildContext context) => LoginCubit(),
      child: BlocConsumer<LoginCubit,LoginStates>(
          builder: (context,state)=>Scaffold(
            appBar: AppBar(
              backgroundColor:HexColor('1C4966') ,
              systemOverlayStyle:  SystemUiOverlayStyle(
                statusBarBrightness: Brightness.dark,
                statusBarIconBrightness: Brightness.dark,
                statusBarColor: HexColor('1C4966'),
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                children:
                [
                  Container(
                    width: double.infinity,
                    color: HexColor('1C4966'),
                    child:  Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Register',
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
                            'Create your Account',
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
                          children: [
                            TextFormField(
                              decoration: InputDecoration(
                                prefixIcon: const Icon(
                                    Icons.perm_identity_outlined
                                ),
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                                label: const Text(
                                  'Name',
                                ),
                              ),
                              controller: nameController,
                              keyboardType: TextInputType.name,
                              validator: (value)
                              {
                                if (value!.isEmpty) {
                                  return 'Empty';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                prefixIcon: const Icon(
                                    Icons.perm_identity_outlined
                                ),
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                                label: const Text(
                                  'phone',
                                ),
                              ),
                              controller: phoneController,
                              keyboardType: TextInputType.phone,
                              validator: (value)
                              {
                                if (value!.isEmpty) {
                                  return 'Empty';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                prefixIcon: const Icon(
                                    Icons.email_outlined
                                ),
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                                label: const Text(
                                  'Email',
                                ),
                              ),
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                              validator: (value)
                              {
                                if (value!.isEmpty) {
                                  return 'Empty';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                suffixIcon: const Icon(
                                    Icons.remove_red_eye_outlined
                                ),
                                prefixIcon: const Icon(
                                    Icons.lock_outline
                                ),
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                                label: const Text(
                                  'Password',
                                ),
                              ),
                              controller: passController,
                              keyboardType: TextInputType.visiblePassword,
                              obscureText: true,
                              validator: (value)
                              {
                                if (value!.isEmpty) {
                                  return 'Empty';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            if (state is RegisterLoadingState)
                              const LinearProgressIndicator(),
                            const SizedBox(
                              height: 20,
                            ),
                            Container(
                              width: double.infinity,
                              height: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: Colors.green[300]
                              ),
                              child: MaterialButton(onPressed: ()
                              {
                                if (formKey.currentState!.validate())
                                  {
                                    LoginCubit.get(context).postRegister(
                                        name: nameController.text,
                                        email: emailController.text,
                                        phone: phoneController.text,
                                        password: passController.text
                                    );
                                  }

                              },
                                child: const Text(
                                  'Register',
                                  style: TextStyle(
                                      fontSize: 18
                                  ),
                                ),),
                            ),
                          ],
                        )
                    ),
                  )
                ],
              ),
            ),
          ),
          listener: (context,state){
            if (state is RegisterSuccessState)
              {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(
                        '${LoginCubit.get(context).loginModel?.message}'
                    ))
                );
                CacheHelper.saveData(key: 'token', value: state.registerModel.data?.token).then((value){
                  navigateAndFinish(context, const HomeLayoutScreen());
                });
              }
          }),

    );
  }
}
