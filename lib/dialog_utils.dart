// import 'dart:js';

import 'package:flutter/material.dart';
class DialogUtils{

  static void showLoading ({required BuildContext context,required String massage,
  bool isDismissible = true}) {
    showDialog(context: context,
        barrierDismissible:isDismissible ,
        builder:(context){
      return AlertDialog(
        content: Row(
          children: [
            CircularProgressIndicator(),
            SizedBox(width: 12,),
            Text(massage)
          ],
        ),
      );
        }
    );
  }

  static void hideLoading(BuildContext context){
    Navigator.pop(context);
  }

  static void ShowMessage({required BuildContext context,
    required String massage,
    String? title,
    String? postActionName,
    Function?posAction,
    String? negActionName,
    Function?negAction,
  bool isDismissible =true}) {
    List<Widget> actions =[];
    if(postActionName != null){
      actions.add(TextButton(onPressed: (){
        Navigator.pop(context);
        if(posAction != null){
          posAction.call();
        }
      }, child: Text(postActionName,
      )));
    }

    if(negActionName != null){
      actions.add(TextButton(onPressed: (){
        Navigator.pop(context);
        if(negAction != null){
          negAction.call();
        }
      }, child: Text(negActionName)));
    }
    showDialog(
        context: context,
        barrierDismissible: isDismissible,
        builder: (context) {
          return AlertDialog(
            content: Text(massage),
            title: Text(title ?? '',style: Theme.of(context).textTheme.titleMedium,),
            actions:actions,


          );
        }
    );
  }
  }
