import 'package:feature_manager/feature_manager.dart';
import 'package:flutter/material.dart';

import 'features.dart';

void main() {
  runApp(MyApp());
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
  FeatureManager featureManager = FeatureManager();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Feature Manager Demo Application'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FutureBuilder<bool>(
              initialData: Features.booleanFeature.defaultValue as bool,
              future: featureManager.isEnabled(Features.booleanFeature),
              builder: (BuildContext context, snapshot) {
                final bool isEnabled = snapshot.data ?? false;
                return Text.rich(
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
                );
              },
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              child: Text('Open developer preferences'),
              onPressed: () {
                Navigator.of(context)
                    .push(
                  MaterialPageRoute(
                    builder: (BuildContext context) =>
                        DeveloperPreferencesScreen(Features.values),
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
