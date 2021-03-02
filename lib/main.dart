import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:repo_stars/viewmodels/graph_vm.dart';
import 'package:repo_stars/views/home_view.dart';

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
      home: HomeView(title: 'Repo Stars'),
    );
  }
}
