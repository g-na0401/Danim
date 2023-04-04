import 'dart:async';

import 'package:danim/services/timeline_repository.dart';
import 'package:danim/view_models/timeline_detail_view_model.dart';
import 'package:danim/view_models/timeline_list_view_model.dart';
import 'package:danim/view_models/user_timeline_list_view_model.dart';
import 'package:danim/views/user_timeline_list_view.dart';
import 'package:danim/views/timeline_detail_page.dart';
import 'package:danim/views/timeline_list_page.dart';
import 'package:danim/views/user_timeline_list_view.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

import '../models/UserInfo.dart';
import '../views/modify_profile.dart';

class AppViewModel with ChangeNotifier {
  int currentIndex;
  final pageController = PageController(initialPage: 0);
  final GlobalKey<NavigatorState> homeFeedNavigatorKey = GlobalKey();
  final GlobalKey<NavigatorState> myFeedNavigatorKey = GlobalKey();
  UserInfo _userInfo;
  String _title = '';
  String _formerTitle = '';

  AppViewModel(this._userInfo, this._title, {this.currentIndex = 0});

  String get title => _title;

  UserInfo get userInfo => _userInfo;

  void changePage(index) {
    pageController.jumpToPage(index);
    currentIndex = index;

    if (index == 0) {
      changeTitle('홈');
      Timer(
        const Duration(milliseconds: 10),
        () => Navigator.pushNamed(homeFeedNavigatorKey.currentContext!, '/'),
      );
    } else {
      changeTitle('내 다님');
      Timer(
        const Duration(milliseconds: 10),
        () => Navigator.pushNamed(myFeedNavigatorKey.currentContext!, '/'),
      );
    }
    notifyListeners();
  }

  updateUserInfo(UserInfo userInfo) {
    _userInfo = userInfo;
    notifyListeners();
  }

  goModifyProfilePage() {
    pageController.jumpToPage(1);
    currentIndex = 1;
    notifyListeners();
    Timer(
      const Duration(milliseconds: 100),
      () {
        Navigator.popAndPushNamed(
            myFeedNavigatorKey.currentContext!, '/modify/profile');
      },
    );
  }

  startTravel(context) async {
    int timelineId = await TimelineRepository().startTravel(context);
    userInfo.timeLineId = timelineId;
    notifyListeners();
    _goToTravelingTimelinePage(timelineId);
  }

  _goToTravelingTimelinePage(int timelineId) {
    pageController.jumpToPage(1);
    currentIndex = 1;
    notifyListeners();
    Timer(
      const Duration(milliseconds: 100),
      () {
        Navigator.popAndPushNamed(
            myFeedNavigatorKey.currentContext!, '/timeline/detail/$timelineId');
      },
    );
  }

  logout(BuildContext context) {
    // const storage = FlutterSecureStorage();
    // storage.deleteAll();
    // logger.d(context);
    // Navigator.pushAndRemoveUntil(
    //     context,
    //     MaterialPageRoute(
    //       builder: (_) => LoginPage(),
    //     ),
    //     (routes) => false);
  }

  onHomeFeedRoute(context, settings) {
    if (settings.name!.startsWith('/timeline/detail')) {
      final timelineId = int.parse(settings.name.split('/')[3]);
      return PageRouteBuilder(
        pageBuilder: (context, __, ___) {
          return ChangeNotifierProvider<TimelineDetailViewModel>(
            create: (_) => TimelineDetailViewModel(context, timelineId),
            child: TimelineDetailPage(),
          );
        },
        transitionDuration: Duration.zero,
      );
    } else {
      return PageRouteBuilder(
        pageBuilder: (_, __, ___) => TimelineListPage(),
        transitionDuration: Duration.zero,
      );
    }
  }

  onMyFeedRoute(context, settings) {
    Widget page;
    if (settings.name!.startsWith('/timeline/detail')) {
      final timelineId = int.parse(settings.name.split('/')[3]);
      page = ChangeNotifierProvider(
        create: (_) => TimelineDetailViewModel(context, timelineId),
        child: TimelineDetailPage(),
      );
    } else if (settings.name == '/modify/profile') {
      page = ModifyProfile();
    } else {
      page = ChangeNotifierProvider<TimelineListViewModel>(
        create: (_) => TimelineListViewModel(
          context: context,
          userUid: _userInfo.userUid,
          profileImageUrl: _userInfo.profileImageUrl,
          nickname: _userInfo.nickname,
        ),
      page = ChangeNotifierProvider<UserTimelineListViewModel>(
        create: (_) => UserTimelineListViewModel(
          context: context,
          myInfo: userInfo,
            ),
        child: UserTimeLineListView(),
      );
    }
    return PageRouteBuilder(
      pageBuilder: (_, __, ___) => page,
      transitionDuration: Duration.zero,
    );
  }

  changeTitle(String newTitle) {
    _formerTitle = _title;
    _title = newTitle;
    notifyListeners();
  }

  changeTitleToFormer() {
    _title = _formerTitle;
    notifyListeners();
  }

  String get nickname => _nickname;

  int get userUid => _userUid;

  int get travelingId => _travelingId;
}
