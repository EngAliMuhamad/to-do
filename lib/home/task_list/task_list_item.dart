import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:to_do/firebase_utils.dart';
import 'package:to_do/model/task.dart';
import 'package:to_do/my_theme.dart';
import 'package:provider/provider.dart';
import 'package:to_do/provider/app_config_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TaskListItem extends StatefulWidget {
  Task task;
  TaskListItem({required this .task});

  @override
  State<TaskListItem> createState() => _TaskListItemState();
}

class _TaskListItemState extends State<TaskListItem> {
  @override
  Widget build(BuildContext context) {
    var appconfigprovider = Provider.of<AppConfigProvider>(context);
    return Container(
        margin: EdgeInsets.all(12),
        child: Slidable(//Slidable
          // The start action pane is the one at the left or the top side.
            startActionPane: ActionPane(
              extentRatio: 0.25,
              // A motion is a widget used to control how the pane animates.
              motion: const ScrollMotion(),

              // All actions are defined in the children parameter.
              children:  [
                // A SlidableAction can have an icon and/or a label.
                SlidableAction(
                  borderRadius: BorderRadius.circular(12),
                  onPressed: (context){
                    FirebaseUtils.deleteTaskFromFireStore(widget.task).timeout(Duration(milliseconds: 500),onTimeout: (){
                      print('task deleted successfully');
                      appconfigprovider.getAllTasksFireStore();
                    });
                  },
                  backgroundColor: MyTheme.redColor,
                  foregroundColor: MyTheme.whiteColor,
                  icon: Icons.delete,
                  label: 'Delete',
                ),
              ],
            ),
            child: Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: appconfigprovider.isDarkMode()?
                  MyTheme.blackColor
                      :
                  MyTheme.whiteColor
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height*0.10,
                    width: 4,
                    color: MyTheme.primaryColor,
                  ),
                  SizedBox(width: 10,),
                  Expanded(child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        widget.task.title ?? '',//task
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: MyTheme.primaryColor
                        ),),
                      Text(widget.task.description ??'',//description
                          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: appconfigprovider.isDarkMode()?
                          MyTheme.whiteColor
                              :
                          MyTheme.blackColor
                      )),
                    ],)),
                  Container(
                    padding: EdgeInsets.symmetric(
                        vertical: 7,
                        horizontal: 21
                    ),
                    decoration: BoxDecoration(
                        color: MyTheme.primaryColor,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Icon(Icons.check,color: MyTheme.whiteColor,size: 20,),
                  )
                ],),
            ),
            ),
        );
    }
}