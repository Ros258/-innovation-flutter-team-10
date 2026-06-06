import 'package:flutter/material.dart';
import 'dart:math' as math;

void main() {
  runApp(const InnovationHelloApp());
}

class InnovationHelloApp extends StatelessWidget {
  const InnovationHelloApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '创新实验打卡',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFFF8C00),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const HelloHomePage(),
    );
  }
}

class HelloHomePage extends StatefulWidget {
  const HelloHomePage({super.key});

  @override
  State<HelloHomePage> createState() => _HelloHomePageState();
}

class _HelloHomePageState extends State<HelloHomePage>
    with TickerProviderStateMixin {
  int completedTasks = 0;
  static const int maxTasks = 10;

  late AnimationController _pulseController;
  late AnimationController _checkController;
  late Animation<double> _pulseAnimation;
  late Animation<double> _checkAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.10).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _checkController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _checkAnimation = CurvedAnimation(
      parent: _checkController,
      curve: Curves.elasticOut,
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _checkController.dispose();
    super.dispose();
  }

  void finishOneTask() {
    if (completedTasks < maxTasks) {
      setState(() {
        completedTasks += 1;
      });
      _checkController.forward(from: 0.0);
    }
  }

  void resetTasks() {
    setState(() {
      completedTasks = 0;
    });
  }

  String get _levelEmoji {
    if (completedTasks >= 9) return '🏆';
    if (completedTasks >= 6) return '🔥';
    if (completedTasks >= 3) return '⚡';
    return '🌱';
  }

  String get _motivationText {
    if (completedTasks >= 10) return '满分！传说级学霸！';
    if (completedTasks >= 6) return '效率爆表，冲刺满分！';
    if (completedTasks >= 3) return '加油！保持这个节奏！';
    if (completedTasks >= 1) return '已出发，继续打卡！';
    return '今天还没开始，动起来！';
  }

  Color get _progressColor {
    final ratio = completedTasks / maxTasks;
    if (ratio >= 0.9) return const Color(0xFFFF4444);
    if (ratio >= 0.6) return const Color(0xFFFF8C00);
    if (ratio >= 0.3) return const Color(0xFF4CAF50);
    return const Color(0xFF2196F3);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '创新实验 Flutter 首页',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
        ),
        backgroundColor: const Color(0xFFFF8C00),
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Icon(Icons.local_fire_department,
                color: Colors.white, size: 26),
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFFFF8E1),
              Color(0xFFFFE0B2),
              Color(0xFFFFF3E0),
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // ── 头像区域 ──
                Center(
                  child: ScaleTransition(
                    scale: _pulseAnimation,
                    child: Container(
                      width: 90,
                      height: 90,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: const LinearGradient(
                          colors: [Color(0xFFFF8C00), Color(0xFFFFD700)],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFFFF8C00).withOpacity(0.5),
                            blurRadius: 18,
                            spreadRadius: 4,
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.person,
                        size: 52,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // ── 个人信息卡 ──
                _buildCard(
                  child: Column(
                    children: [
                      const Text(
                        'Hello Flutter！我已完成第 14 周入门任务！',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF4A3000),
                        ),
                      ),
                      const SizedBox(height: 12),
                      _buildInfoRow(Icons.groups, '小组', '第10组'),
                      const SizedBox(height: 6),
                      _buildInfoRow(Icons.calendar_today, '本周任务', '创新实验 · 第14周'),
                    ],
                  ),
                ),
                const SizedBox(height: 14),

                // ── 打卡计数卡 ──
                _buildCard(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFFF8C00), Color(0xFFFF6F00)],
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            _levelEmoji,
                            style: const TextStyle(fontSize: 28),
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            '今日打卡进度',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      ScaleTransition(
                        scale: _checkAnimation,
                        child: Text(
                          '$completedTasks / $maxTasks',
                          style: const TextStyle(
                            fontSize: 52,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _motivationText,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 14),

                // ── 进度条卡 ──
                _buildCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            '今日进度',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Color(0xFF4A3000),
                            ),
                          ),
                          Text(
                            '${(completedTasks / maxTasks * 100).toStringAsFixed(0)}%',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: _progressColor,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: TweenAnimationBuilder<double>(
                          tween: Tween(
                            begin: 0,
                            end: completedTasks / maxTasks,
                          ),
                          duration: const Duration(milliseconds: 500),
                          builder: (context, value, child) {
                            return LinearProgressIndicator(
                              value: value,
                              minHeight: 14,
                              backgroundColor: Colors.grey.shade200,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                _progressColor,
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildMilestone(3, completedTasks, '⚡'),
                          _buildMilestone(6, completedTasks, '🔥'),
                          _buildMilestone(10, completedTasks, '🏆'),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 14),

                // ── 图标展示区 ──
                _buildCard(
                  child: Column(
                    children: [
                      const Text(
                        '技能徽章',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Color(0xFF4A3000),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildBadge(Icons.rocket_launch, '入门', Colors.indigo),
                          _buildBadge(Icons.code, '编程', Colors.teal),
                          _buildBadge(Icons.smartphone, '移动端', Colors.orange),
                          _buildBadge(Icons.cloud_done, '协作', Colors.green),
                          _buildBadge(Icons.star, '创新', Colors.amber),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // ── 打卡按钮 ──
                SizedBox(
                  height: 54,
                  child: ElevatedButton.icon(
                    onPressed: completedTasks < maxTasks ? finishOneTask : null,
                    icon: const Icon(Icons.check_circle, size: 22),
                    label: Text(
                      completedTasks >= maxTasks ? '今日打卡完成！🎉' : '完成一次打卡',
                      style: const TextStyle(
                          fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFF8C00),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      elevation: 4,
                    ),
                  ),
                ),
                if (completedTasks > 0) ...[
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 44,
                    child: OutlinedButton.icon(
                      onPressed: resetTasks,
                      icon: const Icon(Icons.refresh, size: 18),
                      label: const Text('重置打卡'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.grey.shade600,
                        side: BorderSide(color: Colors.grey.shade400),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                    ),
                  ),
                ],
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCard({
    required Widget child,
    Gradient? gradient,
  }) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: gradient,
        color: gradient == null ? Colors.white : null,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 18, color: const Color(0xFFFF8C00)),
        const SizedBox(width: 8),
        Text(
          '$label：',
          style: const TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Color(0xFF4A3000),
          ),
        ),
      ],
    );
  }

  Widget _buildMilestone(int target, int current, String emoji) {
    final reached = current >= target;
    return Column(
      children: [
        Text(emoji, style: TextStyle(fontSize: reached ? 22 : 16)),
        Text(
          '$target次',
          style: TextStyle(
            fontSize: 11,
            color: reached ? _progressColor : Colors.grey,
            fontWeight: reached ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }

  Widget _buildBadge(IconData icon, String label, Color color) {
    return Column(
      children: [
        Container(
          width: 46,
          height: 46,
          decoration: BoxDecoration(
            color: color.withOpacity(0.12),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 24),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(fontSize: 11, color: color),
        ),
      ],
    );
  }
}
