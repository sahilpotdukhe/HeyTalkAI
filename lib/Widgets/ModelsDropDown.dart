import 'package:flutter/material.dart';
import 'package:heytalkai/Models/APIModelsModel.dart';
import 'package:heytalkai/Provider/ModelsProvider.dart';
import 'package:provider/provider.dart';

class ModelsDropDown extends StatefulWidget {
  const ModelsDropDown({super.key});

  @override
  State<ModelsDropDown> createState() => _ModelsDropDownState();
}

class _ModelsDropDownState extends State<ModelsDropDown> {
  String? currentModel;

  @override
  Widget build(BuildContext context) {
    final modelsProvider = Provider.of<ModelsProvider>(context,listen: false);
    currentModel = modelsProvider.getCurrentModel;

    return FutureBuilder<List<APIModelsModel>>(
        future: modelsProvider.getAllModels(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return (snapshot.data == null || snapshot.data!.isEmpty)
              ? Text('Loading models...')
              : DropdownButton(
                  items: List<DropdownMenuItem<String>>.generate(
                      snapshot.data!.length,
                      (index) => DropdownMenuItem(
                          value: snapshot.data![index].id,
                          child: Text(snapshot.data![index].id))),
                  value: currentModel,
                  iconEnabledColor: Colors.black,
                  onChanged: (value) {
                    setState(() {
                      currentModel = value.toString();
                    });
                    modelsProvider.setCurrentModel(value.toString());
                  });
        });
  }
}
