import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class ProcrastiBuddyAIPage extends StatelessWidget {
  const ProcrastiBuddyAIPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          color: Colors.red,
          child: Center(child: "ProcrastiBuddyAIPage".text.xl.make())).centered(),
    );
  }
}
