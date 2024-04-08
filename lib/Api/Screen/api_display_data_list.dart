
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








// import 'package:flutter/material.dart';
// import 'package:offline_database_crud/Api/Provider/api_display_data_provider.dart';
// import 'package:provider/provider.dart';

// class HomeScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Get Api List Data'),
//         centerTitle: true,
//         backgroundColor: Colors.orange,
//       ),
//       body: FutureBuilder(
//         future: Provider.of<CategoryProvider>(context, listen: false).fetchCategoryListFromAPI(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           } else if (snapshot.hasError) {
//             return Center(
//               child: Text('Error: ${snapshot.error}'),
//             );
//           } else {
//             return Consumer<CategoryProvider>(
//               builder: (context, categoryProvider, _) {
//                 final categories = categoryProvider.categories;
//                 if (categories.isEmpty) {
//                   return const Center(
//                     child: Text('No data available'),
//                   );
//                 } else {
//                   return ListView.builder(
//                     itemCount: categories.length,
//                     itemBuilder: (context, index) {
//                       final category = categories[index];
//                       return Card(
//                         child: Padding(
//                           padding: const EdgeInsets.all(20.0),
//                           child: ListTile(
//                             leading: Text(category.id.toString()),
//                             title: Text(category.name),
//                             subtitle: Text(category.description),
//                           ),
//                         ),
//                       );
//                     },
//                   );
//                 }
//               },
//             );
//           }
//         },
//       ),
//     );
//   }
// }




// import 'package:flutter/material.dart';
// import 'package:offline_database_crud/Api/Provider/api_display_data_provider.dart';
// import 'package:provider/provider.dart';

// class HomeScreen extends StatefulWidget {
  
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     Provider.of<CategoryProvider>(context, listen: false).fetchCategoryList();
//   }
//   @override
//   Widget build(BuildContext context) {
    
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Category List'),
//         centerTitle: true,
//         backgroundColor: Colors.orange,
//       ),
//       body: Consumer<CategoryProvider>(
//         builder: (context, categoryProvider, _) {
//           final categories = categoryProvider.categories;
//           if (categories.isEmpty) {
//             return const Center(
//               child: Text('No categories available'),
//             );
//           } else {
//             return ListView.builder(
//               itemCount: categories.length,
//               itemBuilder: (context, index) {
//                 final category = categories[index];
//                 return ListTile(
//                         leading: Text(category.id.toString()),
//                       title: Text(category.name),
//                       subtitle: Text(category.description),
//                 );
//               },
//             );
//           }
//         },
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:offline_database_crud/Api/Provider/api_display_data_provider.dart';

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
    final loadingProvider = Provider.of<CategoryProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Get Api List Data'),
        centerTitle: true,
        backgroundColor: Colors.orange,
      ),
      body: Consumer<CategoryProvider>(
        builder: (context, categoryProvider, _) {
          final categories = categoryProvider.categories;
          if (loadingProvider.isLoading) {
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
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}



