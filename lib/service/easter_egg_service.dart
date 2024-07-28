import 'package:url_launcher/url_launcher.dart';

abstract class EasterEggService {
  bool isRickRoll(String url);
  Future<bool> openRickRoll();

  static EasterEggService get instance => EasterEggServiceImpl();
}

class EasterEggServiceImpl implements EasterEggService {
  final Uri rickRollUri =
      Uri.parse('https://www.youtube.com/watch?v=dQw4w9WgXcQ');
  final Future<bool> Function(Uri url, {LaunchMode mode}) launcher;

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
