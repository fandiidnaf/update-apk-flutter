import 'package:example/services/download_url.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: HomePage());
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String appVersion = "";
  bool isDownloadShow = false;
  bool isLoading = false;
  bool? result;

  @override
  void initState() {
    super.initState();
    getAppVersion();
  }

  Future<void> getAppVersion() async {
    final PackageInfo info = await PackageInfo.fromPlatform();

    setState(() {
      appVersion = "${info.version}+${info.buildNumber}";
      if (info.version == "1.0.0") {
        isDownloadShow = true;
      }
    });
  }

  Future<void> downloadAndInstallPackage() async {
    setState(() {
      isLoading = true;
    });
    final String url =
        "https://drive.google.com/file/d/1RYixCAZ7ZK9rzWuveoFYYsZ3428VFdMd/view?usp=sharing";
    final bool res = await downloadUrl(url: url);

    setState(() {
      isLoading = false;
      result = res;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          spacing: 20,
          mainAxisAlignment: .center,
          children: [
            if (isLoading)
              Row(
                mainAxisAlignment: .center,
                spacing: 20,
                children: [
                  CircularProgressIndicator(),
                  Text("result: $result"),
                ],
              ),
            Text("info: $appVersion"),
          ],
        ),
      ),

      floatingActionButton: isDownloadShow
          ? FloatingActionButton(
              onPressed: downloadAndInstallPackage,
              child: Icon(Icons.download),
            )
          : null,
    );
  }
}
