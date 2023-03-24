import 'package:danim/view_models/custom_app_bar_view_model.dart';
import 'package:danim/views/custom_app_bar.dart';
import 'package:danim/views/login_page.dart';
import 'package:danim/views/main_frame.dart';
import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

void main() {
  KakaoSdk.init(nativeAppKey: '32669d8a679c2e49a38bd97f83e94164');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Danim',
      theme: ThemeData(
        primaryColor: Colors.lightBlueAccent,
      ),
      home: LoginPage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String profileImageUrl;

  const MyHomePage({required this.profileImageUrl});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(viewModel: CustomAppBarViewModel(profileImageUrl)),
      body: MainFrame(),
    );
  }
}
