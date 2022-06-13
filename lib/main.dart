import 'package:flutter/material.dart';
import 'package:inherited_widgets/inherited_widget.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  int get counterValue => _counter;

  void _incrementCounter() => setState(() => _counter++);
  void _decrementCounter() => setState(() => _counter--);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inherited Widgets'),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          // создается экземпляр класса зависимый от MyInheritedWidget.
          // Все виджеты ниже по дереву также зависимы от MyInheritedWidget
          MyInheritedWidget(
            state: this,
            child: const AppRootWidget(),
          ),
        ],
      ),
    );
  }
}

class AppRootWidget extends StatelessWidget {
  const AppRootWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Получаем state родительского класса через метод of
    final MyHomePageState rootWidgetState =
        MyInheritedWidget.of(context)!.state;
    return Container(
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const SizedBox(height: 32),
          const Text('Root Widget',
              style: TextStyle(color: Colors.black, fontSize: 32)),
          const SizedBox(height: 4),
          const Text('holds counter state',
              style: TextStyle(color: Colors.black, fontSize: 16)),
          const SizedBox(height: 16),
          Text('${rootWidgetState.counterValue}',
              style: Theme.of(context).textTheme.headline4),
          const SizedBox(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const <Widget>[
              Counter(),
              Counter(),
            ],
          ),
        ],
      ),
    );
  }
}

class Counter extends StatelessWidget {
  const Counter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final rootWidgetState = MyInheritedWidget.of(context)!.state;
    return Card(
      margin: const EdgeInsets.all(8),
      color: Colors.yellowAccent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const SizedBox(height: 16),
          const Text(
            'Child Widget',
            style: TextStyle(
              color: Colors.black,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 16),
          Text('${rootWidgetState.counterValue}',
              style: Theme.of(context).textTheme.headline4),
          ButtonBar(
            children: <Widget>[
              IconButton(
                icon: const Icon(Icons.remove),
                color: Colors.red,
                onPressed: () => rootWidgetState._decrementCounter(),
              ),
              IconButton(
                icon: const Icon(Icons.add),
                color: Colors.green,
                onPressed: () => rootWidgetState._incrementCounter(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
