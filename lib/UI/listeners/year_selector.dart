import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:repo_stars/bloc/app_model.dart';

class YearSelector extends StatefulWidget {
  @override
  _YearSelectorState createState() => _YearSelectorState();
}

class _YearSelectorState extends State<YearSelector> {
  @override
  Widget build(BuildContext context) {
    return Consumer<GraphViewModel>(
      builder: (context, graphModel, child) {
        return DropdownButton<int>(
          value: graphModel.selectedYear,
          hint: Text('  ...'),
          icon: Icon(Icons.arrow_downward),
          iconSize: 20,
          elevation: 16,
          style: TextStyle(color: Colors.deepPurple),
          underline: Container(
            height: 2,
            color: Colors.deepPurpleAccent,
          ),
          onChanged: (int newValue) {
            graphModel.setSelectedYear(newValue);
          },
          items: graphModel.yearSelector,
        );
      },
    );
  }
}
