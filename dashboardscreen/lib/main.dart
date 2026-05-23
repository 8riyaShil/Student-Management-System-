import 'package:flutter/material.dart';
import 'dart:math' as math;

void main() {
  runApp(const EduCoreApp());
}

// ─── Theme ───────────────────────────────────────────────────────────────────

class EduCoreTheme {
  // Dark
  static const darkBg = Color(0xFF0A0E1A);
  static const darkSurface = Color(0xFF111827);
  static const darkCard = Color(0xFF1A2236);
  static const darkAccent = Color(0xFF4F8EF7);
  static const darkAccent2 = Color(0xFF7C5CFC);
  static const darkAccent3 = Color(0xFF00D4AA);
  static const darkText = Color(0xFFEAEEF8);
  static const darkSubtext = Color(0xFF7A8BAA);
  static const darkBorder = Color(0xFF1E2D45);

  // Light
  static const lightBg = Color(0xFFF0F4FF);
  static const lightSurface = Color(0xFFFFFFFF);
  static const lightCard = Color(0xFFFFFFFF);
  static const lightAccent = Color(0xFF3B6EE8);
  static const lightAccent2 = Color(0xFF6B3FE4);
  static const lightAccent3 = Color(0xFF00B08B);
  static const lightText = Color(0xFF0D1B3E);
  static const lightSubtext = Color(0xFF6678A0);
  static const lightBorder = Color(0xFFD8E3FF);

  static ThemeData dark() => ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: darkBg,
        fontFamily: 'Outfit',
        colorScheme: const ColorScheme.dark(
          primary: darkAccent,
          secondary: darkAccent2,
          surface: darkSurface,
        ),
      );

  static ThemeData light() => ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: lightBg,
        fontFamily: 'Outfit',
        colorScheme: const ColorScheme.light(
          primary: lightAccent,
          secondary: lightAccent2,
          surface: lightSurface,
        ),
      );
}

// ─── App Root ─────────────────────────────────────────────────────────────────

class EduCoreApp extends StatefulWidget {
  const EduCoreApp({super.key});
  @override
  State<EduCoreApp> createState() => _EduCoreAppState();
}

class _EduCoreAppState extends State<EduCoreApp> {
  bool _isDark = true;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EduCore',
      debugShowCheckedModeBanner: false,
      theme: EduCoreTheme.light(),
      darkTheme: EduCoreTheme.dark(),
      themeMode: _isDark ? ThemeMode.dark : ThemeMode.light,
      home: MainShell(
        isDark: _isDark,
        onThemeToggle: () => setState(() => _isDark = !_isDark),
      ),
    );
  }
}

// ─── Data Models ──────────────────────────────────────────────────────────────

class Student {
  final String id;
  final String name;
  final String grade;
  final double gpa;
  final String avatar;
  final String subject;
  final String status;
  final int attendance;

  const Student({
    required this.id,
    required this.name,
    required this.grade,
    required this.gpa,
    required this.avatar,
    required this.subject,
    required this.status,
    required this.attendance,
  });
}

final List<Student> kStudents = [
  const Student(id: 'EC002', name: 'Arijit Barik',      grade: 'A',  gpa: 3.80, avatar: 'DS', subject: 'Physics',      status: 'active',   attendance: 92),
  const Student(id: 'EC003', name: 'Ishan Bhandari',     grade: 'B+', gpa: 3.50, avatar: 'PP', subject: 'Chemistry',    status: 'warning',  attendance: 75),
  const Student(id: 'EC004', name: 'Rahul Gorai',   grade: 'A',  gpa: 3.78, avatar: 'RH', subject: 'Biology',      status: 'active',   attendance: 94),
  const Student(id: 'EC005', name: 'Sneha Gupta',     grade: 'B',  gpa: 3.30, avatar: 'SG', subject: 'English',      status: 'inactive', attendance: 68),
  const Student(id: 'EC006', name: 'Arjun Mishra',    grade: 'A+', gpa: 4.00, avatar: 'AM', subject: 'Computer Sci', status: 'active',   attendance: 99),
  const Student(id: 'EC007', name: 'Souvik Das',   grade: 'A',  gpa: 3.85, avatar: 'FS', subject: 'Economics',    status: 'active',   attendance: 91),
  const Student(id: 'EC008', name: 'Kabir Das',       grade: 'C+', gpa: 2.80, avatar: 'KD', subject: 'History',      status: 'warning',  attendance: 71),
];

// ─── Shell / Navigation ───────────────────────────────────────────────────────

class MainShell extends StatefulWidget {
  final bool isDark;
  final VoidCallback onThemeToggle;
  const MainShell({super.key, required this.isDark, required this.onThemeToggle});
  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> with SingleTickerProviderStateMixin {
  int _selected = 0;
  late AnimationController _navAnim;

  final List<_NavItem> _navItems = const [
    _NavItem(Icons.dashboard_rounded, 'Dashboard'),
    _NavItem(Icons.people_alt_rounded, 'Students'),
    _NavItem(Icons.bar_chart_rounded, 'Analytics'),
    _NavItem(Icons.settings_rounded, 'Settings'),
  ];

  @override
  void initState() {
    super.initState();
    _navAnim = AnimationController(vsync: this, duration: const Duration(milliseconds: 300));
    _navAnim.forward();
  }

  @override
  void dispose() {
    _navAnim.dispose();
    super.dispose();
  }

  bool get _isDark => widget.isDark;

  Color get _bg       => _isDark ? EduCoreTheme.darkBg      : EduCoreTheme.lightBg;
  Color get _surface  => _isDark ? EduCoreTheme.darkSurface  : EduCoreTheme.lightSurface;
  Color get _accent   => _isDark ? EduCoreTheme.darkAccent   : EduCoreTheme.lightAccent;
  Color get _accent2  => _isDark ? EduCoreTheme.darkAccent2  : EduCoreTheme.lightAccent2;
  Color get _text     => _isDark ? EduCoreTheme.darkText     : EduCoreTheme.lightText;
  Color get _subtext  => _isDark ? EduCoreTheme.darkSubtext  : EduCoreTheme.lightSubtext;
  Color get _border   => _isDark ? EduCoreTheme.darkBorder   : EduCoreTheme.lightBorder;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      body: Row(
        children: [
          // ── Sidebar ──
          _buildSidebar(),
          // ── Content ──
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 350),
              transitionBuilder: (child, anim) => FadeTransition(
                opacity: anim,
                child: SlideTransition(
                  position: Tween(begin: const Offset(0.04, 0), end: Offset.zero).animate(anim),
                  child: child,
                ),
              ),
              child: _buildPage(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPage() {
    switch (_selected) {
      case 0: return DashboardPage(key: const ValueKey(0), isDark: _isDark, onThemeToggle: widget.onThemeToggle);
      case 1: return StudentsPage(key: const ValueKey(1), isDark: _isDark);
      case 2: return AnalyticsPage(key: const ValueKey(2), isDark: _isDark);
      case 3: return SettingsPage(key: const ValueKey(3), isDark: _isDark, onThemeToggle: widget.onThemeToggle);
      default: return const SizedBox.shrink();
    }
  }

  Widget _buildSidebar() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      width: 220,
      decoration: BoxDecoration(
        color: _surface,
        border: Border(right: BorderSide(color: _border, width: 1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Logo
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 28, 20, 32),
            child: Row(children: [
              _LogoMark(accent: _accent, accent2: _accent2),
              const SizedBox(width: 12),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('EduCore', style: TextStyle(color: _text, fontSize: 18, fontWeight: FontWeight.w700, letterSpacing: -0.5)),
                Text('v2.5 Pro', style: TextStyle(color: _accent, fontSize: 10, fontWeight: FontWeight.w600, letterSpacing: 1)),
              ]),
            ]),
          ),
          // Nav
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              itemCount: _navItems.length,
              separatorBuilder: (_, __) => const SizedBox(height: 4),
              itemBuilder: (_, i) => _NavTile(
                item: _navItems[i],
                selected: _selected == i,
                isDark: _isDark,
                onTap: () => setState(() => _selected = i),
                accent: _accent,
                text: _text,
                subtext: _subtext,
              ),
            ),
          ),
          // User card
          Padding(
            padding: const EdgeInsets.all(12),
            child: _UserCard(isDark: _isDark, text: _text, subtext: _subtext, border: _border, accent: _accent2),
          ),
        ],
      ),
    );
  }
}

class _NavItem {
  final IconData icon;
  final String label;
  const _NavItem(this.icon, this.label);
}

class _NavTile extends StatefulWidget {
  final _NavItem item;
  final bool selected;
  final bool isDark;
  final VoidCallback onTap;
  final Color accent, text, subtext;
  const _NavTile({required this.item, required this.selected, required this.isDark,
      required this.onTap, required this.accent, required this.text, required this.subtext});
  @override
  State<_NavTile> createState() => _NavTileState();
}

class _NavTileState extends State<_NavTile> {
  bool _hovered = false;
  @override
  Widget build(BuildContext context) {
    final active = widget.selected;
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit:  (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            color: active
                ? widget.accent.withOpacity(0.15)
                : _hovered ? widget.accent.withOpacity(0.06) : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(children: [
            Icon(widget.item.icon,
                size: 20,
                color: active ? widget.accent : _hovered ? widget.accent.withOpacity(0.7) : widget.subtext),
            const SizedBox(width: 12),
            Text(widget.item.label,
                style: TextStyle(
                  color: active ? widget.accent : _hovered ? widget.text : widget.subtext,
                  fontWeight: active ? FontWeight.w600 : FontWeight.w500,
                  fontSize: 14,
                )),
            if (active) ...[const Spacer(), Container(width: 6, height: 6, decoration: BoxDecoration(color: widget.accent, shape: BoxShape.circle))],
          ]),
        ),
      ),
    );
  }
}

class _LogoMark extends StatelessWidget {
  final Color accent, accent2;
  const _LogoMark({required this.accent, required this.accent2});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 36, height: 36,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [accent, accent2], begin: Alignment.topLeft, end: Alignment.bottomRight),
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Icon(Icons.school_rounded, color: Colors.white, size: 20),
    );
  }
}

class _UserCard extends StatelessWidget {
  final bool isDark;
  final Color text, subtext, border, accent;
  const _UserCard({required this.isDark, required this.text, required this.subtext, required this.border, required this.accent});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: border),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(children: [
        CircleAvatar(radius: 18, backgroundColor: accent.withOpacity(0.2),
            child: Text('AP', style: TextStyle(color: accent, fontSize: 12, fontWeight: FontWeight.w700))),
        const SizedBox(width: 10),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Admin Panel', style: TextStyle(color: text, fontSize: 12, fontWeight: FontWeight.w600)),
          Text('Super Admin', style: TextStyle(color: subtext, fontSize: 10)),
        ])),
        Icon(Icons.more_horiz, color: subtext, size: 18),
      ]),
    );
  }
}

// ─── Dashboard Page ───────────────────────────────────────────────────────────

class DashboardPage extends StatefulWidget {
  final bool isDark;
  final VoidCallback onThemeToggle;
  const DashboardPage({super.key, required this.isDark, required this.onThemeToggle});
  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late List<Animation<double>> _anims;

  bool get _isDark => widget.isDark;
  Color get _bg      => _isDark ? EduCoreTheme.darkBg      : EduCoreTheme.lightBg;
  Color get _card    => _isDark ? EduCoreTheme.darkCard     : EduCoreTheme.lightCard;
  Color get _accent  => _isDark ? EduCoreTheme.darkAccent   : EduCoreTheme.lightAccent;
  Color get _accent2 => _isDark ? EduCoreTheme.darkAccent2  : EduCoreTheme.lightAccent2;
  Color get _accent3 => _isDark ? EduCoreTheme.darkAccent3  : EduCoreTheme.lightAccent3;
  Color get _text    => _isDark ? EduCoreTheme.darkText     : EduCoreTheme.lightText;
  Color get _subtext => _isDark ? EduCoreTheme.darkSubtext  : EduCoreTheme.lightSubtext;
  Color get _border  => _isDark ? EduCoreTheme.darkBorder   : EduCoreTheme.lightBorder;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 900));
    _anims = List.generate(8, (i) => CurvedAnimation(
      parent: _ctrl,
      curve: Interval(i * 0.08, (i * 0.08 + 0.5).clamp(0, 1), curve: Curves.easeOut),
    ));
    _ctrl.forward();
  }

  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      body: Column(children: [
        _buildTopBar(),
        Expanded(child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(28, 0, 28, 28),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const SizedBox(height: 8),
            _buildHeroBanner(),
            const SizedBox(height: 24),
            _buildStatCards(),
            const SizedBox(height: 24),
            Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Expanded(flex: 3, child: _buildRecentStudents()),
              const SizedBox(width: 20),
              Expanded(flex: 2, child: Column(children: [
                _buildPerformanceRing(),
                const SizedBox(height: 20),
                _buildUpcomingEvents(),
              ])),
            ]),
          ]),
        )),
      ]),
    );
  }

  Widget _buildTopBar() {
    return Container(
      padding: const EdgeInsets.fromLTRB(28, 20, 28, 16),
      child: Row(children: [
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          FadeTransition(opacity: _anims[0],
            child: Text('Good Morning, Admin 👋', style: TextStyle(color: _subtext, fontSize: 13))),
          FadeTransition(opacity: _anims[0],
            child: Text('Dashboard Overview', style: TextStyle(color: _text, fontSize: 22, fontWeight: FontWeight.w700, letterSpacing: -0.5))),
        ]),
        const Spacer(),
        // Theme Toggle
        FadeTransition(opacity: _anims[1], child: _ThemeToggle(isDark: _isDark, onToggle: widget.onThemeToggle)),
        const SizedBox(width: 12),
        _SearchBar(isDark: _isDark, text: _text, subtext: _subtext, border: _border, card: _card),
        const SizedBox(width: 12),
        _NotifBell(isDark: _isDark, accent: _accent, text: _text, border: _border, card: _card),
      ]),
    );
  }

  Widget _buildHeroBanner() {
    return FadeTransition(
      opacity: _anims[1],
      child: SlideTransition(
        position: Tween(begin: const Offset(0, 0.1), end: Offset.zero).animate(_anims[1]),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(28),
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [_accent, _accent2], begin: Alignment.topLeft, end: Alignment.bottomRight),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Stack(children: [
            // Decorative circles
            Positioned(right: -20, top: -30, child: _Circle(80, Colors.white.withOpacity(0.08))),
            Positioned(right: 60, bottom: -20, child: _Circle(50, Colors.white.withOpacity(0.06))),
            Row(children: [
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Spring Semester 2025', style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 12, fontWeight: FontWeight.w600, letterSpacing: 0.5)),
                const SizedBox(height: 8),
                const Text('Manage. Monitor.\nInspire.', style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.w800, height: 1.2, letterSpacing: -0.8)),
                const SizedBox(height: 16),
                _PillButton(label: 'View Full Report', onTap: () {}),
              ])),
              const SizedBox(width: 20),
              Icon(Icons.auto_graph_rounded, size: 80, color: Colors.white.withOpacity(0.2)),
            ]),
          ]),
        ),
      ),
    );
  }

  Widget _buildStatCards() {
    final stats = [
      _StatData('Total Students', '1,248', Icons.people_alt_rounded, _accent,  '+12 this week', true),
      _StatData('Avg. GPA',       '3.62',  Icons.star_rounded,        _accent2, '+0.08 vs last sem', true),
      _StatData('Attendance',     '89.4%', Icons.check_circle_rounded,_accent3, '-1.2% this week', false),
      _StatData('Active Classes', '42',    Icons.class_rounded,        const Color(0xFFFF8C42), '6 ongoing now', true),
    ];
    return FadeTransition(
      opacity: _anims[2],
      child: Row(children: stats.asMap().entries.map((e) {
        return Expanded(child: Padding(
          padding: EdgeInsets.only(right: e.key < stats.length - 1 ? 14 : 0),
          child: _StatCard(data: e.value, isDark: _isDark, card: _card, text: _text, subtext: _subtext, border: _border),
        ));
      }).toList()),
    );
  }

  Widget _buildRecentStudents() {
    return FadeTransition(
      opacity: _anims[3],
      child: SlideTransition(
        position: Tween(begin: const Offset(0, 0.05), end: Offset.zero).animate(_anims[3]),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(color: _card, borderRadius: BorderRadius.circular(18), border: Border.all(color: _border)),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              Text('Recent Students', style: TextStyle(color: _text, fontWeight: FontWeight.w700, fontSize: 16)),
              const Spacer(),
              TextButton(onPressed: () {}, child: Text('See all', style: TextStyle(color: _accent, fontSize: 12))),
            ]),
            const SizedBox(height: 4),
            ...kStudents.take(5).map((s) => _StudentRow(student: s, isDark: _isDark, text: _text, subtext: _subtext, accent: _accent, border: _border)),
          ]),
        ),
      ),
    );
  }

  Widget _buildPerformanceRing() {
    return FadeTransition(
      opacity: _anims[4],
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(color: _card, borderRadius: BorderRadius.circular(18), border: Border.all(color: _border)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Class Performance', style: TextStyle(color: _text, fontWeight: FontWeight.w700, fontSize: 16)),
          const SizedBox(height: 20),
          Center(child: SizedBox(
            width: 140, height: 140,
            child: CustomPaint(
              painter: _RingPainter(isDark: _isDark, accent: _accent, accent2: _accent2, accent3: _accent3),
              child: Center(child: Column(mainAxisSize: MainAxisSize.min, children: [
                Text('A+', style: TextStyle(color: _text, fontSize: 26, fontWeight: FontWeight.w800)),
                Text('Overall', style: TextStyle(color: _subtext, fontSize: 10)),
              ])),
            ),
          )),
          const SizedBox(height: 16),
          ...[
            _RingLegend('Excellent (A+/A)', _accent,  '42%'),
            _RingLegend('Good (B+/B)',       _accent2, '35%'),
            _RingLegend('Average (C+/C)',    _accent3, '23%'),
          ].map((w) => Padding(padding: const EdgeInsets.only(bottom: 6), child: w)),
        ]),
      ),
    );
  }

  Widget _buildUpcomingEvents() {
    final events = [
      _Event('Mid-term Exams', 'Jul 15 – Jul 22', Icons.assignment_rounded, _accent),
      _Event('Science Fair',   'Jul 28',           Icons.science_rounded,    _accent2),
      _Event('Result Day',     'Aug 5',            Icons.emoji_events_rounded,_accent3),
    ];
    return FadeTransition(
      opacity: _anims[5],
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(color: _card, borderRadius: BorderRadius.circular(18), border: Border.all(color: _border)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Upcoming Events', style: TextStyle(color: _text, fontWeight: FontWeight.w700, fontSize: 16)),
          const SizedBox(height: 12),
          ...events.map((e) => Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(children: [
              Container(width: 36, height: 36,
                  decoration: BoxDecoration(color: e.color.withOpacity(0.15), borderRadius: BorderRadius.circular(10)),
                  child: Icon(e.icon, color: e.color, size: 18)),
              const SizedBox(width: 12),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(e.title, style: TextStyle(color: _text, fontSize: 13, fontWeight: FontWeight.w600)),
                Text(e.date,  style: TextStyle(color: _subtext, fontSize: 11)),
              ]),
            ]),
          )),
        ]),
      ),
    );
  }
}

class _Event {
  final String title, date;
  final IconData icon;
  final Color color;
  const _Event(this.title, this.date, this.icon, this.color);
}

class _Circle extends StatelessWidget {
  final double size;
  final Color color;
  const _Circle(this.size, this.color);
  @override
  Widget build(BuildContext context) => Container(
    width: size, height: size,
    decoration: BoxDecoration(color: color, shape: BoxShape.circle),
  );
}

class _PillButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  const _PillButton({required this.label, required this.onTap});
  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(20)),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        Text(label, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600)),
        const SizedBox(width: 6),
        const Icon(Icons.arrow_forward_rounded, size: 14, color: Colors.white),
      ]),
    ),
  );
}

// ─── Stat Card ────────────────────────────────────────────────────────────────

class _StatData {
  final String label, value, sub;
  final IconData icon;
  final Color color;
  final bool up;
  const _StatData(this.label, this.value, this.icon, this.color, this.sub, this.up);
}

class _StatCard extends StatefulWidget {
  final _StatData data;
  final bool isDark;
  final Color card, text, subtext, border;
  const _StatCard({required this.data, required this.isDark, required this.card, required this.text, required this.subtext, required this.border});
  @override State<_StatCard> createState() => _StatCardState();
}

class _StatCardState extends State<_StatCard> {
  bool _hovered = false;
  @override
  Widget build(BuildContext context) {
    final d = widget.data;
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit:  (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: widget.card,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: _hovered ? d.color.withOpacity(0.4) : widget.border),
          boxShadow: _hovered ? [BoxShadow(color: d.color.withOpacity(0.12), blurRadius: 16, offset: const Offset(0, 4))] : [],
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            Container(width: 38, height: 38,
                decoration: BoxDecoration(color: d.color.withOpacity(0.12), borderRadius: BorderRadius.circular(10)),
                child: Icon(d.icon, color: d.color, size: 20)),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: (d.up ? Colors.green : Colors.red).withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(mainAxisSize: MainAxisSize.min, children: [
                Icon(d.up ? Icons.trending_up : Icons.trending_down, size: 12, color: d.up ? Colors.green : Colors.red),
                const SizedBox(width: 3),
                Text(d.up ? 'Up' : 'Down', style: TextStyle(color: d.up ? Colors.green : Colors.red, fontSize: 10, fontWeight: FontWeight.w600)),
              ]),
            ),
          ]),
          const SizedBox(height: 14),
          Text(d.value, style: TextStyle(color: widget.text, fontSize: 26, fontWeight: FontWeight.w800, letterSpacing: -0.5)),
          const SizedBox(height: 4),
          Text(d.label, style: TextStyle(color: widget.subtext, fontSize: 12, fontWeight: FontWeight.w500)),
          const SizedBox(height: 8),
          Text(d.sub, style: TextStyle(color: d.color, fontSize: 11, fontWeight: FontWeight.w500)),
        ]),
      ),
    );
  }
}

// ─── Student Row ──────────────────────────────────────────────────────────────

class _StudentRow extends StatelessWidget {
  final Student student;
  final bool isDark;
  final Color text, subtext, accent, border;
  const _StudentRow({required this.student, required this.isDark, required this.text, required this.subtext, required this.accent, required this.border});

  Color get _statusColor => switch (student.status) {
    'active'   => const Color(0xFF00D4AA),
    'warning'  => const Color(0xFFFF8C42),
    _          => const Color(0xFF8899AA),
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 2),
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(border: Border(bottom: BorderSide(color: border.withOpacity(0.5)))),
      child: Row(children: [
        CircleAvatar(radius: 18, backgroundColor: accent.withOpacity(0.15),
            child: Text(student.avatar, style: TextStyle(color: accent, fontSize: 11, fontWeight: FontWeight.w700))),
        const SizedBox(width: 12),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(student.name, style: TextStyle(color: text, fontSize: 13, fontWeight: FontWeight.w600)),
          Text(student.subject, style: TextStyle(color: subtext, fontSize: 11)),
        ])),
        Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
          Text(student.grade, style: TextStyle(color: accent, fontSize: 13, fontWeight: FontWeight.w700)),
          Row(children: [
            Container(width: 6, height: 6, decoration: BoxDecoration(color: _statusColor, shape: BoxShape.circle)),
            const SizedBox(width: 4),
            Text('${student.attendance}%', style: TextStyle(color: subtext, fontSize: 10)),
          ]),
        ]),
      ]),
    );
  }
}

// ─── Ring Painter ─────────────────────────────────────────────────────────────

class _RingPainter extends CustomPainter {
  final bool isDark;
  final Color accent, accent2, accent3;
  const _RingPainter({required this.isDark, required this.accent, required this.accent2, required this.accent3});

  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2, cy = size.height / 2;
    final r = (size.shortestSide / 2) - 12;
    final bg = isDark ? const Color(0xFF1A2236) : const Color(0xFFE8EEFF);
    final bgPaint = Paint()..color = bg ..style = PaintingStyle.stroke ..strokeWidth = 16 ..strokeCap = StrokeCap.round;
    canvas.drawCircle(Offset(cx, cy), r, bgPaint);

    final segments = [
      (0.42, accent),
      (0.35, accent2),
      (0.23, accent3),
    ];
    double start = -math.pi / 2;
    for (final seg in segments) {
      final sweep = 2 * math.pi * seg.$1;
      canvas.drawArc(
        Rect.fromCircle(center: Offset(cx, cy), radius: r),
        start, sweep - 0.06, false,
        Paint()..color = seg.$2 ..style = PaintingStyle.stroke ..strokeWidth = 14 ..strokeCap = StrokeCap.round,
      );
      start += sweep;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter old) => true;
}

class _RingLegend extends StatelessWidget {
  final String label, value;
  final Color color;
  const _RingLegend(this.label, this.color, this.value);
  @override
  Widget build(BuildContext context) => Row(children: [
    Container(width: 10, height: 10, decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(3))),
    const SizedBox(width: 8),
    Expanded(child: Text(label, style: TextStyle(color: Theme.of(context).brightness == Brightness.dark ? EduCoreTheme.darkSubtext : EduCoreTheme.lightSubtext, fontSize: 11))),
    Text(value, style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.w600)),
  ]);
}

// ─── Theme Toggle ─────────────────────────────────────────────────────────────

class _ThemeToggle extends StatelessWidget {
  final bool isDark;
  final VoidCallback onToggle;
  const _ThemeToggle({required this.isDark, required this.onToggle});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onToggle,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: 72, height: 34,
        padding: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          gradient: isDark
              ? const LinearGradient(colors: [Color(0xFF1A2236), Color(0xFF0F1A2E)])
              : const LinearGradient(colors: [Color(0xFFD4EAFF), Color(0xFFE8F4FF)]),
          borderRadius: BorderRadius.circular(17),
          border: Border.all(color: isDark ? const Color(0xFF2A3D5E) : const Color(0xFFB8D4F0)),
        ),
        child: Stack(children: [
          AnimatedAlign(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            alignment: isDark ? Alignment.centerRight : Alignment.centerLeft,
            child: Container(
              width: 26, height: 26,
              decoration: BoxDecoration(
                gradient: isDark
                    ? const LinearGradient(colors: [Color(0xFF4F8EF7), Color(0xFF7C5CFC)])
                    : const LinearGradient(colors: [Color(0xFFFFD700), Color(0xFFFFA500)]),
                shape: BoxShape.circle,
                boxShadow: [BoxShadow(color: (isDark ? const Color(0xFF4F8EF7) : const Color(0xFFFFD700)).withOpacity(0.4), blurRadius: 8)],
              ),
              child: Icon(isDark ? Icons.nights_stay_rounded : Icons.wb_sunny_rounded, size: 14, color: Colors.white),
            ),
          ),
        ]),
      ),
    );
  }
}

// ─── Search Bar ───────────────────────────────────────────────────────────────

class _SearchBar extends StatelessWidget {
  final bool isDark;
  final Color text, subtext, border, card;
  const _SearchBar({required this.isDark, required this.text, required this.subtext, required this.border, required this.card});
  @override
  Widget build(BuildContext context) => Container(
    width: 200, height: 38,
    padding: const EdgeInsets.symmetric(horizontal: 12),
    decoration: BoxDecoration(color: card, borderRadius: BorderRadius.circular(10), border: Border.all(color: border)),
    child: Row(children: [
      Icon(Icons.search_rounded, color: subtext, size: 16),
      const SizedBox(width: 8),
      Expanded(child: TextField(
        style: TextStyle(color: text, fontSize: 13),
        decoration: InputDecoration(
          border: InputBorder.none, hintText: 'Search students...',
          hintStyle: TextStyle(color: subtext, fontSize: 13), isDense: true,
        ),
      )),
    ]),
  );
}

class _NotifBell extends StatelessWidget {
  final bool isDark;
  final Color accent, text, border, card;
  const _NotifBell({required this.isDark, required this.accent, required this.text, required this.border, required this.card});
  @override
  Widget build(BuildContext context) => Stack(children: [
    Container(width: 38, height: 38,
        decoration: BoxDecoration(color: card, borderRadius: BorderRadius.circular(10), border: Border.all(color: border)),
        child: Icon(Icons.notifications_rounded, color: text, size: 18)),
    Positioned(top: 6, right: 6, child: Container(width: 8, height: 8,
        decoration: BoxDecoration(color: accent, shape: BoxShape.circle, border: Border.all(color: isDark ? EduCoreTheme.darkBg : EduCoreTheme.lightBg, width: 1.5)))),
  ]);
}

// ─── Students Page ────────────────────────────────────────────────────────────

class StudentsPage extends StatefulWidget {
  final bool isDark;
  const StudentsPage({super.key, required this.isDark});
  @override State<StudentsPage> createState() => _StudentsPageState();
}

class _StudentsPageState extends State<StudentsPage> {
  String _filter = 'all';

  bool get _isDark => widget.isDark;
  Color get _bg     => _isDark ? EduCoreTheme.darkBg      : EduCoreTheme.lightBg;
  Color get _card   => _isDark ? EduCoreTheme.darkCard     : EduCoreTheme.lightCard;
  Color get _accent => _isDark ? EduCoreTheme.darkAccent   : EduCoreTheme.lightAccent;
  Color get _text   => _isDark ? EduCoreTheme.darkText     : EduCoreTheme.lightText;
  Color get _sub    => _isDark ? EduCoreTheme.darkSubtext  : EduCoreTheme.lightSubtext;
  Color get _border => _isDark ? EduCoreTheme.darkBorder   : EduCoreTheme.lightBorder;

  List<Student> get _filtered => _filter == 'all' ? kStudents : kStudents.where((s) => s.status == _filter).toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      body: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            Text('All Students', style: TextStyle(color: _text, fontSize: 22, fontWeight: FontWeight.w700, letterSpacing: -0.5)),
            const Spacer(),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(backgroundColor: _accent, foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)), elevation: 0),
              onPressed: () {},
              icon: const Icon(Icons.add_rounded, size: 16),
              label: const Text('Add Student', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
            ),
          ]),
          const SizedBox(height: 16),
          // Filter chips
          Row(children: ['all', 'active', 'warning', 'inactive'].map((f) {
            final sel = _filter == f;
            return Padding(padding: const EdgeInsets.only(right: 8), child: GestureDetector(
              onTap: () => setState(() => _filter = f),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: sel ? _accent : _card,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: sel ? _accent : _border),
                ),
                child: Text(f[0].toUpperCase() + f.substring(1), style: TextStyle(color: sel ? Colors.white : _sub, fontSize: 12, fontWeight: FontWeight.w600)),
              ),
            ));
          }).toList()),
          const SizedBox(height: 20),
          // Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(color: _card, borderRadius: BorderRadius.circular(10), border: Border.all(color: _border)),
            child: Row(children: [
              _ColHead('Student', flex: 3, text: _sub),
              _ColHead('Subject', flex: 2, text: _sub),
              _ColHead('GPA', flex: 1, text: _sub),
              _ColHead('Grade', flex: 1, text: _sub),
              _ColHead('Attendance', flex: 2, text: _sub),
              _ColHead('Status', flex: 1, text: _sub),
            ]),
          ),
          const SizedBox(height: 8),
          Expanded(child: ListView.separated(
            itemCount: _filtered.length,
            separatorBuilder: (_, __) => const SizedBox(height: 6),
            itemBuilder: (_, i) => _StudentTableRow(student: _filtered[i], isDark: _isDark, accent: _accent, text: _text, subtext: _sub, card: _card, border: _border),
          )),
        ]),
      ),
    );
  }
}

class _ColHead extends StatelessWidget {
  final String label;
  final int flex;
  final Color text;
  const _ColHead(this.label, {required this.flex, required this.text});
  @override
  Widget build(BuildContext context) => Expanded(flex: flex, child: Text(label, style: TextStyle(color: text, fontSize: 11, fontWeight: FontWeight.w600, letterSpacing: 0.5)));
}

class _StudentTableRow extends StatefulWidget {
  final Student student;
  final bool isDark;
  final Color accent, text, subtext, card, border;
  const _StudentTableRow({required this.student, required this.isDark, required this.accent, required this.text, required this.subtext, required this.card, required this.border});
  @override State<_StudentTableRow> createState() => _StudentTableRowState();
}

class _StudentTableRowState extends State<_StudentTableRow> {
  bool _hovered = false;
  Color get _statusColor => switch (widget.student.status) {
    'active'   => const Color(0xFF00D4AA),
    'warning'  => const Color(0xFFFF8C42),
    _          => const Color(0xFF8899AA),
  };
  @override
  Widget build(BuildContext context) {
    final s = widget.student;
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit:  (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: _hovered ? widget.accent.withOpacity(0.05) : widget.card,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _hovered ? widget.accent.withOpacity(0.2) : widget.border),
        ),
        child: Row(children: [
          Expanded(flex: 3, child: Row(children: [
            CircleAvatar(radius: 16, backgroundColor: widget.accent.withOpacity(0.15),
                child: Text(s.avatar, style: TextStyle(color: widget.accent, fontSize: 10, fontWeight: FontWeight.w700))),
            const SizedBox(width: 10),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(s.name, style: TextStyle(color: widget.text, fontSize: 13, fontWeight: FontWeight.w600)),
              Text(s.id,   style: TextStyle(color: widget.subtext, fontSize: 10)),
            ]),
          ])),
          Expanded(flex: 2, child: Text(s.subject, style: TextStyle(color: widget.subtext, fontSize: 12))),
          Expanded(flex: 1, child: Text(s.gpa.toStringAsFixed(2), style: TextStyle(color: widget.text, fontSize: 13, fontWeight: FontWeight.w600))),
          Expanded(flex: 1, child: Text(s.grade, style: TextStyle(color: widget.accent, fontSize: 13, fontWeight: FontWeight.w700))),
          Expanded(flex: 2, child: Row(children: [
            Expanded(child: ClipRRect(borderRadius: BorderRadius.circular(4), child: LinearProgressIndicator(
              value: s.attendance / 100, minHeight: 6,
              backgroundColor: widget.border,
              valueColor: AlwaysStoppedAnimation(_statusColor),
            ))),
            const SizedBox(width: 8),
            Text('${s.attendance}%', style: TextStyle(color: widget.subtext, fontSize: 11)),
          ])),
          Expanded(flex: 1, child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(color: _statusColor.withOpacity(0.12), borderRadius: BorderRadius.circular(6)),
            child: Text(s.status, style: TextStyle(color: _statusColor, fontSize: 10, fontWeight: FontWeight.w600)),
          )),
        ]),
      ),
    );
  }
}

// ─── Analytics Page ───────────────────────────────────────────────────────────

class AnalyticsPage extends StatelessWidget {
  final bool isDark;
  const AnalyticsPage({super.key, required this.isDark});

  Color get _bg     => isDark ? EduCoreTheme.darkBg      : EduCoreTheme.lightBg;
  Color get _card   => isDark ? EduCoreTheme.darkCard     : EduCoreTheme.lightCard;
  Color get _accent => isDark ? EduCoreTheme.darkAccent   : EduCoreTheme.lightAccent;
  Color get _accent2=> isDark ? EduCoreTheme.darkAccent2  : EduCoreTheme.lightAccent2;
  Color get _accent3=> isDark ? EduCoreTheme.darkAccent3  : EduCoreTheme.lightAccent3;
  Color get _text   => isDark ? EduCoreTheme.darkText     : EduCoreTheme.lightText;
  Color get _sub    => isDark ? EduCoreTheme.darkSubtext  : EduCoreTheme.lightSubtext;
  Color get _border => isDark ? EduCoreTheme.darkBorder   : EduCoreTheme.lightBorder;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      body: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Analytics', style: TextStyle(color: _text, fontSize: 22, fontWeight: FontWeight.w700, letterSpacing: -0.5)),
          const SizedBox(height: 6),
          Text('Performance insights for Spring 2025', style: TextStyle(color: _sub, fontSize: 13)),
          const SizedBox(height: 24),
          Expanded(child: Column(children: [
            Row(children: [
              Expanded(child: _AnalyticsCard(
                title: 'GPA Distribution', isDark: isDark, card: _card, border: _border, text: _text, sub: _sub,
                child: _GpaBarChart(isDark: isDark, accent: _accent, accent2: _accent2, accent3: _accent3, sub: _sub),
              )),
              const SizedBox(width: 20),
              Expanded(child: _AnalyticsCard(
                title: 'Subject Performance', isDark: isDark, card: _card, border: _border, text: _text, sub: _sub,
                child: _SubjectChart(isDark: isDark, accent: _accent, accent2: _accent2, accent3: _accent3, text: _text, sub: _sub, border: _border),
              )),
            ]),
            const SizedBox(height: 20),
            _AnalyticsCard(
              title: 'Monthly Attendance Trend', isDark: isDark, card: _card, border: _border, text: _text, sub: _sub,
              child: _AttendanceChart(isDark: isDark, accent: _accent, border: _border, sub: _sub),
            ),
          ])),
        ]),
      ),
    );
  }
}

class _AnalyticsCard extends StatelessWidget {
  final String title;
  final bool isDark;
  final Color card, border, text, sub;
  final Widget child;
  const _AnalyticsCard({required this.title, required this.isDark, required this.card, required this.border, required this.text, required this.sub, required this.child});
  @override
  Widget build(BuildContext context) => Expanded(child: Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(color: card, borderRadius: BorderRadius.circular(18), border: Border.all(color: border)),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(title, style: TextStyle(color: text, fontWeight: FontWeight.w700, fontSize: 15)),
      const SizedBox(height: 16),
      Expanded(child: child),
    ]),
  ));
}

class _GpaBarChart extends StatelessWidget {
  final bool isDark;
  final Color accent, accent2, accent3, sub;
  const _GpaBarChart({required this.isDark, required this.accent, required this.accent2, required this.accent3, required this.sub});

  @override
  Widget build(BuildContext context) {
    final data = [
      ('A+', 0.32, accent),
      ('A',  0.28, accent2),
      ('B+', 0.20, accent3),
      ('B',  0.12, const Color(0xFFFF8C42)),
      ('C+', 0.08, const Color(0xFF8899AA)),
    ];
    return Row(crossAxisAlignment: CrossAxisAlignment.end, mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: data.map((d) {
      return Column(mainAxisAlignment: MainAxisAlignment.end, children: [
        Text('${(d.$2 * 100).toInt()}%', style: TextStyle(color: d.$3, fontSize: 10, fontWeight: FontWeight.w600)),
        const SizedBox(height: 4),
        AnimatedContainer(
          duration: const Duration(milliseconds: 600),
          width: 32, height: 120 * d.$2,
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [d.$3, d.$3.withOpacity(0.5)], begin: Alignment.topCenter, end: Alignment.bottomCenter),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(6)),
          ),
        ),
        const SizedBox(height: 6),
        Text(d.$1, style: TextStyle(color: sub, fontSize: 11)),
      ]);
    }).toList());
  }
}

class _SubjectChart extends StatelessWidget {
  final bool isDark;
  final Color accent, accent2, accent3, text, sub, border;
  const _SubjectChart({required this.isDark, required this.accent, required this.accent2, required this.accent3, required this.text, required this.sub, required this.border});

  @override
  Widget build(BuildContext context) {
    final data = [
      ('Mathematics',  0.92, accent),
      ('Physics',      0.85, accent2),
      ('Chemistry',    0.78, accent3),
      ('Biology',      0.88, const Color(0xFFFF8C42)),
      ('Computer Sci', 0.95, const Color(0xFFE040FB)),
    ];
    return Column(children: data.map((d) => Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(children: [
        SizedBox(width: 90, child: Text(d.$1, style: TextStyle(color: sub, fontSize: 11), overflow: TextOverflow.ellipsis)),
        Expanded(child: ClipRRect(borderRadius: BorderRadius.circular(4), child: LinearProgressIndicator(
          value: d.$2, minHeight: 8,
          backgroundColor: border,
          valueColor: AlwaysStoppedAnimation(d.$3),
        ))),
        const SizedBox(width: 8),
        Text('${(d.$2 * 100).toInt()}%', style: TextStyle(color: d.$3, fontSize: 11, fontWeight: FontWeight.w600)),
      ]),
    )).toList());
  }
}

class _AttendanceChart extends StatelessWidget {
  final bool isDark;
  final Color accent, border, sub;
  const _AttendanceChart({required this.isDark, required this.accent, required this.border, required this.sub});

  @override
  Widget build(BuildContext context) {
    final months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul'];
    final values = [0.82, 0.87, 0.91, 0.88, 0.93, 0.89, 0.94];
    return CustomPaint(
      painter: _LinePainter(months: months, values: values, accent: accent, border: border, sub: sub, isDark: isDark),
      child: const SizedBox.expand(),
    );
  }
}

class _LinePainter extends CustomPainter {
  final List<String> months;
  final List<double> values;
  final Color accent, border, sub;
  final bool isDark;
  const _LinePainter({required this.months, required this.values, required this.accent, required this.border, required this.sub, required this.isDark});

  @override
  void paint(Canvas canvas, Size size) {
    final n = values.length;
    final pts = List.generate(n, (i) => Offset(i * size.width / (n - 1), size.height * (1 - values[i]) * 0.8));

    // Grid
    for (int i = 0; i <= 4; i++) {
      final y = size.height * 0.8 * i / 4;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), Paint()..color = border.withOpacity(0.4) ..strokeWidth = 1);
    }

    // Fill
    final path = Path()..moveTo(pts.first.dx, pts.first.dy);
    for (int i = 1; i < pts.length; i++) {
      final cp1 = Offset((pts[i - 1].dx + pts[i].dx) / 2, pts[i - 1].dy);
      final cp2 = Offset((pts[i - 1].dx + pts[i].dx) / 2, pts[i].dy);
      path.cubicTo(cp1.dx, cp1.dy, cp2.dx, cp2.dy, pts[i].dx, pts[i].dy);
    }
    path.lineTo(pts.last.dx, size.height);
    path.lineTo(pts.first.dx, size.height);
    path.close();
    canvas.drawPath(path, Paint()..shader = LinearGradient(colors: [accent.withOpacity(0.25), accent.withOpacity(0.0)], begin: Alignment.topCenter, end: Alignment.bottomCenter).createShader(Rect.fromLTWH(0, 0, size.width, size.height)));

    // Line
    final linePath = Path()..moveTo(pts.first.dx, pts.first.dy);
    for (int i = 1; i < pts.length; i++) {
      final cp1 = Offset((pts[i - 1].dx + pts[i].dx) / 2, pts[i - 1].dy);
      final cp2 = Offset((pts[i - 1].dx + pts[i].dx) / 2, pts[i].dy);
      linePath.cubicTo(cp1.dx, cp1.dy, cp2.dx, cp2.dy, pts[i].dx, pts[i].dy);
    }
    canvas.drawPath(linePath, Paint()..color = accent ..strokeWidth = 2.5 ..style = PaintingStyle.stroke ..strokeCap = StrokeCap.round);

    // Dots + labels
    for (int i = 0; i < pts.length; i++) {
      canvas.drawCircle(pts[i], 5, Paint()..color = accent);
      canvas.drawCircle(pts[i], 3, Paint()..color = isDark ? const Color(0xFF1A2236) : Colors.white);

      final tp = TextPainter(
        text: TextSpan(text: months[i], style: TextStyle(color: sub, fontSize: 10)),
        textDirection: TextDirection.ltr,
      )..layout();
      tp.paint(canvas, Offset(pts[i].dx - tp.width / 2, size.height - tp.height));
    }
  }

  @override bool shouldRepaint(covariant CustomPainter o) => true;
}

// ─── Settings Page ────────────────────────────────────────────────────────────

class SettingsPage extends StatelessWidget {
  final bool isDark;
  final VoidCallback onThemeToggle;
  const SettingsPage({super.key, required this.isDark, required this.onThemeToggle});

  Color get _bg     => isDark ? EduCoreTheme.darkBg      : EduCoreTheme.lightBg;
  Color get _card   => isDark ? EduCoreTheme.darkCard     : EduCoreTheme.lightCard;
  Color get _accent => isDark ? EduCoreTheme.darkAccent   : EduCoreTheme.lightAccent;
  Color get _text   => isDark ? EduCoreTheme.darkText     : EduCoreTheme.lightText;
  Color get _sub    => isDark ? EduCoreTheme.darkSubtext  : EduCoreTheme.lightSubtext;
  Color get _border => isDark ? EduCoreTheme.darkBorder   : EduCoreTheme.lightBorder;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      body: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Settings', style: TextStyle(color: _text, fontSize: 22, fontWeight: FontWeight.w700, letterSpacing: -0.5)),
          const SizedBox(height: 24),
          _SettingSection(title: 'Appearance', isDark: isDark, card: _card, border: _border, text: _text, sub: _sub, accent: _accent, children: [
            _SettingRow(
              icon: Icons.dark_mode_rounded, label: 'Dark Mode',
              subtitle: 'Toggle between dark and light theme',
              trailing: _ThemeToggle(isDark: isDark, onToggle: onThemeToggle),
              text: _text, sub: _sub, accent: _accent,
            ),
            _SettingRow(icon: Icons.text_fields_rounded, label: 'Font Size', subtitle: 'Adjust interface text size', trailing: Text('Medium', style: TextStyle(color: _accent, fontWeight: FontWeight.w600, fontSize: 13)), text: _text, sub: _sub, accent: _accent),
          ]),
          const SizedBox(height: 16),
          _SettingSection(title: 'Notifications', isDark: isDark, card: _card, border: _border, text: _text, sub: _sub, accent: _accent, children: [
            _SettingRow(icon: Icons.notifications_active_rounded, label: 'Push Notifications', subtitle: 'Alerts for important events', trailing: Switch(value: true, onChanged: (_) {}, activeColor: _accent), text: _text, sub: _sub, accent: _accent),
            _SettingRow(icon: Icons.email_rounded, label: 'Email Reports', subtitle: 'Weekly performance digest', trailing: Switch(value: false, onChanged: (_) {}, activeColor: _accent), text: _text, sub: _sub, accent: _accent),
          ]),
          const SizedBox(height: 16),
          _SettingSection(title: 'Account', isDark: isDark, card: _card, border: _border, text: _text, sub: _sub, accent: _accent, children: [
            _SettingRow(icon: Icons.lock_rounded, label: 'Change Password', subtitle: 'Update your admin credentials', trailing: Icon(Icons.chevron_right_rounded, color: _sub), text: _text, sub: _sub, accent: _accent),
            _SettingRow(icon: Icons.backup_rounded, label: 'Export Data', subtitle: 'Download all student records', trailing: Icon(Icons.chevron_right_rounded, color: _sub), text: _text, sub: _sub, accent: _accent),
          ]),
        ]),
      ),
    );
  }
}

class _SettingSection extends StatelessWidget {
  final String title;
  final bool isDark;
  final Color card, border, text, sub, accent;
  final List<Widget> children;
  const _SettingSection({required this.title, required this.isDark, required this.card, required this.border, required this.text, required this.sub, required this.accent, required this.children});
  @override
  Widget build(BuildContext context) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Text(title, style: TextStyle(color: sub, fontSize: 11, fontWeight: FontWeight.w700, letterSpacing: 1)),
    const SizedBox(height: 8),
    Container(
      decoration: BoxDecoration(color: card, borderRadius: BorderRadius.circular(16), border: Border.all(color: border)),
      child: Column(children: children.asMap().entries.map((e) {
        return Column(children: [
          e.value,
          if (e.key < children.length - 1) Divider(height: 1, color: border, indent: 52),
        ]);
      }).toList()),
    ),
  ]);
}

class _SettingRow extends StatelessWidget {
  final IconData icon;
  final String label, subtitle;
  final Widget trailing;
  final Color text, sub, accent;
  const _SettingRow({required this.icon, required this.label, required this.subtitle, required this.trailing, required this.text, required this.sub, required this.accent});
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    child: Row(children: [
      Container(width: 36, height: 36, decoration: BoxDecoration(color: accent.withOpacity(0.1), borderRadius: BorderRadius.circular(9)),
          child: Icon(icon, color: accent, size: 18)),
      const SizedBox(width: 14),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(label, style: TextStyle(color: text, fontSize: 13, fontWeight: FontWeight.w600)),
        Text(subtitle, style: TextStyle(color: sub, fontSize: 11)),
      ])),
      trailing,
    ]),
  );
}