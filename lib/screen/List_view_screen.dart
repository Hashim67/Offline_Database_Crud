import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:offline_database_crud/offline_database_provider.dart';
import 'package:offline_database_crud/screen/floating_button_form.dart';
import 'package:offline_database_crud/screen/form_screen.dart';

import 'package:provider/provider.dart';


class NameListScreen extends StatefulWidget {
  const NameListScreen({super.key});

  @override
  State<NameListScreen> createState() => _NameListScreenState();
}

class _NameListScreenState extends State<NameListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<OfflineDatabaseProvider>(context, listen: false).JournalProvider();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Name'),
        centerTitle: true,
        backgroundColor: Colors.orange,
      ),
      body: Consumer<OfflineDatabaseProvider>(
        builder: (context, value, child) {
          // return value.journals.isEmpty? const Center(child: Text('No Data')) : 
      return    ListView.builder(
            itemCount: value.journals.length,
            itemBuilder: (context, index) {

            final journal = value.journals[index];

              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  
                    
                    child: Consumer<OfflineDatabaseProvider>(
                      builder: ( context, value,  child) {
                        return ListTile(
                          title: Text(journal.title),
                          subtitle:Text(journal.description),
                  
                                                trailing: PopupMenuButton(
                        icon: const Icon(Icons.more_vert),
                        itemBuilder: (context) => [
                          PopupMenuItem(
                            child: const Text('Edit'),
                            onTap: () {

                      Journal newData = Journal(
                        id: journal.id,
                        title: value.titleController.text = journal.title, 
                        description: value.descriptionController.text = journal.description);
                        value.updateJournal(newData);
                                              SchedulerBinding.instance.addPostFrameCallback((_) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FormScreen()));
                      });
                           
                            },
                          ),
                          PopupMenuItem(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (ctx) => AlertDialog(
                                  title: const Text("Delete Category"),
                                  content: const Text(
                                      "Are you sure you want to delete category"),
                                  actions: <Widget>[
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.of(ctx).pop();
                                      },
                                      child: const Text("No"),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        value.deleteItem(journal.id);
                                        Navigator.of(ctx).pop();
                                      },
                                      child: const Text("Yes"),
                                    ),
                                  ],
                                ),
                              );
                            },
                            child: const Text('Delete'),
                          ),
                        ],
                      ),
                        
                      ); 

                       },
                     
                    ),
                  
                ),
                
              );
            },
            
          );
          
        },
        
      ),
      floatingActionButton: Consumer<OfflineDatabaseProvider>(
        builder: (BuildContext context, OfflineDatabaseProvider value, Widget? child) { 
          return FloatingActionButton(
          onPressed: (){
                   value.titleController.clear();
                    value.descriptionController.clear();
            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => FloatingForm()));
          },
          child: const Icon(Icons.add),
          );
         },
     
      ),
    );
  }
}



