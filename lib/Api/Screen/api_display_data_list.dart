
// import 'package:flutter/material.dart';
// import 'package:offline_database_crud/Api/Data/Response/status.dart';
// import 'package:offline_database_crud/Api/Provider/api_display_data_provider.dart';
// import 'package:provider/provider.dart';

// // import 'package:mvvm/Model/auth_model.dart';



// class HomeScreen extends StatefulWidget {
//   const HomeScreen({Key? key}) : super(key: key);

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   HomeViewModel homeViewModel = HomeViewModel();
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     homeViewModel.fetchCategoryListApi();
//   }

  

//   @override
//   Widget build(BuildContext context) {
    
    
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         title:  Text('Get Api List Data'),
//         centerTitle: true,
//         backgroundColor: Colors.orange,
        
//       ),
//       body:ChangeNotifierProvider<HomeViewModel>(
//   create: (BuildContext context) => homeViewModel,
//   child: Consumer<HomeViewModel>(
//     builder: (context, value, _) {
//       switch (value.categoryList.status) {
//         case Status.LOADING:
//           return const Center(child: CircularProgressIndicator());
//         case Status.ERROR:
          
//           return Center(child: Text(value.categoryList.message.toString()));
//         case Status.COMPLETED:
//           return ListView.builder(
//             itemCount: value.categoryList.data!.data!.length,
//             itemBuilder: ((context, index) {
            
//             return Card(
//               child: ListTile(
//                 leading: Text(value.categoryList.data!.data![index].id.toString()),
                
//                 title: Text(value.categoryList.data!.data![index].name.toString()),
//                 subtitle: Text(value.categoryList.data!.data![index].description.toString()),
               
//               ),
//             );
//           }));
//         default:
        
//           return Container(); // or any other appropriate action
//       }
      
//     },
  
//   ),
  
// ),


//     );
    
//   }
// }


import 'package:flutter/material.dart';

import 'package:offline_database_crud/Api/Models/offline_database_category_model.dart';

import 'package:offline_database_crud/Api/Provider/api_display_data_provider.dart';
import 'package:offline_database_crud/Api/Screen/floating_button_form_api.dart';
import 'package:offline_database_crud/Api/Screen/form_screen_api.dart';
import 'package:offline_database_crud/Api/Screen/search_screen.dart';
import 'package:provider/provider.dart';



class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch offline data after a short delay
    Future.delayed(const Duration(milliseconds: 0), () {
      Provider.of<CategoryProvider>(context, listen: false)
          .fetchCategoryList();
      // Update loading state to false
      Provider.of<CategoryProvider>(context, listen: false).setLoading(false);
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
            onPressed: () {
              showSearch(context: context, delegate: CategorySearch());
            },
          ),
        ],
      ),
      body: Consumer<CategoryProvider>(
        builder: (context, categoryProvider, _) {
          final categories = categoryProvider.categories;
          if (categoryProvider.isLoading) {
            // Show loading indicator
            return const Center(child: CircularProgressIndicator());
          }  else {
            // Show offline data
            return ListView.builder(
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
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
                                  builder: (context) => FloatingButtonFormApi()));
          },
          child: const Icon(Icons.add),
          );
         },
     
      ),
    );
    
  }
}



