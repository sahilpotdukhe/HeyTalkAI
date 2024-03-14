import 'package:flutter/material.dart';
import 'package:heytalkai/Widgets/ModelsDropDown.dart';

class Services{

  static Future<void> showModalSheet({required BuildContext context}) async{
    await showModalBottomSheet(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
                top: Radius.circular(20)
            )
        ),
        context: context,
        builder:(context) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children:const [
              Padding(
                padding:  EdgeInsets.all(18.0),
                child: Text('Chosen Model'),
              ),
              Flexible(child: ModelsDropDown())
            ],
          );
        }
    );
  }
}