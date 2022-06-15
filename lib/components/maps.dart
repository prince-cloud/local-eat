import 'package:url_launcher/url_launcher.dart';

class MapsUtils {
  MapsUtils._();

  static Future<void> openMapWithPosition(
    double? latitude,
    double? longitutde,
  ) async {
    Uri googleMapUrl = Uri.parse(
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitutde');
    if (await canLaunchUrl(googleMapUrl)) {
      await launchUrl(googleMapUrl);
    } else {
      throw "Could not open Map";
    }
  }

  //text address
  static Future<void> openMapWithAddress(String fullAddress) async {
    String query = Uri.encodeComponent(fullAddress);
    Uri googleMapUrl =
        'https://www.google.com/maps/search/?api=1&query=$query' as Uri;
    if (await canLaunchUrl(googleMapUrl)) {
      await launchUrl(googleMapUrl);
    } else {
      throw "Could not open Map";
    }
  }
}
