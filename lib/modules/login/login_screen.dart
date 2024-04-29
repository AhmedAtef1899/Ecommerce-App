
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled1/layout/cubit/cubit.dart';
import 'package:untitled1/layout/homeLayout.dart';
import 'package:untitled1/modules/login/cubit/cubit.dart';
import 'package:untitled1/modules/login/cubit/state.dart';
import 'package:untitled1/modules/register/register.dart';
import 'package:untitled1/shared/components.dart';
import 'package:untitled1/shared/constants.dart';
import 'package:untitled1/shared/local/cacheHelper.dart';

class LoginScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
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
                            'Sign in to your Account',
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
                            'Sign in to your Account',
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
                                if(value!.isEmpty)
                                {
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
                              controller: passwordController,
                              validator: (value)
                              {
                                if(value!.isEmpty)
                                {
                                  return 'Empty';
                                }
                                return null;
                              },
                              keyboardType: TextInputType.visiblePassword,
                              obscureText: true,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            if (state is LoginLoadingState)
                              const LinearProgressIndicator(),
                            const SizedBox(
                              height: 20,
                            ),
                            Container(
                              width: double.infinity,
                              height: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: HexColor('1C4966')
                              ),
                              child: MaterialButton(onPressed: (){
                                if (formKey.currentState!.validate())
                                {
                                  LoginCubit.get(context).postLogin(email: emailController.text, password: passwordController.text);
                                }
                              },
                                child: const Text(
                                  'Login',
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white
                                  ),
                                ),),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text('Don\'t have account?'),
                                const SizedBox(
                                  width: 10,
                                ),
                                TextButton(onPressed: ()
                                {
                                  navigateTo(context,RegisterScreen());
                                }, child: const Text(
                                    'Register'
                                )
                                ),
                              ],
                            )
                          ],
                        )
                    ),
                  )
                ],
              ),
            ),
          ),
          listener: (context,state){
            if (state is LoginSuccessState)
              {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(
                    '${LoginCubit.get(context).loginModel?.message}'
                  ))
                );
                CacheHelper.saveData(key: 'token', value: state.loginModel.data?.token).then((value){
                  navigateAndFinish(context, const HomeLayoutScreen());
                });
              }
          }),
    );
  }
}
