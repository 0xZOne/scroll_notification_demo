import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

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
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: NotificationListener<ScrollNotification>(
          onNotification: (scrollNotification) {
            if (kDebugMode) {
              print('xlog, $this, $scrollNotification');
            }
            return true;
          },
          child: ScrollNotificationObserver(
            child: ListView.builder(
                itemCount: 100,
                itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.only(
                          left: 10.0, top: 4.0, right: 10.0, bottom: 4.0),
                      child: Column(
                        children: const <Widget>[
                          Card(
                            child: SizedBox(
                              height: 150,
                              child: ListTile(
                                tileColor: Colors.white,
                                title: Text('Listview item'),
                              ),
                            ),
                          ),
                          Card(
                            child: SizedBox(
                              height: 150,
                              child: _ScrollListenerWidget(),
                            ),
                          ),
                        ],
                      ),
                    )),
          ),
        ),
      ),
    );
  }
}

class _ScrollListenerWidget extends StatefulWidget {
  const _ScrollListenerWidget({Key? key}) : super(key: key);

  @override
  State<_ScrollListenerWidget> createState() => __ScrollListenerWidgetState();
}

class __ScrollListenerWidgetState extends State<_ScrollListenerWidget> {
  ScrollNotificationObserverState? _scrollNotificationObserver;
  void _listener(ScrollNotification notification) {
    if (notification is ScrollUpdateNotification) {
      if (kDebugMode) {
        print('xlog, $this, $notification');
      }
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _scrollNotificationObserver?.removeListener(_listener);
    _scrollNotificationObserver = ScrollNotificationObserver.maybeOf(context);
    _scrollNotificationObserver?.addListener(_listener);
  }

  @override
  void dispose() {
    if (_scrollNotificationObserver != null) {
      _scrollNotificationObserver!.removeListener(_listener);
      _scrollNotificationObserver = null;
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const ListTile(
      tileColor: Colors.limeAccent,
      title: Text('ListView item with scroll listener'),
    );
  }
}
