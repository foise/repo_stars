import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:repo_stars/bloc/app_model.dart';
import 'package:repo_stars/UI/home_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<GraphViewModel>(
          create: (_) => GraphViewModel(),
        ),
      ],
      builder: (context, child) {
        return MyApp();
      },
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Repo Stars',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeScreen(title: 'Repo Stars'),
    );
  }
}
