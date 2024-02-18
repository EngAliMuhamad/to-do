import 'package:flutter/material.dart';
import 'package:to_do/home/home_screen.dart';
import 'package:to_do/my_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:to_do/provider/app_config_provider.dart';
import 'package:provider/provider.dart';
void main(){
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
        initialRoute: HomeScreen.routeName,
        routes:{
          HomeScreen.routeName: (context) => HomeScreen(),
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
