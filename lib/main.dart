import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Kingsley Week 5'),
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
  bool pageFirstLoad = true;
  bool isLoadingItemsFromDatabase = false;
  bool buttonVisable = false;

  List<Customer> customer = [
    Customer('Aaron', 'Kingsley', 1001, 'Occasional'),
    Customer('Yolanda', 'Castro', 1002, 'Spender'),
    Customer('Jake', 'Smith', 1003, 'Frequent'),
    Customer('Mary', 'Jones', 1004, 'Occasional'),
    Customer('Krista', 'Krause', 1005, 'Saver'),
    Customer('Austin', 'Hinks', 1006, 'Spender'),
    Customer('Julie', 'Thompson', 1007, 'Frequent'),
    Customer('Carlos', 'Sanchez', 1008, 'Frequent'),
    Customer('Adelyn', 'Torres', 1009, 'Saver'),
    Customer('Joshua', 'Hiltner', 1010, 'Occasional'),
  ];

  void _handleButtonPress() {
    setState(() {
      pageFirstLoad = false;
      isLoadingItemsFromDatabase = true;
    });

    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        isLoadingItemsFromDatabase = false;
        buttonVisable = true;
      });
    });
  }

  void _resetButton() {
    setState(() {
      pageFirstLoad = true;
      buttonVisable = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: pageFirstLoad
            ? ElevatedButton(
                onPressed: _handleButtonPress,
                child: Text("Load Customers"),
              )
            : isLoadingItemsFromDatabase
                ? const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircularProgressIndicator(),
                      Text("Loading...")
                    ],
                  )
                : SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: customer.map((customer) {
                        return Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('First Name: ${customer.Fname}',
                                  style: TextStyle(fontSize: 16)),
                              Text('Last Name: ${customer.Lname}',
                                  style: TextStyle(fontSize: 16)),
                              Text('ID: ${customer.Id.toString()}'),
                              Text('Buying Habbit: ${customer.Type}'),
                              Divider(),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
      ),
      floatingActionButton: buttonVisable
          ? FloatingActionButton(
              onPressed: _resetButton,
              tooltip: 'Increment',
              child: (Text("Reset")),
            )
          : null,
    );
  }
}

class Customer {
  String Fname;
  String Lname;
  int Id;
  String Type;

  Customer(this.Fname, this.Lname, this.Id, this.Type);
}
