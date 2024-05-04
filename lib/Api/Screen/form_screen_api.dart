import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:offline_database_crud/Api/Data/Network/network_api_service.dart';
import 'package:offline_database_crud/Api/Models/offline_database_category_model.dart';

import 'package:offline_database_crud/Api/Provider/api_display_data_provider.dart';
import 'package:offline_database_crud/Offline%20Database/sqflite_helper.dart';

import 'package:provider/provider.dart';
class FormScreenApi extends StatefulWidget {
  const FormScreenApi({super.key});

  @override
  State<FormScreenApi> createState() => _FormScreenApiState();
}

class _FormScreenApiState extends State<FormScreenApi> {
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
        child: Consumer<CategoryProvider>(builder: ((context, categoryProvider, child) {

          return Column(
            children: [
              TextFormField(
                autofocus: false,
                decoration: const InputDecoration(
                  hintText: 'Enter Name',
                  prefixIcon: Icon(Icons.person),
                  //  labelText: ,
                  border: OutlineInputBorder(),
                  errorStyle: TextStyle(
                    color: Colors.redAccent,
                    fontSize: 15,
                  ),
                ),
                controller: categoryProvider.nameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please Enter Name';
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
                controller: categoryProvider.descriptionController,
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
               onTap: () async {
  var res = await NetworkApiService().updateCategoryData(
    categoryProvider.catIdGet,
    categoryProvider.nameController.text,
    categoryProvider.descriptionController.text,
  );
  log('Category >>> res statusCode : ${res.statusCode} >>> body : ${res.body}');
  if (res.statusCode == 200) {
    // Update the data in the local offline database
    await SQLHelper.updateCategory(DatabaseCategoryModel(
      id: categoryProvider.catIdGet,
      name: categoryProvider.nameController.text,
      description: categoryProvider.descriptionController.text,
    ));

    // Update the data in the provider
    Provider.of<CategoryProvider>(context, listen: false).updateCategory(DatabaseCategoryModel(
      id: categoryProvider.catIdGet,
      name: categoryProvider.nameController.text,
      description: categoryProvider.descriptionController.text,
    ));
    await Provider.of<CategoryProvider>(context,
                              listen: false)
                          .fetchCategoryList();
    Navigator.pop(context);
  } else {
    print('Something went wrong');
  }
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
