import 'package:url_launcher/url_launcher.dart';

/// An abstract class representing an Easter Egg service.
abstract class EasterEggService {
  /// Checks if the given URL is a Rick Roll.
  bool isRickRoll(String url);

  /// Opens the Rick Roll URL.
  Future<bool> openRickRoll();

  /// Returns the instance of the [EasterEggService].
  static EasterEggService get instance => EasterEggServiceImpl();
}

/// An implementation of the [EasterEggService].
class EasterEggServiceImpl implements EasterEggService {
  final Uri rickRollUri =
      Uri.parse('https://www.youtube.com/watch?v=dQw4w9WgXcQ');
  final Future<bool> Function(Uri url, {LaunchMode mode}) launcher;

  /// Creates a new instance of [EasterEggServiceImpl].
  ///
  /// The [launcher] function is used to launch the URL.
  EasterEggServiceImpl({this.launcher = launchUrl});

  @override
  bool isRickRoll(String url) {
    return url.contains('watch?v=dQw4w9WgXcQ');
  }

  @override
  Future<bool> openRickRoll() async {
    return await launcher(rickRollUri, mode: LaunchMode.externalApplication);
  }
}
