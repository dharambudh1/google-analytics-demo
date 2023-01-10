import "dart:async";
import "dart:developer";

import "package:after_layout/after_layout.dart";
import "package:firebase_analytics/firebase_analytics.dart";
import "package:flutter/material.dart";

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AfterLayoutMixin<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Google Analytics Demo"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              headingAndBodyWidget(
                "📣 It is a demo app for Google Analytics (real-time overview).",
                "Visit the firebase console to view the below-mentioned information.",
              ),
              headingAndBodyWidget(
                "🔘 User Overview:",
                "User activity over time, users in the last 30 minutes, and much more.",
              ),
              headingAndBodyWidget(
                "🔘 Demographic Overview:",
                "Users by Country, Users by Country over time, and much more.",
              ),
              headingAndBodyWidget(
                "🔘 App Overview:",
                "Latest app release overview, App stability overview, and much more.",
              ),
              headingAndBodyWidget(
                "🔘 Pages and screens Overview:",
                "Views by Page title and screen class, Views by Page title and screen class over time, and much more.",
              ),
              headingAndBodyWidget(
                "🔘 Event Overview:",
                "Event count by Event name, Event count by Event name over time, and much more.",
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: onPressedFunction,
                child: const Text(
                  "Send an Event to Google Analytics Console",
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget headingAndBodyWidget(
    String title,
    String subtitle,
  ) {
    return ListTile(
      title: Text(title),
      subtitle: Text(subtitle),
    );
  }

  Future<void> setCurrentScreen() async {
    const String screenName = "Home Screen";
    await FirebaseAnalytics.instance.setCurrentScreen(
      screenName: screenName,
    );
    showSnackBar("setCurrentScreen() - screenName: $screenName");
    return Future<void>.value();
  }

  Future<void> onPressedFunction() async {
    const String name = "onPressedEvent";
    final Map<String, Object> parameters = <String, Object>{
      "CurrentDateTime": DateTime.now().toString(),
    };
    await FirebaseAnalytics.instance.logEvent(
      name: name,
      parameters: parameters,
    );
    showSnackBar("logEvent() - name: $name & parameters: $parameters");
    return Future<void>.value();
  }

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnackBar(
    String text,
  ) {
    log(text);
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
      ),
    );
  }

  @override
  FutureOr<void> afterFirstLayout(BuildContext context) async {
    await setCurrentScreen();
    return Future<void>.value();
  }
}
