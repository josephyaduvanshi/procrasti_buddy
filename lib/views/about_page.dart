import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:procrasti_buddy/utils/snackbar.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:velocity_x/velocity_x.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        backgroundColor: context.canvasColor,
        appBar: AppBar(
          elevation: 5,
          title: "Get To Know Us".text.maxLines(1).minFontSize(23).make(),
          leading: IconButton(
              splashColor: Colors.blue,
              splashRadius: 18.0,
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios,
              )),
        ),
        body: SafeArea(
          child: ListView.builder(
            itemCount: 2,
            itemBuilder: (context, index) {
              if (index == 0) {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: context.cardColor,
                  ),
                  child: Wrap(
                    children: [
                      Wrap(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              "Procrasti Buddy!"
                                  .text
                                  .minFontSize(20)
                                  .bold
                                  .textStyle(GoogleFonts.notoSans())
                                  .make(),
                              2.heightBox.px8().py(0),
                              "OverView & Short description."
                                  .text
                                  .bold
                                  .caption(context)
                                  .make()
                                  .py(8),
                              "Introducing ProcrastiBuddy - the ultimate productivity companion for busy bees everywhere! Our app is designed to help you conquer the chaos of everyday life and stay on top of your schedule. With a clean and user-friendly interface, you can easily manage your tasks, appointments, bills and payments, shopping lists, and more. But that's not all! ProcrastiBuddy comes equipped with a cutting-edge adaptive color scheme, which adjusts to your preferred lighting conditions for optimal use. Plus, with the integration of Hive, you can now enjoy the power of persistence, allowing you to access and manage your tasks even when offline. Say goodbye to disorganization and hello to productivity with ProcrastiBuddy!"
                                  .text
                                  .maxLines(12)
                                  .italic
                                  .textStyle(GoogleFonts.nunitoSans())
                                  .make()
                            ],
                          ),
                        ],
                      ),
                    ],
                  ).p(8),
                ).pOnly(top: 8, bottom: 5, right: 8, left: 8);
              } else if (index == 1) {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: context.cardColor,
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: Column(
                      children: [
                        "Contact us on:"
                            .text
                            .caption(context)
                            .bold
                            .scale(0.9)
                            .center
                            .make()
                            .pOnly(
                              top: 5,
                            ),
                        const Divider(
                          thickness: 0.8,
                        ),
                        Row(
                          children: [
                            TextButton.icon(
                              onPressed: () async {},
                              icon: const Icon(Icons.support),
                              label: const Text(
                                'Support Center',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextButton.icon(
                                onPressed: () async {
                                  const contactEmail = "shaivitesdev@gmail.com";
                                  const subjectPart = "Subject";
                                  const bodyPart = "Device Information Pro";
                                  final urlPart =
                                      "mailto:$contactEmail?subject=${Uri.encodeFull(subjectPart)}&body=${Uri.encodeFull(bodyPart)}";
                                  if (await canLaunch(urlPart)) {
                                    await launch(urlPart);
                                  } else {
                                    ShowSnackBar.materialSnackbar(
                                        context: context,
                                        title: 'ERROR!',
                                        message:
                                            'An undefined Error occured,\nPlease try again later!',
                                        type: ContentType.failure);
                                  }
                                },
                                icon: const Icon(Icons.mail),
                                label: const Text(
                                  'josefyaduvanshi@gmail.com',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ).py0(),
                            ]),
                        Row(
                          children: [
                            TextButton.icon(
                              onPressed: () async {
                                const telegramLink =
                                    "https://t.me/ShaivitesDev_Support_bot";
                                // ignore: deprecated_member_use
                                if (await canLaunch(telegramLink)) {
                                  // ignore: deprecated_member_use
                                  await launch(telegramLink);
                                } else {
                                  ShowSnackBar.materialSnackbar(
                                      context: context,
                                      title: 'ERROR!',
                                      message:
                                          'An undefined Error occured,\nPlease try again later!',
                                      type: ContentType.failure);
                                }
                              },
                              icon: const Icon(Icons.telegram),
                              label: const Text(
                                'Telegram',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ).pOnly(bottom: 5, right: 8, left: 8, top: 3);
              } else {
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }
}
