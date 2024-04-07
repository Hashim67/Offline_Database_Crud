import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:offline_database_crud/sql_helper.dart';

class Journal {
   int id;
   String title;
   String description;

  Journal({required this.id, required this.title, required this.description});
}


class OfflineDatabaseProvider extends ChangeNotifier{
   TextEditingController _titleController = TextEditingController();
   TextEditingController get titleController => _titleController; 
   TextEditingController _descriptionController = TextEditingController();
   TextEditingController get descriptionController => _descriptionController;

  List<Journal> _journals = [];
  List<Journal> get journals => _journals;
  
  int _catId = 0;
  int get catIdGet => _catId;
    void setCatId(int id) {
    _catId = id;
    notifyListeners();
  }
   
  void JournalProvider() {
    _refreshJournals();
  }

 

  Future<void> _refreshJournals() async {
    final data = await SQLHelper.getItems();
    _journals = data.map((item) => Journal(id: item['id'], title: item['title'], description: item['description'])).toList();
  
    notifyListeners();
  }

  Future<void> addJournal(String title, String? description) async {
    await SQLHelper.createItem(title, description);
    _refreshJournals();
  }

  Future<void> updateJournal(Journal val) async {
    await SQLHelper.updateItem(val.id, val.title, val.description);
       print('Category Data : ${val.id} >> ${val.title} >>>${val.description}');
    for(Journal journals in _journals){
      if(journals.id == val.id){
        setCatId(val.id);
        journals.title = val.title;
        journals.description = val.description;
         break;

      }
    }
    _refreshJournals();
   
  }

  Future<void> deleteItem(int id) async {
    await SQLHelper.deleteItem(id);
    _refreshJournals();
  }
}




  
