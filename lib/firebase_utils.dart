import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:to_do/model/task.dart';

class FirebaseUtils{
  static CollectionReference<Task>getTaskCollection(){
    return
      FirebaseFirestore.instance.collection(Task.collectionName).
      withConverter<Task>(
          fromFirestore: ((snapshot, options) =>Task.fromFireStore(snapshot.data()!)),
          toFirestore:(task,_)=> task.toFireStore());

  }

  static Future<void> addTaskToFireStore(Task task){
   CollectionReference<Task> taskCollection= getTaskCollection();   ///collection
   DocumentReference<Task> taskDocRrf=taskCollection.doc();
   task.id  =taskDocRrf.id;      ///outo id
    return taskDocRrf.set(task);

  }
  static  Future<void> deleteTaskFromFireStore(Task task ){
     return getTaskCollection().doc(task.id).delete();
  }

}