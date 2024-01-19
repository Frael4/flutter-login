import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_started/models/comida.dart';
import 'package:flutter_started/models/planta.dart';
import 'package:flutter_started/models/receta.dart';
import 'package:flutter_started/models/products.dart';
import 'package:webfeed/webfeed.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart';

Future<RssFeed> getNews() async {
  var response = await http.get(Uri.parse('https://www.elcomercio.com/feed/'));
  return RssFeed.parse(response.body);
}

Future<List<Products>> getProducts() async {
  final response =
      await http.get(Uri.parse('https://fakestoreapi.com/products/'));
  if (response.statusCode == 200) {
    final List<dynamic> datos = jsonDecode(response.body);

    return datos
        .map((p) => Products(
            title: p['title'],
            price: p['price'],
            description: p['description'],
            category: p['category'],
            image: p['image']))
        .toList();
  } else {
    throw Exception('Error en respuesta de API');
  }
}

Future<List<Planta>> loadPlanta() async {
  try {
    
    String xmlString = await rootBundle.loadString('assets/Planta.xml');

    XmlDocument document = XmlDocument.parse(xmlString);

    Iterable<XmlElement> catalog = document.findElements('CATALOG').first.findElements('PLANT').toList();

    List<Planta> dataList =
        catalog.map((item) => Planta.fromXmlElement(item)).toList();

    return dataList;
  } catch (e) {
    print("Error al cargar el archivo XML: $e");
    return [];
  }
}

Future<List<Comida>> loadComida() async {
  try {
    // Cargar el contenido del archivo XML desde assets
    String xmlString = await rootBundle.loadString('assets/comida.xml');

    // Convertir la cadena XML en un objeto XmlDocument
    XmlDocument document = XmlDocument.parse(xmlString);

    // Obtener la lista de elementos 'item' del XML
    Iterable<XmlElement> breakfast_menu = document.findElements('breakfast_menu').first.findElements('food').toList();

    // Convertir cada elemento 'item' en un objeto XmlData
    List<Comida> dataList =
        breakfast_menu.map((item) => Comida.fromXmlElement(item)).toList();

    return dataList;
  } catch (e) {
    print("Error al cargar el archivo XML: $e");
    return [];
  }
}

Future<List<Receta>> loadReceta() async {
  try {
    
    String xmlString = await rootBundle.loadString('assets/receta.xml');

    XmlDocument document = XmlDocument.parse(xmlString);

    Iterable<XmlElement> recetas= document.findElements('recetas').first.findElements('receta').toList();

    List<Receta> dataList =
        recetas.map((item) => Receta.fromXmlElement(item)).toList();

    return dataList;
  } catch (e) {
    print("Error al cargar el archivo XML: $e");
    return [];
  }
}
