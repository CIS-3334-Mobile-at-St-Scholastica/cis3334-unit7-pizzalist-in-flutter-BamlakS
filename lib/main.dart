import 'package:flutter/material.dart';

import 'pizza.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {

  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List<Pizza> pizzasInOrder = [];

  @override
  void initState(){
    super.initState();
    pizzasInOrder.add(Pizza("Pepperoni", 2));
    pizzasInOrder.add(Pizza("Cheese", 2));
  }
  void _addPizza() {
    // TODO: display add pizza Dialog window
    print("addPizza called");
    showDialog<void>(
      context: context,
      // The inner content is self-contained and manages the Slider's state
      builder: (BuildContext dialogContext) {
        TextEditingController _toppingsController = TextEditingController();
        int tempSize = 0;
        return AlertDialog(
          title: const Text('Build Your Pizza'),
          content: StatefulBuilder( // Use StatefulBuilder to manage the Slider's state
            builder: (BuildContext context, StateSetter setState) {
              return Column(
                children: [
                  TextField(controller: _toppingsController),
                  Slider(
                    value: tempSize.toDouble(),
                    min: 0,
                    max: (PIZZA_SIZES.length - 1).toDouble(),
                    divisions: PIZZA_SIZES.length - 1,
                    onChanged: (double newValue) {
                      setState(() { // This rebuilds only the AlertDialog's content
                        tempSize = newValue.round();
                      });
                    },
                  ),
                ]
              );
            },
          ),
          actions: [
            ElevatedButton(
              onPressed: (){
                setState(() {
                  pizzasInOrder.add(Pizza(_toppingsController.text, tempSize));
                });
                Navigator.pop(context);
              },
              child: Text('Add Pizza'))
        ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.builder(
          itemCount: pizzasInOrder.length,
          itemBuilder: (BuildContext context, int index) {
          Pizza pizza = pizzasInOrder[index];
           return Card(
             color: Colors.amber[100],
             elevation: 4,
             shape: RoundedRectangleBorder(
               borderRadius: BorderRadius.circular(15),
             ),
             child: ListTile(
          leading: Icon(Icons.local_pizza),
          title: Text(pizza.description),
          subtitle: Text('Price: ${pizza.price}'),
    ),
           );
    },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: _addPizza,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}