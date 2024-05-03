
import 'package:flutter/material.dart';
import 'package:offline_database_crud/Api/Models/offline_database_category_model.dart';
import 'package:offline_database_crud/Api/Provider/api_display_data_provider.dart';
import 'package:offline_database_crud/Api/Screen/form_screen_api.dart';

import 'package:provider/provider.dart';

class CategorySearch extends SearchDelegate<String> {
  @override
  String get searchFieldLabel => 'Search by Name';

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, '');
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Implement search results here
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final categoryProvider = Provider.of<CategoryProvider>(context, listen: false);
    final categories = categoryProvider.categories;

    final filteredCategories = categories.where((category) {
      return category.name.toString().toLowerCase().contains(query.toLowerCase());
    }).toList();
      if (filteredCategories.isEmpty) {
      return Center(
        child: Text('No results found for "$query"'),
      );
    }

    return Consumer<CategoryProvider>(
        builder: (context, categoryProvider, _) {
          
          if (categoryProvider.isLoading) {
            // Show loading indicator
            return const Center(child: CircularProgressIndicator());
          }  else {
            // Show offline data
            return ListView.builder(
              itemCount: filteredCategories.length,
              itemBuilder: (context, index) {
               final category = filteredCategories[index];
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
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
                                        name: categoryProvider.nameController.text=category.name.toString(),
                                        description:categoryProvider.descriptionController.text=category.description.toString(),

                                      );
                                      categoryProvider.updateCategory(newData);
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
                               onTap: () {
              // Handle category selection
              close(context, category.name);
            },
                    ),
                  ),
                );
              },
            );
          }
        },
      );
  }
}









// import 'package:flutter/material.dart';
// //import 'package:offline_database_crud/Api/Models/offline_database_category_model.dart';
// import 'package:offline_database_crud/Api/Provider/api_display_data_provider.dart';
// import 'package:offline_database_crud/Api/Screen/form_screen_api.dart';

// import 'package:provider/provider.dart';

// class CategorySearch extends SearchDelegate<String> {
//   @override
//   String get searchFieldLabel => 'Search by Name';

//   @override
//   List<Widget> buildActions(BuildContext context) {
//     return [
//       IconButton(
//         onPressed: () {
//           query = '';
//         },
//         icon: const Icon(Icons.clear),
//       ),
//     ];
//   }

//   @override
//   Widget buildLeading(BuildContext context) {
//     return IconButton(
//       onPressed: () {
//         close(context, '');
//       },
//       icon: const Icon(Icons.arrow_back),
//     );
//   }

//   @override
//   Widget buildResults(BuildContext context) {
//     // Implement search results here
//     return Container();
//   }

//   @override
//   Widget buildSuggestions(BuildContext context) {
//     final categoryProvider = Provider.of<CategoryProvider>(context, listen: false);
//     final categories = categoryProvider.categories;

//     final filteredCategories = categories.where((category) {
//       return category.name.toString().toLowerCase().contains(query.toLowerCase());
//     }).toList();
//       if (filteredCategories.isEmpty) {
//       return Center(
//         child: Text('No results found for "$query"'),
//       );
//     }

//     return Consumer<CategoryProvider>(
//         builder: (context, categoryProvider, _) {
          
//           if (categoryProvider.isLoading) {
//             // Show loading indicator
//             return const Center(child: CircularProgressIndicator());
//           }  else {
//             // Show offline data
//             return ListView.builder(
//               itemCount: filteredCategories.length,
//               itemBuilder: (context, index) {
//                final category = filteredCategories[index];
//                 return Card(
//                   child: Padding(
//                     padding: const EdgeInsets.all(20.0),
//                     child: ListTile(
//                       leading: Text(category.id.toString()),
//                       title: Text(category.name),
//                       subtitle: Text(category.description),
//                        trailing: PopupMenuButton(
//                                 icon: const Icon(Icons.more_vert),
//                                 itemBuilder: (context) => [
//                                   PopupMenuItem(
//                                     child: const Text('Edit'),
//                                     onTap: () {
                              
//                                       //                                      DatabaseCategoryModel newData= DatabaseCategoryModel(
//                                       //   id: category.id,
//                                       //   name: categoryProvider.nameController.text=category.name.toString(),
//                                       //   description:categoryProvider.descriptionController.text=category.description.toString(),

//                                       // );
//                                      // categoryProvider.updateCategory(newData);
//                                       Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) => const FormScreenApi()),
//                               );
//                                     },
//                                   ),
//                                   PopupMenuItem(
//                                     onTap: ()async {
//                                        //await Provider.of<CategoryProvider>(context, listen: false).deleteCategory(category.id);
//                                     },
//                                     child: const Text('Delete'),
//                                   ),
//                                 ],
//                               ),
//                                onTap: () {
//               // Handle category selection
//               close(context, category.name);
//             },
//                     ),
//                   ),
//                 );
//               },
//             );
//           }
//         },
//       );
//   }
// }