import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:talabat/src/getxcot.dart';

import '../src/colors.dart';

class Mysection extends StatelessWidget {
  Mysection({Key? key, required this.title, required this.onPressed})
      : super(key: key);

  String title;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 5),
      child: GetBuilder<GetxCot>(
          init: GetxCot(),
          builder: (value) {
            return MaterialButton(
                minWidth: 0,
                color: Ccolors().globel,
                padding: EdgeInsets.zero,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25))),
                onPressed: onPressed,
                child: Row(
                  children: [
                    const CircleAvatar(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(title),
                    ),
                  ],
                ));
          }),
    );
  }
}
