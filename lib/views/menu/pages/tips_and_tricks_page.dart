import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:procrasti_buddy/gen/assets.gen.dart';
import 'package:procrasti_buddy/models/tips_tricks_model.dart';
import 'package:procrasti_buddy/services/http_helper/http_helper.dart';
import 'package:velocity_x/velocity_x.dart';

class TipsAndTricksPage extends StatefulWidget {
  const TipsAndTricksPage({Key? key}) : super(key: key);

  @override
  State<TipsAndTricksPage> createState() => _TipsAndTricksPageState();
}

class _TipsAndTricksPageState extends State<TipsAndTricksPage>
    with TickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: 'Tips and Tricks'.text.make(),
        elevation: 5,
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.blue[200]!, Colors.blue[600]!])),
        child: FutureBuilder<TipsTricksModel>(
          future: HttpHelper().getProcastinationTips(),
          builder: (context, snapShot) {
            if (snapShot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Lottie.asset(Assets.lottie.loading),
              );
            }
            if (snapShot.hasError) {
              return Center(
                child: Text(snapShot.error.toString()),
              );
            }
            return FadeTransition(
              opacity: Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
                  parent: _animationController, curve: Curves.easeIn)),
              child: ListView.builder(
                itemCount: snapShot.data?.tips?.length,
                itemBuilder: ((context, index) {
                  return Card(
                    color: Colors.blue[100],
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0)),
                    child: ListTile(
                      leading: Icon(
                        Icons.lightbulb_outline,
                        color: Colors.blue[500],
                        size: 40,
                      ),
                      title: snapShot.data?.tips?[index]?.tip
                          .toString()
                          .text
                          .xl
                          .bold
                          .make(),
                      subtitle: '=> ${snapShot.data?.tips?[index]?.explanation}'
                          .toString()
                          .text
                          .bold
                          .make(),
                    ).p16(),
                  ).px(8);
                }),
              ),
            );
          },
        ),
      ),
    );
  }
}
