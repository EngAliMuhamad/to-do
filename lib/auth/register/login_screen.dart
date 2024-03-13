import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:to_do/auth/custom_text_from_field.dart';
import 'package:to_do/auth/register/register_screen.dart';
import 'package:to_do/dialog_utils.dart';
import 'package:to_do/home/home_screen.dart';
import 'package:to_do/my_theme.dart';

class LoginScreen extends StatefulWidget{
static const String routeName='login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
TextEditingController emailController = TextEditingController(text: 'ali@route.com');

TextEditingController passwordController = TextEditingController(text: '123456');

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
            title: Text('Login'),
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
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text('Welcome Back!',
                      style: Theme.of(context).textTheme.titleMedium,),
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
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ElevatedButton(
                        onPressed: (){
                          login();
                        }, child: Text('login',
                      style: Theme.of(context).textTheme.titleLarge,)

                    ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextButton(
                          onPressed: (){
                            Navigator.of(context).pushNamed(RegisterScreen.routeName);
                          }, child: Text('OR Create Account',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: MyTheme.primaryColor
                        ),)

                      ),
                    ),
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

  void login()async{
    if (fromkey.currentState?.validate() == true){
      DialogUtils.showLoading(context:context, massage: 'Loading...',isDismissible: false);

      try {
        final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text
        );
        DialogUtils.hideLoading(context);
        DialogUtils.ShowMessage(context: context, massage: 'Login Succeefully',
            title: 'Success',postActionName: 'OK',posAction: (){
              Navigator.of(context).pushNamed(HomeScreen.routeName);
            });
        print('login successfully');
        print(credential.user?.uid??'');
      } on FirebaseAuthException catch (e) {
        if (e.code == 'invalid-credential') {
          DialogUtils.hideLoading(context);
          DialogUtils.ShowMessage(context: context, massage: 'The supplied auth credential incorrect,malformed or has expired.',
              title: 'Error',postActionName: 'OK');
          print('The account already exists for that email.');
          print('The supplied auth credential incorrect,malformed or has expired.');

        }
      }
      catch(e){
        DialogUtils.hideLoading(context);
        DialogUtils.ShowMessage(context: context, massage: '${e.toString()}',
            title: 'Error',postActionName: 'OK');
        print('The account already exists for that email.');
        print(e.toString());
      }

    }
  }
}
