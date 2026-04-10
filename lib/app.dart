/*import 'package:flutter/material.dart';
import 'routes/app_routes.dart';

class MyApp extends StatelessWidget {
<<<<<<< HEAD
   const MyApp({super.key});
=======
  const MyApp({super.key});
>>>>>>> origin/simulation-insta-1
  @override
  
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: AppRoutes.routes,
    );
  }
}
*/
import 'package:flutter/material.dart';
import 'routes/app_routes.dart';
import 'core/auth/auth_wrapper.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Safe Digital Learning',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange,
        fontFamily: 'Roboto',
      ),
      home: const AuthWrapper(),
      routes: AppRoutes.routes,
    );
  }
}
