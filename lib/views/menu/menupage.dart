import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:procrasti_buddy/gen/assets.gen.dart';
import 'package:procrasti_buddy/routes/route_names.dart';
import 'package:velocity_x/velocity_x.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    List<String> categories = [
      "Appointments",
      "Tasks",
      "Bills and Payments",
      "Journal",
      "Pomodoro Clock",
      "Tips and Tricks",
    ];
    final List<String> imageList = [
      Assets.images.appointment,
      Assets.images.tasks,
      Assets.images.buyForCash,
      Assets.images.journal,
      Assets.images.pomodoro,
      Assets.images.dailyTasks,
    ];

    return Scaffold(
      extendBody: true,
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              itemCount: categories.length,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 1.27,
                crossAxisCount: 3,
                crossAxisSpacing: 15,
                mainAxisSpacing: 20,
              ),
              itemBuilder: (context, index) {
                return GridTile(
                  child: Card(
                    elevation: 2,
                    child: SizedBox(
                      width: 40,
                      height: 20,
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(10),
                          onTap: () {
                            Map<int, dynamic> routes = {
                              1: () => Navigator.pushNamed(
                                  context, RouteNames.appointmentPage),
                              2: () => Navigator.pushNamed(
                                  context, RouteNames.taskPage),
                              3: () => Navigator.pushNamed(
                                  context, RouteNames.billsAndPaymentPage),
                              4: () => Navigator.pushNamed(
                                  context, RouteNames.notesJournalPage),
                              5: () => Navigator.pushNamed(
                                  context, RouteNames.pomodoroPage),
                              6: () => Navigator.pushNamed(
                                  context, RouteNames.tipsAndTrickPage),
                            };
                            routes[index + 1]();
                          },
                          splashColor: Colors.greenAccent,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SvgPicture.asset(
                                imageList[index],
                                fit: BoxFit.cover,
                                width: 35,
                                height: 35,
                              ),
                              categories[index]
                                  .text
                                  .bold
                                  .center
                                  .scale(1)
                                  .maxLines(2)
                                  .make(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ).px12().py(15),
          ),
        ],
      ).py(10),
    );
  }
}
