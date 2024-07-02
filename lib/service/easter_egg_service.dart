import 'package:url_launcher/url_launcher.dart';

abstract class EasterEggService {
  bool isRickRoll(String url);
  Future<bool> openRickRoll();

  static EasterEggService get instance => EasterEggServiceImpl();
}

class EasterEggServiceImpl implements EasterEggService {
  final rickRollUri = Uri.parse('https://www.youtube.com/watch?v=dQw4w9WgXcQ');
  @override
  bool isRickRoll(String url) {
    return url.contains('watch?v=dQw4w9WgXcQ');
  }

  @override
  Future<bool> openRickRoll() async {
    return await launchUrl(rickRollUri, mode: LaunchMode.externalApplication);
  }
}
