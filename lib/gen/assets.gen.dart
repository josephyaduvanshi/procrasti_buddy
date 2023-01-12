/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal

import 'package:flutter/widgets.dart';

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/appointment.svg
  String get appointment => 'assets/images/appointment.svg';

  /// File path: assets/images/bot.svg
  String get bot => 'assets/images/bot.svg';

  /// File path: assets/images/buy-for-cash.svg
  String get buyForCash => 'assets/images/buy-for-cash.svg';

  /// File path: assets/images/daily-tasks.svg
  String get dailyTasks => 'assets/images/daily-tasks.svg';

  /// File path: assets/images/journal.svg
  String get journal => 'assets/images/journal.svg';

  /// File path: assets/images/pomodoro.svg
  String get pomodoro => 'assets/images/pomodoro.svg';

  /// File path: assets/images/shopping-basket.svg
  String get shoppingBasket => 'assets/images/shopping-basket.svg';

  /// File path: assets/images/tasks.svg
  String get tasks => 'assets/images/tasks.svg';

  /// List of all assets
  List<String> get values => [
        appointment,
        bot,
        buyForCash,
        dailyTasks,
        journal,
        pomodoro,
        shoppingBasket,
        tasks
      ];
}

class $AssetsLottieGen {
  const $AssetsLottieGen();

  /// File path: assets/lottie/empty.json
  String get empty => 'assets/lottie/empty.json';

  /// File path: assets/lottie/loading.json
  String get loading => 'assets/lottie/loading.json';

  /// File path: assets/lottie/tricks.json
  String get tricks => 'assets/lottie/tricks.json';

  /// List of all assets
  List<String> get values => [empty, loading, tricks];
}

class Assets {
  Assets._();

  static const $AssetsImagesGen images = $AssetsImagesGen();
  static const $AssetsLottieGen lottie = $AssetsLottieGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName);

  final String _assetName;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider() => AssetImage(_assetName);

  String get path => _assetName;

  String get keyName => _assetName;
}
