import 'package:flutter/material.dart';
import 'package:momsonteaching_app/views/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Moms On Teaching',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Moms On Teaching'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  
  
  
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  
  
  redirectToNextPage()async{

    Future.delayed(Duration(seconds: 3), () {
      // Your code here
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Login()),
      );


    });
  }
  
  
  

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Center(
    
        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            
            Image.asset("assets/logo.png",width: 301,height: 264,fit: BoxFit.fill,),

            Text(
              'Moms On Teaching',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
   // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
