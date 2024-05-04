import 'package:flutter/material.dart';
import 'package:offline_database_crud/Api/Screen/floating_button_form_api.dart';

import 'package:provider/provider.dart';
import 'package:offline_database_crud/Api/Models/offline_database_category_model.dart';
import 'package:offline_database_crud/Api/Provider/api_display_data_provider.dart';
import 'package:offline_database_crud/Api/Screen/form_screen_api.dart';
import 'package:offline_database_crud/Api/Screen/search_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<CategoryProvider>(context, listen: false).fetchCategoryList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
 appBar: AppBar(
  title: const Text('Get Api List Data'),
  centerTitle: true,
  backgroundColor: Colors.orange,
  actions: [
    IconButton(
      icon: const Icon(Icons.search),
      onPressed: () => showSearch(context: context, delegate: CategorySearch()),
    ),
  ],
),

      body: Consumer<CategoryProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (provider.categories.isEmpty) {
            return const Center(child: Text("No categories found"));
          } else {
            return ListView.builder(
              itemCount: provider.categories.length,
              itemBuilder: (context, index) {
                final category = provider.categories[index];
                return Card(
                  child: ListTile(
                    leading: Text(category.id.toString()),
                    title: Text(category.name),
                    subtitle: Text(category.description),
                  trailing: PopupMenuButton(
                                icon: const Icon(Icons.more_vert),
                                itemBuilder: (context) => [
                                  PopupMenuItem(
                                    child: const Text('Edit'),
                                    onTap: () {
                              
                                      DatabaseCategoryModel newData= DatabaseCategoryModel(
                                        id: category.id,
                                        name: provider.nameController.text=category.name.toString(),
                                        description:provider.descriptionController.text=category.description.toString(),

                                      );
                                      provider.updateCategory(newData);
                                      Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const FormScreenApi()),
                              );
                                    },
                                  ),
                                  PopupMenuItem(
                                    onTap: ()async {
                                       await Provider.of<CategoryProvider>(context, listen: false).deleteCategory(category.id);
                                    },
                                    child: const Text('Delete'),
                                  ),
                                ],
                              ),
                  ),
                );
              },
            );
          }
        },
      ),
            floatingActionButton: Consumer<CategoryProvider>(
        builder: (BuildContext context, CategoryProvider value, Widget? child) { 
          return FloatingActionButton(
          onPressed: (){
                   value.nameController.clear();
                    value.descriptionController.clear();
            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const FloatingButtonFormApi()));
          },
          child: const Icon(Icons.add),
          );
         },
     
      ),
    );
  }
}
