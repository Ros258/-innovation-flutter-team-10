import 'package:flutter/material.dart';

void main() {
  runApp(const DiyuhuoApp());
}

// ① 类名改为个人专属
class DiyuhuoApp extends StatelessWidget {
  const DiyuhuoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // ② 标签页标题
      title: '刘博文20231060079第十组',
      // ③ 主题色：科技蓝
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      home: const DiyuhuoHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class DiyuhuoHomePage extends StatefulWidget {
  const DiyuhuoHomePage({super.key});

  @override
  State<DiyuhuoHomePage> createState() => _DiyuhuoHomePageState();
}

class _DiyuhuoHomePageState extends State<DiyuhuoHomePage> {
  // ④ 计数器：打卡次数
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
      // ⑤ AppBar 标题
      appBar: AppBar(
        backgroundColor: colorScheme.inversePrimary,
        title: const Text('欢迎来到地狱火的主页'),
        // ⑥ 新增头像图标
        leading: const Icon(Icons.local_fire_department),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // ⑦ 顶部大图标（火焰）
              Icon(Icons.local_fire_department,
                  size: 80, color: colorScheme.primary),
              const SizedBox(height: 16),

              // ⑧ 姓名 + 学号 + 小组
              Text(
                '刘博文 · 20231060079 · 第十组',
                style: TextStyle(
                  fontSize: 14,
                  color: colorScheme.outline,
                ),
              ),
              const SizedBox(height: 8),

              // ⑨ 页面提示语
              const Text(
                '🔥 欢迎来到地狱火的主页！\n让我们一起探索 Flutter 的世界',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 32),

              // ⑩ 计数器：卡片式布局
              Card(
                elevation: 6,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 32.0, horizontal: 48.0),
                  child: Column(
                    children: [
                      // 火焰图标
                      Icon(Icons.local_fire_department,
                          size: 40, color: colorScheme.primary),
                      const SizedBox(height: 12),
                      Text(
                        '地狱火打卡次数',
                        style: TextStyle(
                          fontSize: 16,
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '$_checkInCount 次',
                        style: TextStyle(
                          fontSize: 52,
                          fontWeight: FontWeight.w800,
                          color: colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // ⑪ 底部图标行（多个图标）
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.flutter_dash,
                      color: colorScheme.secondary, size: 30),
                  const SizedBox(width: 16),
                  Icon(Icons.code,
                      color: colorScheme.secondary, size: 30),
                  const SizedBox(width: 16),
                  Icon(Icons.groups,
                      color: colorScheme.secondary, size: 30),
                  const SizedBox(width: 16),
                  Icon(Icons.emoji_events,
                      color: colorScheme.secondary, size: 30),
                  const SizedBox(width: 16),
                  Icon(Icons.rocket_launch,
                      color: colorScheme.secondary, size: 30),
                ],
              ),
            ],
          ),
        ),
      ),

      // ⑫ FAB 按钮
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _doCheckIn,
        icon: const Icon(Icons.add_task),
        label: const Text('地狱火打卡'),
        tooltip: '点击完成一次打卡',
      ),
    );
  }
}
