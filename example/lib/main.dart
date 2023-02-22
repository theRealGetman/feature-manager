import 'package:feature_manager/feature_manager.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

import 'features.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  runApp(
    MultiProvider(
      providers: [
        Provider.value(
          value: sharedPreferences,
        ),
        Provider<FeatureManager>(
          create: (BuildContext context) => FeatureManager(
            sharedPreferences: context.read(),
          ),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Feature Manager Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final bool isEnabled =
        context.read<FeatureManager>().isEnabled(Features.booleanFeature);
    return Scaffold(
      appBar: AppBar(
        title: Text('Feature Manager Demo Application'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text.rich(
              TextSpan(
                text: 'Feature toggle ',
                children: <InlineSpan>[
                  TextSpan(
                    text: '${isEnabled ? 'enabled' : 'disabled'}',
                    style: TextStyle(
                      color: isEnabled ? Colors.green : Colors.red,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              child: Text('Open developer preferences'),
              onPressed: () {
                Navigator.of(context)
                    .push(
                  MaterialPageRoute(
                    builder: (BuildContext context) =>
                        DeveloperPreferencesScreen(
                      featuresList: Features.values,
                      sharedPreferences: context.read(),
                    ),
                  ),
                )
                    .then((value) {
                  setState(() {});
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
