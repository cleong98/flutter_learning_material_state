import 'package:flutter/material.dart';

/// build an extension for material state set
extension MaterialStateSet on Set<MaterialState> {
  bool get isHovered => contains(MaterialState.hovered);
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    Color? getColor(Set<MaterialState> states) => Colors.blue;

    return Scaffold(
      appBar: AppBar(
        /// normal ways to customize color
        // backgroundColor: Colors.red,
        /// using material state color
        backgroundColor: MaterialStateColor.resolveWith((Set<MaterialState> states) {
          /// here we can using current build extension
          if(states.isHovered) {
            /// return hover colors
            return Colors.red;
          }
          return Colors.blue;
        }),
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton(
                onPressed: () {}, child: const Text('Normal Text Button')),

            /// material state thinking to customize button attributes
            TextButton(
              onPressed: () {},
              child: const Text(
                'Button Style Text Button',
                style: TextStyle(color: Colors.white),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith(getColor),
              ),
            ),

            /// easy ways to customize button attributes
            TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  backgroundColor: Colors.green,
                ),
                child: const Text('Text Button Style Text Button')),
            TextButton(
              onPressed: () {},
              child: const Text("Implements Material State Property Text Button"),
              style: ButtonStyle(
                backgroundColor: ButtonBackgroundColor(context),
              )
            ),
          ],
        ),
      ),
    );
  }
}

class ButtonBackgroundColor implements MaterialStateProperty<Color?> {
  const ButtonBackgroundColor(this.context);

  final BuildContext context;

  final Color? _focusColor = Colors.blue;
  final Color? _focusAndHoverColor = Colors.green;
  final Color? _hoverColor = Colors.red;
  final Color? _defaultColor = Colors.transparent;
  final Color? _pressColor = Colors.yellow;

  @override
  Color? resolve(Set<MaterialState> states) {
    print(states);
    if (states.contains(MaterialState.focused) &&
        states.contains(MaterialState.hovered)) {
      return _focusAndHoverColor;
    } else if (states.contains(MaterialState.focused)) {
      return _focusColor;
    } else if (states.contains(MaterialState.hovered)) {
      return _hoverColor;
    } else if (states.contains(MaterialState.pressed)) {
      return _pressColor;
    }
    return _defaultColor;
  }

}
