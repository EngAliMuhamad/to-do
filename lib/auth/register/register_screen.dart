import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:to_do/auth/custom_text_from_field.dart';
import 'package:to_do/dialog_utils.dart';
import 'package:to_do/home/home_screen.dart';
import 'package:to_do/my_theme.dart';

class RegisterScreen extends StatefulWidget{
static const String routeName='register';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
TextEditingController nameController = TextEditingController( text: 'Ali');

TextEditingController emailController = TextEditingController(text: 'ali@route.com');

TextEditingController passwordController = TextEditingController(text: '123456');

TextEditingController confirmpasswordController = TextEditingController(text: '123456');

var fromkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: MyTheme.backgroundLightColor,
          child: Image.asset('assets/images/main_background.png',
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.fill,),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Text('Create Account'),
            centerTitle: true,
            backgroundColor: Colors.transparent,

          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Form(
                  key: fromkey,
                    child: Column(
                      crossAxisAlignment:CrossAxisAlignment.stretch,
                  children:[
                    SizedBox(height:MediaQuery.of(context).size.height*0.25,),
                    CustomTextFromField(label: 'User Name',
                      controller: nameController,
                      validator:(text){
                      if(text == null || text.trim().isEmpty){
                        return 'please enter User Name';
                      }
                      return null;
                      },
                    ),
                    CustomTextFromField(label: 'Email',
                    controller: emailController,
                      validator:(text){
                        if(text == null || text.trim().isEmpty) {
                          return 'please enter Email';
                        }
                         bool emailValid =
                            RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(text);
                        if (!emailValid){
                          return 'Please enter valid email ';
                        }
                        return null;
                      },
                    keyborderType: TextInputType.emailAddress,),
                    CustomTextFromField(label: 'Password',
                    keyborderType: TextInputType.number,
                      obscureText: true,
                      validator:(text){
                        if(text == null || text.trim().isEmpty){
                          return 'please enter password';
                        }
                        if(text.length <6 ){
                          return 'Password should be at least 6 chars';
                        }
                        return null;
                      },
                    controller: passwordController,),
                    CustomTextFromField(label: 'Confirm Password',
                    keyborderType: TextInputType.number,
                      obscureText: true,
                      validator:(text){
                        if(text == null || text.trim().isEmpty){
                          return 'please enter Confirm Password';
                        }
                        if (text != passwordController.text){
                          return "Confirm password dosen't match password";
                        }
                        return null;
                      },
                    controller: confirmpasswordController,),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ElevatedButton(
                        onPressed: (){
                          register();
                        }, child: Text('Create Account',
                      style: Theme.of(context).textTheme.titleLarge,)

                    ),
                    )
                      ],
                )
        )
              ],
            ),
          ),
        )
      ],

    );
  }

  void register()async{
    if (fromkey.currentState?.validate() == true){
      DialogUtils.showLoading(context:context, massage: 'Loading...',isDismissible: false);
      try {
        final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        DialogUtils.hideLoading(context);
        DialogUtils.ShowMessage(context: context, massage: 'Register Succeefully',
        title: 'Success',postActionName: 'OK',posAction: (){
          Navigator.of(context).pushNamed(HomeScreen.routeName);
            });
        print ('register successfully');
        print (credential.user?.uid ?? '');
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          DialogUtils.hideLoading(context);
          DialogUtils.ShowMessage(context: context, massage: 'The password provided is too weak',
              title: 'Error',postActionName: 'OK');
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          DialogUtils.hideLoading(context);
          DialogUtils.ShowMessage(context: context, massage: 'The account already exists for that email.',
              title: 'Error',postActionName: 'OK');
          print('The account already exists for that email.');
        }
      } catch (e) {
        DialogUtils.hideLoading(context);
        DialogUtils.ShowMessage(context: context, massage: '${e.toString()}',
            title: 'Error',postActionName: 'OK');
        print(e);
      }

    }
  }
}
