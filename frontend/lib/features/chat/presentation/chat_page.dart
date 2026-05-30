import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../theme/app_theme.dart';
import '../../../core/network/dio_client.dart';
import '../../auth/data/auth_repository.dart';
import '../domain/chat_message.dart';
import '../domain/chat_state.dart';
import 'chat_viewmodel.dart';

/// 匿名聊天页面
///
/// 路由参数：matchId（通过 GoRouter pathParameters 传入）
final class ChatPage extends ConsumerStatefulWidget {
  final int matchId;
  const ChatPage({super.key, required this.matchId});

  @override
  ConsumerState<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends ConsumerState<ChatPage> {
  final _textController = TextEditingController();
  final _scrollController = ScrollController();
  int? _myUserId;

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    _myUserId = await AuthRepository.getUserId();
    if (mounted) {
      ref.read(chatViewModelProvider.notifier).init(widget.matchId);
    }
  }

  @override
  void dispose() {
    _textController.dispose();
    _scrollController.dispose();
    ref.read(chatViewModelProvider.notifier).dispose();
    super.dispose();
  }

  void _sendMessage() {
    if (_textController.text.trim().isEmpty || _myUserId == null) return;
    ref.read(chatViewModelProvider.notifier).send(
      widget.matchId, _myUserId!, _textController.text,
    );
    _textController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(chatViewModelProvider);

    // 新消息到达 → 自动滚到底部
    ref.listen(chatViewModelProvider, (prev, next) {
      if (next is ChatReady &&
          prev is ChatReady &&
          next.messages.length > prev.messages.length) {
        _scrollToBottom();
      }
    });

    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        backgroundColor: AppTheme.surface,
        elevation: 0.5,
        title: Column(
          children: [
            const Text('匿名聊天', style: TextStyle(fontSize: 17)),
            if (state is ChatReady && state.connected)
              const Text('● 已连接', style: TextStyle(fontSize: 11, color: Color(0xFF4CAF50))),
          ],
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 18),
          onPressed: () => context.pop(),
        ),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_horiz, color: AppTheme.textSecondary),
            onSelected: (action) {
              if (action == 'report') {
                _showReportDialog(context);
              } else if (action == 'block') {
                _showBlockConfirm(context);
              }
            },
            itemBuilder: (_) => [
              const PopupMenuItem(value: 'report', child: Text('举报对方')),
              const PopupMenuItem(value: 'block', child: Text('拉黑对方', style: TextStyle(color: AppTheme.error))),
            ],
          ),
        ],
      ),
      body: _buildContent(state),
    );
  }

  Widget _buildContent(ChatState state) {
    return switch (state) {
      ChatLoading() =>
        const Center(child: CircularProgressIndicator(color: AppTheme.primary)),
      ChatError(:final message) => _buildError(message),
      ChatReady(:final messages) => Column(
          children: [
            // 匹配提示条
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 12),
              color: AppTheme.secondary.withValues(alpha: 0.08),
              child: const Text(
                '💫 你们互相注意到了彼此',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 13, color: AppTheme.primary),
              ),
            ),
            // 消息列表
            Expanded(
              child: messages.isEmpty
                  ? const Center(
                      child: Text('发送第一条消息吧 ✨',
                          style: TextStyle(color: AppTheme.textSecondary)),
                    )
                  : ListView.builder(
                      controller: _scrollController,
                      padding: const EdgeInsets.all(AppTheme.spacingXl),
                      itemCount: messages.length,
                      itemBuilder: (_, i) =>
                          _MessageBubble(
                            message: messages[i],
                            isMine: messages[i].senderId == _myUserId,
                          ),
                    ),
            ),
            // 输入栏
            _buildInputBar(),
          ],
        ),
    };
  }

  Widget _buildInputBar() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 30),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _textController,
              maxLines: 3,
              minLines: 1,
              textInputAction: TextInputAction.send,
              onSubmitted: (_) => _sendMessage(),
              decoration: InputDecoration(
                hintText: '发送消息...',
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24)),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: const BorderSide(color: AppTheme.border),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide:
                      const BorderSide(color: AppTheme.primary, width: 1.5),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: _sendMessage,
            child: Container(
              width: 44, height: 44,
              decoration: const BoxDecoration(
                color: AppTheme.primary,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.send_rounded, color: Colors.white, size: 20),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildError(String message) {
    return Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Text('😔', style: TextStyle(fontSize: 48)),
        const SizedBox(height: AppTheme.spacingLg),
        Text(message,
            style: const TextStyle(color: AppTheme.textSecondary)),
        const SizedBox(height: AppTheme.spacingXl),
        TextButton(
          onPressed: () =>
              ref.read(chatViewModelProvider.notifier).init(widget.matchId),
          child: const Text('重试'),
        ),
      ]),
    );
  }

  void _showReportDialog(BuildContext ctx) {
    showDialog(
      context: ctx,
      builder: (ctx) => AlertDialog(
        title: const Text('举报对方'),
        content: const Text('确定要举报此用户吗？'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('取消')),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              _report();
            },
            child: const Text('举报', style: TextStyle(color: AppTheme.error)),
          ),
        ],
      ),
    );
  }

  void _showBlockConfirm(BuildContext ctx) {
    showDialog(
      context: ctx,
      builder: (ctx) => AlertDialog(
        title: const Text('拉黑对方'),
        content: const Text('拉黑后将无法收到对方消息。'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('取消')),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              _block();
            },
            child: const Text('拉黑', style: TextStyle(color: AppTheme.error)),
          ),
        ],
      ),
    );
  }

  Future<void> _report() async {
    try {
      final dio = DioClient.instance;
      // 通过匹配记录获取对方ID
      final resp = await dio.get('/matches');
      final matches = (resp.data['data'] as List).cast<Map<String, dynamic>>();
      final match = matches.firstWhere((m) => m['id'] == widget.matchId, orElse: () => <String, dynamic>{});
      final partnerId = match['userAId'] == _myUserId ? match['userBId'] : match['userAId'];
      if (partnerId != null) {
        await dio.post('/user/report/$partnerId?reason=harassment');
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('举报已提交')));
        }
      }
    } catch (_) {}
  }

  Future<void> _block() async {
    try {
      final dio = DioClient.instance;
      final resp = await dio.get('/matches');
      final matches = (resp.data['data'] as List).cast<Map<String, dynamic>>();
      final match = matches.firstWhere((m) => m['id'] == widget.matchId, orElse: () => <String, dynamic>{});
      final partnerId = match['userAId'] == _myUserId ? match['userBId'] : match['userAId'];
      if (partnerId != null) {
        await dio.post('/user/block/$partnerId');
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('已拉黑')));
          context.pop();
        }
      }
    } catch (_) {}
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }
}

/// 聊天气泡组件
class _MessageBubble extends StatelessWidget {
  final ChatMessage message;
  final bool isMine;

  const _MessageBubble({required this.message, required this.isMine});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: isMine ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // 对方头像
          if (!isMine) ...[
            Container(
              width: 36, height: 36,
              decoration: const BoxDecoration(
                color: AppTheme.secondary,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.person, size: 20, color: Colors.white),
            ),
            const SizedBox(width: 10),
          ],
          // 气泡
          Flexible(
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.7),
              decoration: BoxDecoration(
                color: isMine ? AppTheme.primary : AppTheme.surface,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(20),
                  topRight: const Radius.circular(20),
                  bottomLeft: Radius.circular(isMine ? 20 : 6),
                  bottomRight: Radius.circular(isMine ? 6 : 20),
                ),
                boxShadow: isMine ? [] : AppTheme.shadowSm,
              ),
              child: Text(
                message.content,
                style: TextStyle(
                  fontSize: 15,
                  height: 1.5,
                  color: isMine ? Colors.white : AppTheme.textPrimary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
