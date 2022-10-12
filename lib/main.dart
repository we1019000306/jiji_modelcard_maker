import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
//import 'package:flutter_localized_locales/flutter_localized_locales.dart';
import 'package:jiji_modelcard_maker/common/jijimodel_options.dart';
import 'package:jiji_modelcard_maker/common/constants.dart';
import 'package:jiji_modelcard_maker/common/jijimodel_theme_data.dart';
import 'package:multi_image_picker_view/multi_image_picker_view.dart';
import 'package:jiji_modelcard_maker/custom_examples.dart';
import 'package:provider/provider.dart';
import 'package:jiji_modelcard_maker/common/jijimodel_photo_view_model.dart';

void main() {
  runApp(
    /// Providers are above [MyApp] instead of inside it, so that tests
    /// can use [MyApp] while mocking the providers
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => JiJiModelPhotoViewModel()),
      ],
      child:const JiJiModelApp(),
    ),
  );
}
class JiJiModelApp extends StatelessWidget {
  const JiJiModelApp({
    super.key,
    this.initialRoute,
    this.isTestMode = false,
  });

  final String? initialRoute;
  final bool isTestMode;

  // This widget is the root of your application.
  Widget build(BuildContext context) {
    return ModelBinding(
      initialModel: JiJiModelOptions(
        themeMode: ThemeMode.system,
        textScaleFactor: systemTextScaleFactorOption,
        customTextDirection: CustomTextDirection.localeBased,
        locale: null,
        timeDilation: timeDilation,
        platform: defaultTargetPlatform,
        isTestMode: isTestMode,
      ),
      child: Builder(
        builder: (context) {
          final options = JiJiModelOptions.of(context);
          return MaterialApp(
            restorationScopeId: 'rootJiJiModel',
            title: 'Flutter JiJiModel',
            debugShowCheckedModeBanner: false,
            themeMode: options.themeMode,
            theme: JiJiModelThemeData.lightThemeData.copyWith(
              platform: options.platform,
            ),
            darkTheme: JiJiModelThemeData.darkThemeData.copyWith(
              platform: options.platform,
            ),
            initialRoute: initialRoute,
            locale: options.locale,
            localeListResolutionCallback: (locales, supportedLocales) {
              deviceLocale = locales?.first;
              return basicLocaleListResolution(locales, supportedLocales);
            },
           // onGenerateRoute: MyHomePage(title: title),
           //  home: const MyHomePage(title:'JiJiModel'),
            home: const DemoPage(title:'JiJiModel'),
          );
        },
      ),
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
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class DemoPage extends StatefulWidget {
const DemoPage({super.key, required this.title});

final String title;

@override
State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  final controller = MultiImagePickerController(
    maxImages: 10,
    allowedImageTypes: ['png', 'jpg', 'jpeg'],
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          MultiImagePickerView(
            controller: controller,
            padding: const EdgeInsets.all(10),
          ),
          const SizedBox(height: 32),
          CustomExamples()
        ],
      ),
      appBar: AppBar(
        title: Text('Multi Image Picker View'),
        actions: [
          IconButton(
            color: Colors.white,
            icon: Icon(Icons.arrow_upward),
            onPressed: () {
              final images = controller.images;
              // use these images
              print(images);
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
