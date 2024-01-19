import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_started/models/comida.dart';
import 'package:flutter_started/models/planta.dart';
import 'package:flutter_started/models/products.dart';
import 'package:flutter_started/models/receta.dart';
import 'package:webfeed/webfeed.dart';
import 'network.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:geolocator/geolocator.dart';

final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;
final List<_PositionItem> _positionItem = <_PositionItem>[];

enum _PositionItemType { log, position }

class _PositionItem {
  _PositionItem(this.type, this.displayValue) {}

  final _PositionItemType type;
  final String displayValue;
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

/* class HomePageState extends State<HomePage> {
  Future<RssFeed>? future;
  List<double>? _accelerometerValues;
  List<double>? _giroscopeValues;
  List<double>? _magnetometerValues;
  final _streamSuscriptions = <StreamSubscription<dynamic>>[];

  @override
  void initState() {
    super.initState();
    future = getNews();
    getNews().then((value) => print(value.title));
    //listenSensor();
  }

  void listenSensor() {
    _streamSuscriptions
        .add(accelerometerEvents.listen((AccelerometerEvent event) {
      setState(() {
        _accelerometerValues = <double>[event.x, event.y];
      });
    }));

    _streamSuscriptions.add(gyroscopeEvents.listen((GyroscopeEvent event) {
      setState(() {
        _giroscopeValues = <double>[event.x, event.y];
      });
    }));

    //magnetometer
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("This is home"),
        ),
        body: _body());
  }

  Widget _body() {
    return FutureBuilder(
        future: future,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.active:
            case ConnectionState.waiting:
              return const Center(child: CircularProgressIndicator());
            case ConnectionState.done:
              if (snapshot.hasError) {
                return Text('Error : ${snapshot.error}');
              }

              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: ListView.builder(
                    itemCount: snapshot.data.items.length + 2,
                    itemBuilder: (BuildContext context, int index) {
                      if (index == 0) {
                        return Padding(
                          padding: EdgeInsets.only(top: 8.0, bottom: 16.0),
                          child: Text(snapshot.data.description),
                        );
                      }
                      if (index == 1) {
                        return _bigItem();
                      }
                      return _item(snapshot.data.items[index - 2]);
                    }),
              );
          }
        });
  }

  Widget _bigItem() {
    var screenWidth = MediaQuery.of(context).size.width;

    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Container(
          width: double.infinity,
          height: (screenWidth - 64.0) * 3.0 / 5.0,
          decoration: BoxDecoration(
              image: const DecorationImage(
                image: NetworkImage(
                    'https://www.elcomercio.com/wp-content/uploads/2021/06/logo-el-comercio.jpg'),
              ),
              borderRadius: BorderRadius.circular(30.0)),
        )
      ],
    );
  }

  Widget _item(RssItem item) {
    return Card(
      color: Colors.blueGrey.shade100,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
      elevation: 3,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: <Widget>[
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  item.categories!.first.value,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16.0),
                ),
                Text(item.title!),
                Text('Autor: ${item.author}'),
              ],
            )),
            Container(
              width: 120.0,
              height: 120.0,
              child: Image(
                image: NetworkImage(item.enclosure?.url ??
                    'https://i.blogs.es/d5130c/wallpaper-2.png/1366_2000.jpeg'),
                fit: BoxFit.cover,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget Home() {
    return const Center(
      child: Column(children: []),
    );
  }
}
 */


class _HomePageState extends State<HomePage> {
  Future<List<Products>>? future;

  @override
  void initState() {
    super.initState();
    future = getProducts();
    getProducts().then((value) => print('Tamaño: es ${value.length}'));
    //listenSensor();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("This is home"),
        ),
        body: _body());
  }

  Widget _body() {
    return FutureBuilder<List<Products>>(
      future: getProducts(),
      builder: (BuildContext context, AsyncSnapshot<List<Products>> snapshot) {
        /* if (snapshot.connectionState == ConnectionState.waiting) {
        // Si el Future aún está en proceso, mostrar un indicador de carga
        return const Center(child: CircularProgressIndicator());
      } else  */
        if (snapshot.hasData) {
          // Si hay datos disponibles, construir la lista
          final products = snapshot.data;
          return ListView.builder(
            itemCount: products!.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return Card(
                color: Colors.blue.shade100,
                child: ListTile(
                  leading: SizedBox(
                    width: 50,
                    height: 60,
                    child: Image.network(product.image),
                  ),
                  title: Text(product.title),
                  subtitle: Text(product.description),
                ),
              );
            },
          );
        } else if (snapshot.hasError) {
          // Si hay un error, mostrar un mensaje de error en el centro
          return Center(
            child: Text("Error: ${snapshot.error}"),
          );
        } else {
          // Caso por defecto: Si no hay datos ni error, mostrar algo neutral
          return const Center(
            child: Text("No hay datos disponibles."),
          );
        }
      },
    );
  }

}

class PlantaPage extends StatefulWidget {
  const PlantaPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return PlantaPageState();
  }
}

class PlantaPageState extends State<PlantaPage> {
  Future<List<Planta>>? future;

  @override
  void initState() {
    super.initState();
    future = loadPlanta();
    getProducts().then((value) => print('Tamaño: es ${value.length}'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Plantas"),
        ),
        body: _body());
  }

  Widget _body() {
    return FutureBuilder<List<Planta>>(
      future: loadPlanta(),
      builder: (BuildContext context, AsyncSnapshot<List<Planta>> snapshot) {
        /* if (snapshot.connectionState == ConnectionState.waiting) {
        // Si el Future aún está en proceso, mostrar un indicador de carga
        return const Center(child: CircularProgressIndicator());
      } else  */
        if (snapshot.hasData) {
          // Si hay datos disponibles, construir la lista
          final plantas = snapshot.data;
          return ListView.builder(
            itemCount: plantas!.length,
            itemBuilder: (context, index) {
              final planta = plantas[index];
              return Card(
                color: Color.fromARGB(255, 247, 246, 244),
                child: ListTile(
                  leading: SizedBox(
                    width: 50,
                    height: 60,
                    child: Image.network(planta.image),
                  ),
                  title: Text(planta.common),
                  subtitle: Text(planta.price),
                ),
              );
            },
          );
        } else if (snapshot.hasError) {
          // Si hay un error, mostrar un mensaje de error en el centro
          return Center(
            child: Text("Error: ${snapshot.error}"),
          );
        } else {
          // Caso por defecto: Si no hay datos ni error, mostrar algo neutral
          return const Center(
            child: Text("No hay datos disponibles."),
          );
        }
      },
    );
  }
  
}

class RecetaPage extends StatefulWidget {
  const RecetaPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return RecetaPageState();
  }
}

class RecetaPageState extends State<RecetaPage> {
  Future<List<Receta>>? future;

  @override
  void initState() {
    super.initState();
    future = loadReceta();
    getProducts().then((value) => print('Tamaño: es ${value.length}'));
    //listenSensor();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Recetas"),
        ),
        body: _body());
  }

  Widget _body() {
    return FutureBuilder<List<Receta>>(
      future: loadReceta(),
      builder: (BuildContext context, AsyncSnapshot<List<Receta>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
        // Si el Future aún está en proceso, mostrar un indicador de carga
        return const Center(child: CircularProgressIndicator());
      } else 
        if (snapshot.hasData) {
          // Si hay datos disponibles, construir la lista
          final recetas = snapshot.data;
          return ListView.builder(
            itemCount: recetas!.length,
            itemBuilder: (context, index) {
              final receta = recetas[index];
              return Card(
                color: Color.fromARGB(255, 241, 221, 245),
                child: ListTile(
                  leading: SizedBox(
                    width: 50,
                    height: 60,
                    child: Image.network(receta.image),
                  ),
                  title: Text(receta.nombre),
                  subtitle: Text(receta.elaboracion),
                ),
              );
            },
          );
        } else if (snapshot.hasError) {
          // Si hay un error, mostrar un mensaje de error en el centro
          return Center(
            child: Text("Receta Error: ${snapshot.error}"),
          );
        } else {
          // Caso por defecto: Si no hay datos ni error, mostrar algo neutral
          return const Center(
            child: Text("No hay datos disponibles."),
          );
        }
      },
    );
  }
  
}

class ComidaPage extends StatefulWidget {
  const ComidaPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return ComidaPageState();
  }
}

class ComidaPageState extends State<ComidaPage> {
  Future<List<Comida>>? future;

  @override
  void initState() {
    super.initState();
    future = loadComida();
    getProducts().then((value) => print('Tamaño: es ${value.length}'));
    //listenSensor();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Comidas"),
        ),
        body: _body());
  }

  Widget _body() {
    return FutureBuilder<List<Comida>>(
      future: loadComida(),
      builder: (BuildContext context, AsyncSnapshot<List<Comida>> snapshot) {
        /* if (snapshot.connectionState == ConnectionState.waiting) {
        // Si el Future aún está en proceso, mostrar un indicador de carga
        return const Center(child: CircularProgressIndicator());
      } else  */
        if (snapshot.hasData) {
          // Si hay datos disponibles, construir la lista
          final products = snapshot.data;
          return ListView.builder(
            itemCount: products!.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return Card(
                color: Color.fromARGB(255, 204, 202, 202),
                child: ListTile(
                  leading: SizedBox(
                    width: 50,
                    height: 60,
                    child: Image.network(product.image),
                  ),
                  title: Text(product.name),
                  subtitle: Text(product.description),
                ),
              );
            },
          );
        } else if (snapshot.hasError) {
          // Si hay un error, mostrar un mensaje de error en el centro
          return Center(
            child: Text("Comida Error: ${snapshot.error}"),
          );
        } else {
          // Caso por defecto: Si no hay datos ni error, mostrar algo neutral
          return const Center(
            child: Text("No hay datos disponibles."),
          );
        }
      },
    );
  }
  
}
