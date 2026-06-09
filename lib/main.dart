import 'package:flutter/material.dart';

void main() {
  runApp(const MYInnovationApp());
}

// ① 修改：App 类名改为个人专属
class MYInnovationApp extends StatelessWidget {
  const MYInnovationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // ② 修改：标签页标题
      title: '马琰的创新实验 - 第14周',
      // ③ 修改：主题色改为活力橙色
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        useMaterial3: true,
      ),
      home: const MYHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MYHomePage extends StatefulWidget {
  const MYHomePage({super.key});

  @override
  State<MYHomePage> createState() => _MYHomePageState();
}

class _MYHomePageState extends State<MYHomePage> {
  // ④ 修改：计数器语义改为"打卡次数"
  int _checkInCount = 0;

  void _doCheckIn() {
    setState(() {
      _checkInCount++;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      // ⑤ 修改：AppBar 标题改为本人信息
      appBar: AppBar(
        backgroundColor: colorScheme.inversePrimary,
        title: const Text('马琰 · 创新实验第14周'),
        // ⑥ 修改：AppBar 新增头像图标
        leading: const Icon(Icons.person_pin),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // ⑦ 修改：顶部大图标
              Icon(Icons.rocket_launch, size: 80, color: colorScheme.primary),
              const SizedBox(height: 16),

              // ⑧ 修改：显示姓名 + 学号 + 小组
              Text(
                '马琰 · 20231120206 · 第10组',
                style: TextStyle(
                  fontSize: 14,
                  color: colorScheme.outline,
                ),
              ),
              const SizedBox(height: 8),

              // ⑨ 修改：页面提示语
              const Text(
                'Hello Flutter！\n我正在完成第14周入门任务',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 32),

              // ⑩ 修改：计数器改为卡片式布局
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 28.0, horizontal: 48.0),
                  child: Column(
                    children: [
                      Icon(Icons.favorite,
                          size: 36, color: colorScheme.primary),
                      const SizedBox(height: 12),
                      Text(
                        '今日打卡次数',
                        style: TextStyle(
                          fontSize: 16,
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '$_checkInCount 次',
                        style: TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.w800,
                          color: colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // ⑪ 修改：底部图标行
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.flutter_dash,
                      color: colorScheme.secondary, size: 28),
                  const SizedBox(width: 16),
                  Icon(Icons.github, color: colorScheme.secondary, size: 28),
                  const SizedBox(width: 16),
                  Icon(Icons.groups, color: colorScheme.secondary, size: 28),
                  const SizedBox(width: 16),
                  Icon(Icons.emoji_events,
                      color: colorScheme.secondary, size: 28),
                ],
              ),
            ],
          ),
        ),
      ),

      // ⑫ 修改：FAB 按钮
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _doCheckIn,
        icon: const Icon(Icons.add_task),
        label: const Text('打卡一次'),
        tooltip: '点击完成一次打卡',
      ),
    );
  }
}