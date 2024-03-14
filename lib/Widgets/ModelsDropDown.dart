import 'package:flutter/material.dart';
import 'package:heytalkai/Utilities/Constants.dart';

class ModelsDropDown extends StatefulWidget {
  const ModelsDropDown({super.key});

  @override
  State<ModelsDropDown> createState() => _ModelsDropDownState();
}

class _ModelsDropDownState extends State<ModelsDropDown> {
  String currentModel = "Model1";
  @override
  Widget build(BuildContext context) {
    return DropdownButton(
        items: getModelItems,
        value: currentModel,
        iconEnabledColor: Colors.black,
        onChanged: (value){
          setState(() {
            currentModel = value.toString();
          });
        });
  }
}
