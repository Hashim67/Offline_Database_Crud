import 'package:flutter/material.dart';
import 'package:offline_database_crud/offline_database_provider.dart';
import 'package:offline_database_crud/screen/List_view_screen.dart';
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
      ],
      child: MaterialApp(       
        debugShowCheckedModeBanner: false,      
        title: 'Flutter Demo',       
        theme: ThemeData(         
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),         
          useMaterial3: true,       
          ),       
          home: const NameListScreen(),     
          ),
      );
  }
}

