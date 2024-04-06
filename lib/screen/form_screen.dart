import 'package:flutter/material.dart';
import 'package:offline_database_crud/offline_database_provider.dart';
import 'package:provider/provider.dart';


class FormScreen extends StatefulWidget {

  const FormScreen({Key? key}) : super(key: key);
  

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Change Information'),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Consumer<OfflineDatabaseProvider>(builder: ((context, value, child) {

          return Column(
            children: [
              TextFormField(
                autofocus: false,
                decoration: const InputDecoration(
                  hintText: 'Enter Title',
                  prefixIcon: Icon(Icons.person),
                  //  labelText: ,
                  border: OutlineInputBorder(),
                  errorStyle: TextStyle(
                    color: Colors.redAccent,
                    fontSize: 15,
                  ),
                ),
                controller: value.titleController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please Enter Title';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              TextFormField(
                autofocus: false,
                decoration: const InputDecoration(
                  hintText: 'Enter Description ',
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                  errorStyle: TextStyle(
                    color: Colors.redAccent,
                    fontSize: 15,
                  ),
                ),
                controller: value.descriptionController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please Enter Description';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 15,
              ),
              InkWell(
                onTap: () {
  
    //  value.updateCategory(
    //   Category(
    //     id: value.catIdGet,
    //     name: value.nameController.text,
    //     profession: value.professionController.text,
    //   ),
    // );

                  Navigator.pop(context);
                },
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Center(child: Text('Submit')),
                ),
              ),
            ],
          );
        })),
      ),
    );
  }
}
