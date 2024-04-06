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
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   Provider.of<OfflineDatabaseProvider>(context, listen: false).;
    // });
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
          return ListView.builder(
            itemCount: value.journals.length,
            itemBuilder: (context, index) {


              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: InkWell(
                    onTap: () {
                      // Category newData = Category(
                      //     id: value.items[index].id,
                      //     name: value.nameController.text =
                      //         value.items[index].name,
                      //     profession: value.professionController.text =
                      //         value.items[index].profession);
                      // value.updateCategory(newData);

                      SchedulerBinding.instance.addPostFrameCallback((_) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FormScreen()));
                      });
                    },
                    child: Consumer<OfflineDatabaseProvider>(
                      builder: ( context, value,  child) {
                        return ListTile(
                          leading: Text(
                            value.journals[index].toString(),
                          ),
                          title: Row(
                            children: [
                               value.journals[index]['title'],
                        
                              
                            ],
                          ),
                          subtitle: Row(
                            children: [
                              value.journals[index]['description'],
                        
                             
                            ],
                          ),
                                                trailing: PopupMenuButton(
                        icon: const Icon(Icons.more_vert),
                        itemBuilder: (context) => [
                          PopupMenuItem(
                            child: const Text('Edit'),
                            onTap: () {
                              // Category newData = Category(
                              //     id: category.id,
                              //     title: value.titleController.text =
                              //         category.title,
                              //     body: value.bodyController.text =
                              //         category.body);
                              // value.updateCategory(newData);
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //       builder: (context) => const FormScreen()),
                              // );
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
                                        value.deleteItem();
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



