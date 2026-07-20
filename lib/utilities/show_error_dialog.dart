import 'package:flutter/material.dart';

Future<void> showErrorDialog(
  BuildContext context,
   String test,
 ){
  return showDialog(
    context: context,
    builder: (context){
      return AlertDialog(
        title: const Text('An error occured'),
        content: Text(test),
        actions: [
          TextButton(
            onPressed: (){
                Navigator.of(context).pop();
            },
            child: const Text ('OK'))
        ],
      );
    }
    );
 }