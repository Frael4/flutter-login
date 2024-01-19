import 'package:flutter/material.dart';
import 'package:flutter_started/home.dart';
import 'package:toast/toast.dart';


const user = 'pepe';
const pwd = '123';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Started',
      color: const Color.fromARGB(246, 201, 197, 197),
      theme: ThemeData(
        // This is the theme of your application.
        scaffoldBackgroundColor: const Color.fromARGB(137, 34, 31, 31),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        //textTheme: TextTheme(),
        useMaterial3: true,
      ),
      home: const MyLoginPage(title: 'Flutter Login Page'),
    );
  }
}

class MyLoginPage extends StatefulWidget {
  const MyLoginPage({super.key, required this.title});

  final String title;
  @override
  State<MyLoginPage> createState() => MyLoginPageState();
}

///  Manejador de los estados de mi clase
class MyLoginPageState extends State<MyLoginPage> {
  late TextEditingController userController;
  late TextEditingController passwordController;

  @override
  void initState() {
    super.initState();

    userController = TextEditingController();
    passwordController = TextEditingController();

  }

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);

    return Scaffold(
      body: formLogIn()
    );
  }

//Muestra mensajes
  void showToast(String action, [data = '', String message = '']) {
    if (action == 'Iniciar Sesion') {
      message += '$message $data';
    }
    if (action == 'Salir') {
      message = 'Ha salido del sistema';
    }

    Toast.show(message, duration: Toast.lengthLong, gravity: Toast.bottom);
  }

// Valida Campos vacios
  bool isValid() {
    return userController.text.isNotEmpty && passwordController.text.isNotEmpty;
  }

// Limpia campos
  void clearTexts() {
    userController.text = '';
    passwordController.text = '';
  }

// Verifica usuario existe
  bool existUser() {
    return userController.text == user && passwordController.text == pwd;
  }

// Logeo
  void logIn() {
    if (!isValid()) {
      showToast('action', '', 'Por favor llene los campos');
      return;
    }

    if (!existUser()) {
      showToast('action', '', 'Error en las credenciales de acceso');
    }

    if (existUser()) {
      showToast(
          'Iniciar Sesion',
          ' ${userController.text.trim()} pass: ${passwordController.text.trim()}',
          ' Acceso concedido');
        Navigator.push(context, MaterialPageRoute(builder: (context) => Inicio(),)) ;
      clearTexts();
    }
  }

  Widget formLogIn(){
    
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Inicio sesion',
                style: TextStyle(
                    color: Colors.amber, fontSize: 50, fontFamily: 'bold')),
            /* Image(image: ImageProvider), */
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextField(
                style: const TextStyle(color: Colors.white),
                controller: userController,
                decoration: const InputDecoration(labelText: 'User'),
                maxLength: 25,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextField(
                style: const TextStyle(color: Colors.white),
                controller: passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
                maxLength: 20,
                obscureText: true,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: logIn, child: const Text('Iniciar Sesion')),
            ElevatedButton(
                onPressed: () {
                  showToast('Salir');
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
                child: const Text('Salir'))
          ],
        ),
      );

  }

}


class Inicio extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inicio'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RecetaPage(),
                    ));
              },
              child: const Text('Recetas'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ComidaPage(),
                    ));
                print('Comidas');
              },
              child: const Text('Comidas'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PlantaPage(),
                    ));
                print('Plantas');
              },
              child: const Text('Plantas'),
            ),
          ],
        ),
      ),
    );
  }
}
