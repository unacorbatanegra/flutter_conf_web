import 'package:url_launcher/url_launcher.dart';

class UrlService {
  Future<void> openUrl(String link) async {
    final url = Uri.parse(link);
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
}
