import 'package:flutter/material.dart';

void main() {
  runApp(const XHNInnovationApp());
}

// ① 修改：App 类名改为个人专属
class XHNInnovationApp extends StatelessWidget {
  const XHNInnovationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // ② 修改：标签页标题（浏览器/任务栏显示的名称）
      title: '徐浩宁的创新实验 - 第14周',
      // ③ 修改：主题色从默认蓝绿色改为深紫色
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const XHNHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class XHNHomePage extends StatefulWidget {
  const XHNHomePage({super.key});

  @override
  State<XHNHomePage> createState() => _XHNHomePageState();
}

class _XHNHomePageState extends State<XHNHomePage> {
  // ④ 修改：计数器语义改为"完成任务次数"
  int _completedTasks = 0;

  void _finishOneTask() {
    setState(() {
      _completedTasks++;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      // ⑤ 修改：AppBar 标题改为本人信息
      appBar: AppBar(
        backgroundColor: colorScheme.inversePrimary,
        title: const Text('徐浩宁 · 创新实验第14周'),
        // ⑥ 修改：AppBar 新增导航图标
        leading: const Icon(Icons.science_outlined),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // ⑦ 修改：新增顶部 Flutter Logo 图标
              Icon(Icons.flutter_dash, size: 80, color: colorScheme.primary),
              const SizedBox(height: 16),

              // ⑦ 修改：新增学校/学号信息文字
              Text(
                '云南大学 · 20231060050',
                style: TextStyle(
                  fontSize: 14,
                  color: colorScheme.outline,
                ),
              ),
              const SizedBox(height: 8),

              // ⑤ 修改：页面提示语改为任务完成相关
              const Text(
                'Hello Flutter！\n我正在完成第14周入门任务',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 32),

              // ⑧ 修改：计数器改为卡片式布局，优化间距与字体
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
                      Icon(Icons.task_alt,
                          size: 36, color: colorScheme.primary),
                      const SizedBox(height: 12),
                      Text(
                        // ④ 修改：计数文案改为"已完成任务"
                        '已完成任务',
                        style: TextStyle(
                          fontSize: 16,
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '$_completedTasks 次',
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

              // ⑦ 修改：底部新增多个图标行
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.school, color: colorScheme.secondary, size: 28),
                  const SizedBox(width: 16),
                  Icon(Icons.code, color: colorScheme.secondary, size: 28),
                  const SizedBox(width: 16),
                  Icon(Icons.rocket_launch,
                      color: colorScheme.secondary, size: 28),
                  const SizedBox(width: 16),
                  Icon(Icons.star, color: colorScheme.secondary, size: 28),
                ],
              ),
            ],
          ),
        ),
      ),

      // ⑤ 修改：FAB 按钮改为"完成打卡"，配合任务语义
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _finishOneTask,
        icon: const Icon(Icons.check_circle_outline),
        label: const Text('完成一次打卡'),
        tooltip: '点击记录完成一次任务',
      ),
    );
  }
}
