import 'package:flutter/material.dart';
import 'package:offline_database_crud/sql_helper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> _journals = [];
  bool isLoading =true;
  void _refreshJournals()async{
    final data = await SQLHelper.getItems();
    setState(() {
      _journals = data;
      isLoading = false;
    });
  }
  ///// ADD ITEM /////
  Future<void> _addItem()async{
  await SQLHelper.createItem(_titleController.text, _descriptionController.text);
  _refreshJournals();
  }
  ////// UPDATE ITEM /////
    Future<void> _updateItem(int id)async{
  await SQLHelper.updateItem(id,_titleController.text, _descriptionController.text);
  _refreshJournals();
  }
  ////// DELETE ITEM /////
  Future <void> _deleteItem(int id)async{
  await SQLHelper.deleteItem(id);
  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Center(child: Text('Successfully Deleted'),))
  );
  _refreshJournals();
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _refreshJournals();
    print('Number of items ${_journals.length}');
  }
  final TextEditingController _titleController = TextEditingController();
   final TextEditingController _descriptionController = TextEditingController();
   void _showForm(int? id){
   if(id != null){
    final existingJournal = _journals.firstWhere((element) => element['id']==id);
    _titleController.text = existingJournal['title'];
    _descriptionController.text = existingJournal['description'];
   }
   showModalBottomSheet(
    context: context,
    elevation: 5,
    isScrollControlled: true,
    builder: (_)=>Container(
    padding: EdgeInsets.only(
      top: 15,
      left: 15,
      right: 15,
    bottom: MediaQuery.of(context).viewInsets.bottom + 120,
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        TextField(
          controller: _titleController,
          decoration: const InputDecoration(
            hintText:"Title",
          ),
        ),
        const SizedBox(height: 10,),
                TextField(
          controller: _descriptionController,
          decoration: const InputDecoration(
            hintText:"Description",
          ),
        ),
        const SizedBox(height: 20,),
        ElevatedButton(
        onPressed: ()async{
          if(id==null){
          await _addItem();
          }
          if(id != null){
          await _updateItem(id);
          }
          _titleController.text = '';
          _descriptionController.text ='';
        },
        child: Text(id == null ? 'Create New' : 'Update'),
        ),
      ],
    ),
    ),
    
    );
   }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OFFLINE DATA SQFLITE'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: _journals.length,
      itemBuilder: (context,index){
        return Card(
          color: Colors.orange[200],
          margin: EdgeInsets.all(15),
          child: ListTile(
            title: Text(_journals[index]['title']),
            subtitle: Text(_journals[index]['description']),
            trailing:SizedBox(
              width: 100,
              child: Row(
                children: [
                  IconButton(
                    onPressed: (){
                     _showForm(_journals[index]['id']);
                    }, 
                    icon: const Icon(Icons.edit)
                    ),
                  IconButton(
                    onPressed: ()=>_deleteItem(_journals[index]['id']),
                    icon: const Icon(Icons.delete))
                ],
              ),
            ),
          ),

        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: ()=>_showForm(null),
        child: const Icon(Icons.add),),
    );
  }
}