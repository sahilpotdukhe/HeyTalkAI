import 'package:flutter/material.dart';
import 'package:heytalkai/Utilities/ScreenDimensions.dart';
import 'package:heytalkai/Widgets/ModelsDropDown.dart';

class Services{

  static Future<void> showModalSheet({required BuildContext context}) async{
    ScaleUtils.init(context);
    await showModalBottomSheet(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
                top: Radius.circular(20*ScaleUtils.scaleFactor)
            ),
        ),
        context: context,
        builder:(context) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding:  EdgeInsets.all(18.0*ScaleUtils.scaleFactor),
                child: Text('Chosen Model',style: TextStyle(fontSize: 16*ScaleUtils.scaleFactor),),
              ),
              Flexible(child: ModelsDropDown())
            ],
          );
        }
    );
  }
}