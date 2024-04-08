import 'package:flutter/material.dart';
import 'package:offline_database_crud/Api/Provider/api_display_data_provider.dart';
import 'package:offline_database_crud/Api/Screen/api_display_data_list.dart';
import 'package:offline_database_crud/offline_database_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
          ChangeNotifierProvider(create: (_)=>OfflineDatabaseProvider()),
          ChangeNotifierProvider(create: (_)=>CategoryProvider()), 
            
      ],
      child: MaterialApp(       
        debugShowCheckedModeBanner: false,      
        title: 'Flutter Demo',       
        theme: ThemeData(         
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),         
          useMaterial3: true,       
          ),       
          home: HomeScreen(),     
          ),
      );
  }
}

