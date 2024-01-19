import 'package:xml/xml.dart';

class Planta {

final String common;
final String botanical;
final String zone;
final String light;
final String price;
final String availability;
final String image;

Planta({
  required this.common,
  required this.botanical,
  required this.zone,
  required this.light,
  required this.price,
  required this.availability,
  required this.image
});

  factory Planta.fromXmlElement(XmlElement  element) {
    return Planta(
      common: element.findElements('COMMON').first.text,
      botanical: element.findElements('BOTANICAL').first.text,
      zone: element.findElements('ZONE').first.text,
      light: element.findElements('LIGHT').first.text,
      price: element.findElements('PRICE').first.text,
      availability: element.findElements('AVAILABILITY').first.text,
      image: element.findElements('image').first.text
    );
  }

}