import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:repo_stars/viewmodels/graph_vm.dart';

class InputField extends StatefulWidget {
  @override
  _InputFieldState createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  TextEditingController nameEditController;

  @override
  void initState() {
    super.initState();
    nameEditController = new TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GraphViewModel>(
      builder: (context, model, child) => Container(
        margin: EdgeInsets.only(left: 20, top: 20, right: 20, bottom: 10),
        padding: EdgeInsets.only(left: 5, top: 5, right: 20, bottom: 00),
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(3),
              topRight: Radius.circular(3),
              bottomLeft: Radius.circular(3),
              bottomRight: Radius.circular(3)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              spreadRadius: 3,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconButton(
              icon: new Icon(Icons.search),
              onPressed: () {
                model.updateRepos(nameEditController.text);
              },
            ),
            SizedBox(width: 10),
            Expanded(
              child: TextField(
                controller: nameEditController,
                decoration: InputDecoration.collapsed(
                    hintText: "Enter Github Account Name"),
                onSubmitted: (String name) => {model.updateRepos(name)},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
