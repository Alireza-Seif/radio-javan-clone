
import 'package:flutter/material.dart';

Widget showProgressBar(BuildContext context){
  return const Center(child: CircularProgressIndicator());
}

Widget showError( {required String text}){
  return Text(text, style: const TextStyle(color: Colors.white),);
}