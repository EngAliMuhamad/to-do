import 'package:flutter/material.dart';
import 'package:to_do/my_theme.dart';

class CustomTextFromField extends StatelessWidget{
String label;
TextInputType keyborderType;
TextEditingController controller;
String? Function(String?) validator;
bool obscureText;
CustomTextFromField({required this .label,
  required this .validator,
required this .controller,this. obscureText=false
,this .keyborderType=TextInputType.text});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        child: TextFormField(
          decoration:InputDecoration(
              labelText: label,
            enabledBorder:OutlineInputBorder (
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                color: MyTheme.primaryColor,
                width: 2
              )
            ),
            focusedBorder:OutlineInputBorder (
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(
                    color: MyTheme.primaryColor,
                    width: 2
                )
            ),
            errorBorder: OutlineInputBorder (
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(
                    color: MyTheme.redColor,
                    width: 2
                )
            ),
            focusedErrorBorder: OutlineInputBorder (
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(
                    color: MyTheme.redColor,
                    width: 2
                )
            ),
          ) ,
          keyboardType: keyborderType,
          controller:controller ,
          validator:validator ,
          obscureText:obscureText ,
        ),
      ),
    );
  }
}
