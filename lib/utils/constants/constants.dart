import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:procrasti_buddy/gen/assets.gen.dart';

class Constants {
  static const IconData playIcon = Icons.play_arrow;
  static const IconData pauseIcon = Icons.pause;
  static const IconData stopIcon = Icons.stop;
  static const IconData resetIcon = Icons.refresh;
  static TextStyle titleTextStyle = GoogleFonts.lato(
    fontSize: 28,
    fontWeight: FontWeight.w600,
  );

  static String openApiKey = dotenv.get("OPEN_API_KEY");

  static List<String> categories = [
    "Appointments",
    "Tasks",
    "Bills and Payments",
    "Journal",
    "Pomodoro Clock",
    "Tips and Tricks",
  ];
  static List<String> imageList = [
    Assets.images.appointment,
    Assets.images.tasks,
    Assets.images.buyForCash,
    Assets.images.journal,
    Assets.images.pomodoro,
    Assets.images.dailyTasks,
  ];

  static const Map<String, String> journalMoodType = {
    "Happy": "😊",
    "Sad": "😔",
    "Angry": "😡",
    "Bored": "😴",
    "Anxious": "😰",
    "null": "🙂",
    "": "🙂",
  };

  static getMoodType(type) {
    return journalMoodType[type];
  }

  static const List<String> type_ = [
    'Square',
    'Square',
    'Horizontal',
    'Vertical',
    'Square',
    'Vertical',
    'Square',
  ];
  static Map<String, dynamic> tileProperties = {
    'Square': {'scaleFactor': 1.4, 'maxLines': 4},
    'Vertical': {'scaleFactor': 1.47, 'maxLines': 8},
    'Horizontal': {'scaleFactor': 1.6, 'maxLines': 3},
  };

  static double textScaleFactor(String type) {
    return tileProperties[type]['scaleFactor'];
  }

  static int maxLines(String type) {
    return tileProperties[type]['maxLines'];
  }

  static const List<List<int>> randomGridStructure = [
    [2, 2],
    [2, 2],
    [4, 2],
    [2, 3],
    [2, 2],
    [2, 3],
    [2, 2],
  ];

  static TextStyle descriptionTextStyle = GoogleFonts.lato(
    fontSize: 18,
    fontWeight: FontWeight.w500,
  );

  static TextStyle dateTextStyle = GoogleFonts.lato(
    fontSize: 20,
    fontWeight: FontWeight.w400,
  );

  static TextStyle noteTitleTextStyle = GoogleFonts.lato(
    fontSize: 22,
    fontWeight: FontWeight.w500,
  );
  static const appbar = Color(0x00f2ebfd);

  static const journalBackground = Color(0xFF252525);

  static List<Color> lightColors = [
    Color.fromARGB(Random().nextInt(255), Random().nextInt(255),
        Random().nextInt(255), Random().nextInt(255)),
    const Color(0xFF80cbc4),
    const Color(0xFFf48fb1),
    const Color(0xFFffab91),
    const Color(0xFFffcc80),
    const Color(0xFFe6ee9b),
    Colors.accents[Random().nextInt(Colors.accents.length)],
    Color.fromARGB(Random().nextInt(255), Random().nextInt(255),
        Random().nextInt(255), Random().nextInt(255)),
    Colors.accents[Random().nextInt(Colors.accents.length)],
    const Color(0xFF80deea),
    const Color(0xFFcf93d9),
    const Color(0xFFe6ee9b),
    const Color(0xFF80deea),
    const Color(0xFFffab91),
    const Color(0xFFcf93d9),
    const Color(0xFF80cbc4),
    const Color(0xFFffcc80),
    const Color(0xFFf48fb1),
    const Color(0xFFe6ee9b),
  ];

  static List<Color> darkColors = [
    Color.fromARGB(Random().nextInt(255), Random().nextInt(255),
            Random().nextInt(255), Random().nextInt(255))
        .withOpacity(0.7),
    Colors.accents[Random().nextInt(Colors.accents.length)].withOpacity(0.7),
    lightColors[0].withOpacity(0.7),
    lightColors[1].withOpacity(0.7),
    lightColors[2].withOpacity(0.7),
    lightColors[3].withOpacity(0.7),
    lightColors[4].withOpacity(0.7),
    lightColors[5].withOpacity(0.7),
    lightColors[6].withOpacity(0.7),
    lightColors[7].withOpacity(0.7),
    lightColors[8].withOpacity(0.7),
    Color.fromARGB(Random().nextInt(255), Random().nextInt(255),
            Random().nextInt(255), Random().nextInt(255))
        .withOpacity(0.7),
    Colors.accents[Random().nextInt(Colors.accents.length)].withOpacity(0.7),
    lightColors[9].withOpacity(0.7),
    lightColors[10].withOpacity(0.7),
    lightColors[11].withOpacity(0.7),
    lightColors[12].withOpacity(0.7),
    lightColors[13].withOpacity(0.7),
  ];
}
