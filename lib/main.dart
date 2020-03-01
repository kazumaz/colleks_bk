import 'package:colleks/model/ColorModel.dart';
import 'package:flutter/material.dart';
import 'package:colleks/view/HomePage.dart';
import 'package:colleks/view/SettingPage.dart';
import 'package:colleks/view/LaborPage.dart';
import 'package:colleks/view/RewardPage.dart';
import 'package:colleks/view/ColorSettingPage.dart';
import 'package:colleks/view/HistoryPage.dart';
import 'package:colleks/view/PointChangePage.dart';
import 'package:colleks/view/PasswordSettingPage.dart';
import 'package:colleks/view/RockSettingPage.dart';
import 'package:colleks/view/FirstTutorialPage.dart';
import 'package:colleks/model/LaborModel.dart';
import 'package:colleks/model/RewardModel.dart';
import 'package:colleks/model/HistoryModel.dart';
import 'package:colleks/model/PointModel.dart';
import 'package:colleks/model/PasswordModel.dart';
import 'package:colleks/model/LockModel.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:ff_navigation_bar/ff_navigation_bar.dart';
import 'package:colleks/parts/shared_prefs.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider<LaborModel>(create: (_) => LaborModel()),
      ChangeNotifierProvider<RewordModel>(create: (_) => RewordModel()),
      ChangeNotifierProvider<HistoryModel>(create: (_) => HistoryModel()),
      ChangeNotifierProvider<PointModel>(create: (_) => PointModel()),
      ChangeNotifierProvider<ColorModel>(create: (_) => ColorModel()),
      ChangeNotifierProvider<PasswordModel>(create: (_) => PasswordModel()),
      ChangeNotifierProvider<LockModel>(create: (_) => LockModel()),
    ], child: Application());
  }
}

class Application extends StatelessWidget {
  Widget build(BuildContext context) {
    return Consumer<ColorModel>(
      builder: (context, color, child) {
        return MaterialApp(
          // title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: color.themaColor,
          ),
          home: MyHomePage(title: 'Flutter Demo Home Page'),
          // initialRoute: '/',
          routes: <String, WidgetBuilder>{
            // '/': (BuildContext context): (_) => HomePage(),
            '/colorSettings': (_) => ColorSettingPage(),
            '/home': (_) => MyHomePage(title: 'Flutter Demo Home Page'),
            '/passwordSetting': (_) => PassWordSettingPage(),
            '/pointChange': (_) => PointChangePage(),
            '/rockSetting': (_) => RockSettingPage(),
            // '/firstTutorial': (_) => FirstTutorialPage(),
          },
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  PageController _pageController;
  int _page = 0;
  bool initialLogin = true;
  bool first;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();

// 初回ログイン時てのみ。チュートリアルページを作成する
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      var prefs = await SharedPreferences.getInstance();
      if (prefs.getBool('isFirstLaunch') ?? true) {

  final ValueNotifier<double> notifier = ValueNotifier(0);
  int pageCount = 6;

        Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (context) => new FirstTutorialPage(
                              pageCount: pageCount,
            notifier: notifier,
                )));
      }
    });
    // });
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (initialLogin) {
      final rewardModel = Provider.of<RewordModel>(context);
      final laborModel = Provider.of<LaborModel>(context);
      final historyModel = Provider.of<HistoryModel>(context);
      final colorModel = Provider.of<ColorModel>(context);
      final pointModel = Provider.of<PointModel>(context);
      final passwordModel = Provider.of<PasswordModel>(context);
      final lockModel = Provider.of<LockModel>(context);
      rewardModel.initializeApp();
      laborModel.initializeApp();
      historyModel.initializeApp();
      colorModel.initializeApp();
      pointModel.initializeApp();
      passwordModel.initializeApp();
      lockModel.initializeApp();
      initialLogin = false;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: onPageChanged,
        children: [
          HomePage(),
          LaborPage(),
          RewardPage(),
          HistoryPage(),
          SettingsPage(),
        ],
      ),
      bottomNavigationBar: FFNavigationBar(
        theme: FFNavigationBarTheme(
          barBackgroundColor: Colors.white,
          selectedItemBorderColor: Colors.black,
          selectedItemBackgroundColor: Theme.of(context).primaryColor,
          selectedItemIconColor: Colors.white,
          selectedItemLabelColor: Colors.black,
        ),
        selectedIndex: _page,
        onSelectTab: (index) {
          onTapBottomNavigation(index);
        },
        items: [
          FFNavigationBarItem(
            iconData: Icons.home,
            label: 'ホーム',
          ),
          FFNavigationBarItem(
            iconData: Icons.people,
            label: 'お手伝い',
          ),
          FFNavigationBarItem(
            iconData: Icons.local_library,
            label: 'ご褒美',
          ),
          FFNavigationBarItem(
            iconData: Icons.note,
            label: '履歴',
          ),
          FFNavigationBarItem(
            iconData: Icons.settings,
            label: '設定',
          ),
        ],
      ),
    );
  }

  void onTapBottomNavigation(int page) {
    _pageController.animateToPage(page,
        duration: const Duration(milliseconds: 300), curve: Curves.ease);
  }

  void onPageChanged(int page) {
    setState(() {
      this._page = page;
    });
  }
}
