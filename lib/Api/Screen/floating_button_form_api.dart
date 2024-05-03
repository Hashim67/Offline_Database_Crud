import 'package:flutter/material.dart';
import 'package:offline_database_crud/Api/Provider/api_display_data_provider.dart';
import 'package:provider/provider.dart';

class FloatingButtonFormApi extends StatefulWidget {
  const FloatingButtonFormApi({super.key});

  @override
  State<FloatingButtonFormApi> createState() => _FloatingButtonFormApiState();
}

class _FloatingButtonFormApiState extends State<FloatingButtonFormApi> {
   @override
  void initState() {
    super.initState();
    // Fetch offline data after a short delay
    Future.delayed(const Duration(milliseconds: 0), () {
      Provider.of<CategoryProvider>(context, listen: false)
          .fetchCategoryList();
      
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fill the Information'),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: Consumer<CategoryProvider>(
        builder:(context, value, child){
          return Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
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
                    controller: value.nameController,
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
                       value.createCategory(value.nameController.text, value.descriptionController.text);
 
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
            ),
        );
        }
   
      ),
    );
  }
}
















// import 'package:flutter/material.dart';
// import 'package:offline_database_crud/Api/Provider/api_display_data_provider.dart';
// import 'package:provider/provider.dart';

// class FloatingButtonFormApi extends StatefulWidget {
//   const FloatingButtonFormApi({super.key});

//   @override
//   State<FloatingButtonFormApi> createState() => _FloatingButtonFormApiState();
// }

// class _FloatingButtonFormApiState extends State<FloatingButtonFormApi> {
//    @override
//   // void initState() {
//   //   super.initState();
//   //   // Fetch offline data after a short delay
//   //   Future.delayed(const Duration(milliseconds: 0), () {
//   //     Provider.of<CategoryProvider>(context, listen: false)
//   //         .fetchCategoryList();
      
//   //   });
//   // }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Fill the Information'),
//         centerTitle: true,
//         backgroundColor: Colors.green,
//       ),
//       body: Consumer<CategoryProvider>(
//         builder:(context, value, child){
//           return Padding(
//           padding: const EdgeInsets.all(15.0),
//           child: Column(
//             children: [
//               TextFormField(
//                     autofocus: false,
//                     decoration: const InputDecoration(
//                       hintText: 'Enter Name',
//                       prefixIcon: Icon(Icons.person),
//                       //  labelText: ,
//                       border: OutlineInputBorder(),
//                       errorStyle: TextStyle(
//                         color: Colors.redAccent,
//                         fontSize: 15,
//                       ),
//                     ),
//                     controller: value.nameController,
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please Enter Name';
//                       }
//                       return null;
//                     },
//                   ),
//                   const SizedBox(height: 15),
//                   TextFormField(
//                     autofocus: false,
//                     decoration: const InputDecoration(
//                       hintText: 'Enter Description ',
//                       prefixIcon: Icon(Icons.person),
//                       border: OutlineInputBorder(),
//                       errorStyle: TextStyle(
//                         color: Colors.redAccent,
//                         fontSize: 15,
//                       ),
//                     ),
//                     controller: value.descriptionController,
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please Enter Description';
//                       }
//                       return null;
//                     },
//                   ),
//                    const SizedBox(
//                   height: 15,
//                 ),
//                  InkWell(
//                   onTap: () {
//                     //   value.createCategory(value.nameController.text, value.descriptionController.text);
 
//     Navigator.pop(context);    
                
//                   },
//                   child: Container(
//                     height: 50,
//                     decoration: BoxDecoration(
//                       color: Colors.orange,
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     child: const Center(child: Text('Submit')),
//                   ),
//                 ),
//             ],
//             ),
//         );
//         }
   
//       ),
//     );
//   }
// }