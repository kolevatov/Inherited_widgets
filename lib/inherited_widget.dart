import 'package:flutter/material.dart';
import 'package:inherited_widgets/main.dart';

// Класс должен наследовать InheritedWidget
class MyInheritedWidget extends InheritedWidget {
  // MyInheritedWidget используется для передачи состояния MyHomePageState дочерним виджетам
  final MyHomePageState state;

  const MyInheritedWidget(
      {Key? key, required Widget child, required this.state})
      : super(key: key, child: child);

  // Определяет когда нужно обновлять зависимые виджеты
  @override
  bool updateShouldNotify(MyInheritedWidget oldWidget) => true;

  // Метод получает ближайший в дереве виджет нужного типа
  static MyInheritedWidget? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<MyInheritedWidget>();
  }
}
