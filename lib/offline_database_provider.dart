import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:offline_database_crud/sql_helper.dart';

class OfflineDatabaseProvider extends ChangeNotifier{
   TextEditingController _titleController = TextEditingController();
   TextEditingController get titleController => _titleController; 
   TextEditingController _descriptionController = TextEditingController();
   TextEditingController get descriptionController => _descriptionController;
   int id = 0;
 

  List<Map<String, dynamic>> _journals = [];
  List<Map<String, dynamic>> get journals => _journals;
  setJournals(value){
    _journals = value;
  }

    void refreshJournals()async{
    final data = await SQLHelper.getItems();
     _journals = data;

  }

    ///// ADD ITEM /////
  Future<void> addItem()async{
  await SQLHelper.createItem(_titleController.text, _descriptionController.text);
  refreshJournals();
  }

    ////// UPDATE ITEM /////
    Future<void> updateItem(int id)async{
  await SQLHelper.updateItem(id,_titleController.text, _descriptionController.text);
  refreshJournals();
  }

    ////// DELETE ITEM /////
  Future <void> deleteItem()async{
  await SQLHelper.deleteItem(id);
  refreshJournals();
  }
}