
import 'package:xml/xml.dart';

class Comida {

final String name;
final String price;
final String description;
final String calories;
final String image;

Comida({
  required this.name,
  required this.price,
  required this.description,
  required this.calories,
  required this.image
});

  factory Comida.fromXmlElement(XmlElement  element) {
    return Comida(
      name: element.findElements('name').first.text,
      price: element.findElements('price').first.text,
      description: element.findElements('description').first.text,
      calories: element.findElements('calories').first.text,
      image: element.findElements('image').first.text
    );
  }

}