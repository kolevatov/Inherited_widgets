// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:inherited_widgets/fonts.dart';
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
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Root Widget',
            style: Fonts.h1,
          ),
          const SizedBox(height: 8),
          Text('${rootWidgetState.counterValue}', style: Fonts.h2),
          const SizedBox(height: 16),
          const ChildWidget(
            bgColor: Color(0xfff2f2f2),
            childWidget: ChildWidget(
                bgColor: Color(0xffbdbdbd),
                childWidget: ChildWidget(
                    bgColor: Color(0xff828282), childWidget: SizedBox())),
          ),
        ],
      ),
    );
  }
}

class ChildWidget extends StatelessWidget {
  final Widget childWidget;
  final Color bgColor;
  const ChildWidget(
      {Key? key, required this.childWidget, required this.bgColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final rootWidgetState = MyInheritedWidget.of(context)!.state;
    return Card(
      color: bgColor,
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Child Widget',
                  style: Fonts.bodyDark,
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsets>(
                        const EdgeInsets.all(8)),
                    fixedSize: MaterialStateProperty.all<Size>(
                        const Size.fromWidth(150)),
                  ),
                  onPressed: () => rootWidgetState._incrementCounter(),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text('${rootWidgetState.counterValue}',
                            style: Fonts.bodyLight),
                        const Icon(
                          Icons.add_box,
                          color: Colors.white,
                          size: 24,
                        )
                      ]),
                ),
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            childWidget,
          ],
        ),
      ),
    );
  }
}
