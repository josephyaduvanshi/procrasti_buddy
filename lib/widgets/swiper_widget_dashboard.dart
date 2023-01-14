import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:velocity_x/velocity_x.dart';

import '../routes/route_names.dart';
import '../utils/constants/constants.dart';

class SwiperWidgetDashboard extends StatelessWidget {
  const SwiperWidgetDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return VxSwiper.builder(
      viewportFraction: 0.45,
      height: 100,
      autoPlay: true,
      autoPlayInterval: 2.seconds,
      itemCount: Constants.categories.length,
      enlargeCenterPage: true,
      itemBuilder: ((context, index) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.2,
          width: MediaQuery.of(context).size.width * 0.4,
          decoration: BoxDecoration(
            color: Colors.blue.withOpacity(0.2),
            borderRadius: BorderRadius.circular(25),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: SvgPicture.asset(
                  Constants.imageList[index],
                  height: 100,
                ).px(8).py(8),
              ),
              Flexible(child: Constants.categories[index].text.bold.make()),
            ],
          ),
        ).onTap(() {
          Map<int, dynamic> routes = {
            1: () => Navigator.pushNamed(context, RouteNames.appointmentPage),
            2: () => Navigator.pushNamed(context, RouteNames.taskPage),
            3: () =>
                Navigator.pushNamed(context, RouteNames.billsAndPaymentPage),
            4: () => Navigator.pushNamed(context, RouteNames.notesJournalPage),
            5: () => Navigator.pushNamed(context, RouteNames.pomodoroPage),
            6: () => Navigator.pushNamed(context, RouteNames.tipsAndTrickPage),
          };
          routes[index + 1]();
        });
      }),
    );
  }
}
