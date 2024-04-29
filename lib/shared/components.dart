

import 'package:flutter/material.dart';




Widget defaultButton ({
  double width = double.infinity,
  Color background = Colors.black,
  double radius = 10.0,
  required String text,
  required Function() function,
}) => Container(
  width: width,
  height: 50,
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(radius),
    color: background,
  ),
  child: MaterialButton(onPressed: function,
    child:
    Text(
      '$text',style: const TextStyle(
      fontSize: 20,
      color: Colors.white,
    ),
    ),
  ),
);

Widget defaultForm({

  required String label,
  required IconData prefix,
  required TextInputType type,
  required TextEditingController controller,
  FormFieldValidator? validate,
  Function()? onTap,
  bool isPassword = false,
  IconData? suffix,
  Function()? suffixPressed,
  Function(String value)? onSubmit,
  bool enable = true,
  dynamic onChange,
})=>TextFormField(
  decoration:  InputDecoration(
    labelText: label,

    prefixIcon: Icon(

        prefix

    ),

    suffixIcon: IconButton(onPressed: suffixPressed, icon:

    Icon(

        suffix

    )

    ),

    border: const OutlineInputBorder(),

  ),

  onFieldSubmitted: onSubmit,

  obscureText: isPassword,

  keyboardType: type,

  controller: controller,

  validator: validate,

  onTap: onTap,

  enabled: enable,

  onChanged: onChange,

);



Widget line()=> Padding(
  padding: const EdgeInsets.all(20),
  child:   Container(
    height: 1,
    color: Colors.grey[600],
  ),
);

void navigateTo(context,widget) =>   Navigator.push(
    context,
    MaterialPageRoute(builder:
        (context)=> widget)
);

void navigateAndFinish(context,widget) =>   Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder:
        (context)=> widget),
        (route){
      return false;
    }
) ;

// void showToast({required String msg, ToastState? state}) =>  Fluttertoast.showToast(
//     msg: msg,
//     toastLength: Toast.LENGTH_LONG,
//     gravity: ToastGravity.BOTTOM,
//     timeInSecForIosWeb: 5,
//     backgroundColor: chooseToastColor(state!),
//     textColor: Colors.white,
//     fontSize: 16.0
// );

//enum

enum ToastState {SUCCESS,ERROR,WARNING}

Color chooseToastColor(ToastState state){
  Color color;
  switch(state)
  {
    case ToastState.SUCCESS:
      color = Colors.green;
      break;
    case ToastState.ERROR:
      color =  Colors.red;
      break;
    case ToastState.WARNING:
      color =  Colors.amber;
      break;
  }
  return color;
}





