import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/model/loginmodel.dart';
import 'package:untitled1/modules/login/cubit/state.dart';
import 'package:untitled1/shared/constants.dart';
import 'package:untitled1/shared/endPoints.dart';
import 'package:untitled1/shared/network/dioHelper.dart';
import 'package:untitled1/shared/network/end_points.dart';

class LoginCubit extends Cubit<LoginStates>
{
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  LoginModel? loginModel;

  void postLogin({
    required String email,
    required String password,
}){
    emit(LoginLoadingState());
    dioHelper.postData(url: LOGIN, data: {
      'email' : email,
      'password' : password,
    }).then((value)
    {
      print(value.data);
      loginModel = LoginModel.fromJson(value.data);
      emit(LoginSuccessState(loginModel!));
    }).catchError((onError){
      print(onError.toString());
      emit(LoginErrorState());
    });
  }

  LoginModel? registerModel;

  void postRegister({
    required String name,
    required String email,
    required String phone,
    required String password,
}){
    emit(RegisterLoadingState());
    dioHelper.postData(url: REGISTER, data: {
      'name' : name,
      'email' : email,
      'phone' : phone,
      'password' : password,
    }).then((value) {
      print(value.data);
      registerModel = LoginModel.fromJson(value.data);
      emit(RegisterSuccessState(registerModel!));
    }).catchError((onError){
      print(onError.toString());
      emit(RegisterErrorState());
    });
  }
}