/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';

class $AssetsAnimationGen {
  const $AssetsAnimationGen();

  /// File path: assets/animation/bubble_animation.json
  LottieGenImage get bubbleAnimation =>
      const LottieGenImage('assets/animation/bubble_animation.json');

  /// File path: assets/animation/loading_flutter_logo.json
  LottieGenImage get loadingFlutterLogo =>
      const LottieGenImage('assets/animation/loading_flutter_logo.json');

  /// File path: assets/animation/working_in_progress_animation.json
  LottieGenImage get workingInProgressAnimation => const LottieGenImage(
      'assets/animation/working_in_progress_animation.json');

  /// List of all assets
  List<LottieGenImage> get values =>
      [bubbleAnimation, loadingFlutterLogo, workingInProgressAnimation];
}

class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// File path: assets/icons/github.png
  AssetGenImage get github => const AssetGenImage('assets/icons/github.png');

  /// File path: assets/icons/instagram.png
  AssetGenImage get instagram =>
      const AssetGenImage('assets/icons/instagram.png');

  /// File path: assets/icons/linkedin.png
  AssetGenImage get linkedin =>
      const AssetGenImage('assets/icons/linkedin.png');

  /// File path: assets/icons/twitter.png
  AssetGenImage get twitter => const AssetGenImage('assets/icons/twitter.png');

  /// File path: assets/icons/youtube.png
  AssetGenImage get youtube => const AssetGenImage('assets/icons/youtube.png');

  /// List of all assets
  List<AssetGenImage> get values =>
      [github, instagram, linkedin, twitter, youtube];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/banner_con_gdg.svg
  SvgGenImage get bannerConGdg =>
      const SvgGenImage('assets/images/banner_con_gdg.svg');

  /// File path: assets/images/banner_dash_logo.png
  AssetGenImage get bannerDashLogo =>
      const AssetGenImage('assets/images/banner_dash_logo.png');

  /// File path: assets/images/banner_principal.svg
  SvgGenImage get bannerPrincipal =>
      const SvgGenImage('assets/images/banner_principal.svg');

  /// File path: assets/images/dash.png
  AssetGenImage get dash => const AssetGenImage('assets/images/dash.png');

  /// File path: assets/images/dash_logo.png
  AssetGenImage get dashLogo =>
      const AssetGenImage('assets/images/dash_logo.png');

  /// File path: assets/images/logo.svg
  SvgGenImage get logo => const SvgGenImage('assets/images/logo.svg');

  $AssetsImagesSpeakersGen get speakers => const $AssetsImagesSpeakersGen();
  $AssetsImagesTeamGen get team => const $AssetsImagesTeamGen();

  /// List of all assets
  List<dynamic> get values =>
      [bannerConGdg, bannerDashLogo, bannerPrincipal, dash, dashLogo, logo];
}

class $AssetsImagesSpeakersGen {
  const $AssetsImagesSpeakersGen();

  /// File path: assets/images/speakers/speaker_1.png
  AssetGenImage get speaker1 =>
      const AssetGenImage('assets/images/speakers/speaker_1.png');

  /// File path: assets/images/speakers/speaker_2.jpg
  AssetGenImage get speaker2 =>
      const AssetGenImage('assets/images/speakers/speaker_2.jpg');

  /// File path: assets/images/speakers/speaker_3.jpg
  AssetGenImage get speaker3 =>
      const AssetGenImage('assets/images/speakers/speaker_3.jpg');

  /// File path: assets/images/speakers/speaker_4.jpg
  AssetGenImage get speaker4 =>
      const AssetGenImage('assets/images/speakers/speaker_4.jpg');

  /// List of all assets
  List<AssetGenImage> get values => [speaker1, speaker2, speaker3, speaker4];
}

class $AssetsImagesTeamGen {
  const $AssetsImagesTeamGen();

  /// File path: assets/images/team/team_1.jpeg
  AssetGenImage get team1 =>
      const AssetGenImage('assets/images/team/team_1.jpeg');

  /// File path: assets/images/team/team_2.png
  AssetGenImage get team2 =>
      const AssetGenImage('assets/images/team/team_2.png');

  /// File path: assets/images/team/team_3.jpg
  AssetGenImage get team3 =>
      const AssetGenImage('assets/images/team/team_3.jpg');

  /// File path: assets/images/team/team_4.jpeg
  AssetGenImage get team4 =>
      const AssetGenImage('assets/images/team/team_4.jpeg');

  /// File path: assets/images/team/team_5.jpeg
  AssetGenImage get team5 =>
      const AssetGenImage('assets/images/team/team_5.jpeg');

  /// File path: assets/images/team/team_6.jpeg
  AssetGenImage get team6 =>
      const AssetGenImage('assets/images/team/team_6.jpeg');

  /// File path: assets/images/team/team_7.jpg
  AssetGenImage get team7 =>
      const AssetGenImage('assets/images/team/team_7.jpg');

  /// List of all assets
  List<AssetGenImage> get values =>
      [team1, team2, team3, team4, team5, team6, team7];
}

class Assets {
  Assets._();

  static const $AssetsAnimationGen animation = $AssetsAnimationGen();
  static const $AssetsIconsGen icons = $AssetsIconsGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
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

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class SvgGenImage {
  const SvgGenImage(this._assetName);

  final String _assetName;

  SvgPicture svg({
    Key? key,
    bool matchTextDirection = false,
    AssetBundle? bundle,
    String? package,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
    bool allowDrawingOutsideViewBox = false,
    WidgetBuilder? placeholderBuilder,
    String? semanticsLabel,
    bool excludeFromSemantics = false,
    SvgTheme theme = const SvgTheme(),
    ColorFilter? colorFilter,
    Clip clipBehavior = Clip.hardEdge,
    @deprecated Color? color,
    @deprecated BlendMode colorBlendMode = BlendMode.srcIn,
    @deprecated bool cacheColorFilter = false,
  }) {
    return SvgPicture.asset(
      _assetName,
      key: key,
      matchTextDirection: matchTextDirection,
      bundle: bundle,
      package: package,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
      placeholderBuilder: placeholderBuilder,
      semanticsLabel: semanticsLabel,
      excludeFromSemantics: excludeFromSemantics,
      theme: theme,
      colorFilter: colorFilter,
      color: color,
      colorBlendMode: colorBlendMode,
      clipBehavior: clipBehavior,
      cacheColorFilter: cacheColorFilter,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class LottieGenImage {
  const LottieGenImage(this._assetName);

  final String _assetName;

  LottieBuilder lottie({
    Animation<double>? controller,
    bool? animate,
    FrameRate? frameRate,
    bool? repeat,
    bool? reverse,
    LottieDelegates? delegates,
    LottieOptions? options,
    void Function(LottieComposition)? onLoaded,
    LottieImageProviderFactory? imageProviderFactory,
    Key? key,
    AssetBundle? bundle,
    Widget Function(BuildContext, Widget, LottieComposition?)? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    double? width,
    double? height,
    BoxFit? fit,
    AlignmentGeometry? alignment,
    String? package,
    bool? addRepaintBoundary,
    FilterQuality? filterQuality,
    void Function(String)? onWarning,
  }) {
    return Lottie.asset(
      _assetName,
      controller: controller,
      animate: animate,
      frameRate: frameRate,
      repeat: repeat,
      reverse: reverse,
      delegates: delegates,
      options: options,
      onLoaded: onLoaded,
      imageProviderFactory: imageProviderFactory,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      package: package,
      addRepaintBoundary: addRepaintBoundary,
      filterQuality: filterQuality,
      onWarning: onWarning,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
