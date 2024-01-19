
import 'package:xml/xml.dart';

class Receta {

final String tipo;
final String dificultad;
final String nombre;
final String calorias;
final String tiempo;
final String elaboracion;
final String image;

Receta({
  required this.tipo,
  required this.dificultad,
  required this.nombre,
  required this.calorias,
  required this.tiempo,
  required this.elaboracion,
  required this.image
});

  factory Receta.fromXmlElement(XmlElement  element) {
    return Receta(
      tipo: element.findElements('tipo').first.text,
      dificultad: element.findElements('dificultad').first.text,
      nombre: element.findElements('nombre').first.text,
      calorias: element.findElements('calorias').first.text,
      tiempo: element.findElements('tiempo').first.text,
      elaboracion: element.findElements('elaboracion').first.text,
      image: element.findElements('image').first.text,
    );
  }

}