import 'package:flutter/material.dart';
import 'package:to_do/home/settings/language_buttom_screen.dart';
import 'package:to_do/home/settings/mode_buttom_sheet.dart';
import 'package:to_do/my_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:to_do/provider/app_config_provider.dart';
import 'package:provider/provider.dart';

class SettingsTap extends StatefulWidget {
  @override
  State<SettingsTap> createState() => _SettingsTapState();
}

class _SettingsTapState extends State<SettingsTap> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return Container(
      margin: EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(AppLocalizations.of(context)!.language,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: provider.isDarkMode()?
                MyTheme.whiteColor
                    :
                MyTheme.blackColor
            ),),
          SizedBox(height: 10,),
          InkWell(
            onTap: (){
              showLanguageBottomSheet();
            },
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: provider.isDarkMode()?
                  MyTheme.blackColor
                      :
                  MyTheme.whiteColor
                  ,
                  borderRadius: BorderRadius.circular(25)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(provider.appLanguage == 'en' ?
                  AppLocalizations.of(context)!.english
                      :
                  AppLocalizations.of(context)!.arabic
                    , style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: MyTheme.primaryColor
                    )
                    ,),
                  Icon(Icons.arrow_drop_down,
                    color: MyTheme.primaryColor,
                    size: 25,)
                ],
              ),
            ),
          ),
          SizedBox(height: 20,),
          Text(AppLocalizations.of(context)!.mode,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: provider.isDarkMode()?
                MyTheme.whiteColor
                    :
                MyTheme.blackColor
            ),),
          SizedBox(height: 10,),
          InkWell(
            onTap: (){
              showModeBottomSheet();
            },
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: provider.isDarkMode()?
                  MyTheme.blackColor
                      :
                  MyTheme.whiteColor,
                  borderRadius: BorderRadius.circular(25)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(provider.isDarkMode() ?
                  AppLocalizations.of(context)!.dark
                      :
                  AppLocalizations.of(context)!.light
                    , style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: MyTheme.primaryColor
                    ),),
                  Icon(Icons.arrow_drop_down,
                    color: MyTheme.primaryColor
                    ,size: 25,)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void showLanguageBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (context) => LanguageButtomSheet());
  }

  void showModeBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (context) => ModeButtomSheet());
    }
}