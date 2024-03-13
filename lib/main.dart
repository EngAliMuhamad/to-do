import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:to_do/auth/register/login_screen.dart';
import 'package:to_do/auth/register/register_screen.dart';
import 'package:to_do/home/home_screen.dart';
import 'package:to_do/my_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:to_do/provider/app_config_provider.dart';
import 'package:provider/provider.dart';
void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseFirestore.instance.settings =
      Settings(cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED);
  await FirebaseFirestore.instance.clearPersistence();
  runApp(ChangeNotifierProvider(
      create: (context) => AppConfigProvider(),
      child: (MyApp()))) ;
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return  MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: LoginScreen.routeName,
        routes:{
          HomeScreen.routeName: (context) => HomeScreen(),
          RegisterScreen.routeName: (context) => RegisterScreen(),
          LoginScreen.routeName: (context) => LoginScreen(),



        } ,
        theme: MyTheme.lightMode,
        themeMode: provider.appTheme,
        darkTheme: MyTheme.darkMode,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: Locale(provider.appLanguage),
        );
    }
}
