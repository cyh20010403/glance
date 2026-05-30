import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../features/card/presentation/home_page.dart';
import '../features/card/presentation/create_card_page.dart';
import '../features/chat/presentation/chat_page.dart';
import '../features/match/presentation/match_page.dart';
import '../features/profile/presentation/profile_page.dart';
import '../features/profile/presentation/profile_edit_page.dart';
import '../features/profile/presentation/my_look_page.dart';
import '../features/story/presentation/story_page.dart';

/// GoRouter 路由配置
///
/// 声明式路由表，统一淡入过渡动画。
final class AppRouter {
  AppRouter._();

  // === 路由路径 ===
  static const String home = '/';
  static const String createCard = '/create-card';
  static const String chat = '/chat/:matchId';
  static const String match = '/match';
  static const String profile = '/profile';
  static const String profileEdit = '/profile/edit';
  static const String myLook = '/my-look';
  static const String story = '/story';

  // === 路由实例 ===
  static final GoRouter router = GoRouter(
    initialLocation: home,
    routes: [
      // 首页（含登录检查）
      GoRoute(
        path: home,
        name: 'home',
        pageBuilder: (context, state) => _fadePage(
          child: const HomePage(),
        ),
      ),
      // 创建心动卡片
      GoRoute(
        path: createCard,
        name: 'createCard',
        pageBuilder: (context, state) => _fadePage(
          child: const CreateCardPage(),
        ),
      ),
      // 匿名聊天
      GoRoute(
        path: chat,
        name: 'chat',
        pageBuilder: (context, state) {
          final matchId = int.parse(state.pathParameters['matchId']!);
          return _fadePage(child: ChatPage(matchId: matchId));
        },
      ),
      // 匹配结果
      GoRoute(
        path: match,
        name: 'match',
        pageBuilder: (context, state) {
          final extra = state.extra as Map<String, dynamic>?;
          return _fadePage(child: MatchPage(
            matchId: extra?['matchId'] as int?,
            partnerCard: extra?['partnerCard'] as Map<String, dynamic>?,
          ));
        },
      ),
      // 个人中心
      GoRoute(
        path: profile,
        name: 'profile',
        pageBuilder: (context, state) => _fadePage(
          child: const ProfilePage(),
        ),
      ),
      GoRoute(
        path: myLook,
        name: 'myLook',
        pageBuilder: (context, state) => _fadePage(
          child: const MyLookPage(),
        ),
      ),
      GoRoute(
        path: story,
        name: 'story',
        pageBuilder: (context, state) => _fadePage(
          child: const StoryPage(),
        ),
      ),
      GoRoute(
        path: profileEdit,
        name: 'profileEdit',
        pageBuilder: (context, state) {
          final extra = state.extra as Map<String, dynamic>?;
          return _fadePage(child: ProfileEditPage(
            nickname: extra?['nickname'] as String? ?? '',
            signature: extra?['signature'] as String? ?? '',
          ));
        },
      ),
    ],
  );

  /// 统一的淡入过渡动画
  static Page<dynamic> _fadePage({required Widget child}) {
    return CustomTransitionPage(
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(opacity: animation, child: child);
      },
      transitionDuration: const Duration(milliseconds: 250),
    );
  }
}
