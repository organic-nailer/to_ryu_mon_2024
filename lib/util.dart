import 'package:url_launcher/url_launcher.dart';

void openUrl(String urlStr) async {
  try {
    final uri = Uri.parse(urlStr);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $urlStr';
    }
  } catch (e) {
    1;
  }
}