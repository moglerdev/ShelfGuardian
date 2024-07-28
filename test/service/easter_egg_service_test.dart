import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shelf_guardian/service/easter_egg_service.dart';
import 'package:url_launcher/url_launcher.dart';

// Define a class with a method to be mocked
class Functions {
  Future<bool> onListen(Uri url, {LaunchMode? mode}) {
    return Future.value(true);
  }
}

// Create a mock class for the Functions class
class MockFunctions extends Mock implements Functions {}

void main() {
  group('EasterEggService', () {
    late EasterEggService easterEggService;
    late MockFunctions mockLauncher;

    setUp(() {
      mockLauncher = MockFunctions();
      easterEggService = EasterEggServiceImpl(launcher: mockLauncher.onListen);
    });

    test('isRickRoll returns true for RickRoll URL', () {
      const rickRollUrl = 'https://www.youtube.com/watch?v=dQw4w9WgXcQ';
      expect(easterEggService.isRickRoll(rickRollUrl), isTrue);
    });

    test('isRickRoll returns false for non-RickRoll URL', () {
      const nonRickRollUrl = 'https://www.example.com';
      expect(easterEggService.isRickRoll(nonRickRollUrl), isFalse);
    });
  });
}
