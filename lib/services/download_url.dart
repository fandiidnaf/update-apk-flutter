import 'package:url_launcher/url_launcher.dart';

Future<bool> downloadUrl({required String url}) async {
  final Uri uri = Uri.parse(url);

  if (await canLaunchUrl(uri)) {
    return await launchUrl(uri);
  } else {}

  return false;
}
