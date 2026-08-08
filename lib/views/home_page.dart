import 'dart:math';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/project_model.dart';
import '../view_models/portfolio_view_model.dart';
import '../widgets/glass_container.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey _heroKey = GlobalKey();
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _skillsKey = GlobalKey();
  final GlobalKey _experienceKey = GlobalKey();
  final GlobalKey _projectsKey = GlobalKey();
  final GlobalKey _achievementsKey = GlobalKey();
  final GlobalKey _educationKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  AnimationController? _bubbleController;
  bool _showBackToTop = false;
  Offset? _mousePos;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  Future<void> _sendEmail(String recipientEmail) async {
    final String name = _nameController.text.trim();
    final String email = _emailController.text.trim();
    final String message = _messageController.text.trim();

    if (name.isEmpty || email.isEmpty || message.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill in all required fields")),
      );
      return;
    }

    // --- EMAILJS CONFIGURATION ---
    // TODO: Replace these with your actual keys from EmailJS
    const String serviceId = 'service_xn74yg4';
    const String templateId = 'template_hn56pro';
    const String publicKey = 'fT-o2O7tghORxtwJ7';

    final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');

    // Show loading indicator
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Sending message...")));

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'service_id': serviceId,
          'template_id': templateId,
          'user_id': publicKey,
          'template_params': {
            'from_name': name,
            'from_email': email,
            'message': message,
          },
        }),
      );

      if (response.statusCode == 200) {
        _nameController.clear();
        _emailController.clear();
        _messageController.clear();

        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Message sent successfully!"),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        // This will show the specific error from EmailJS (e.g. "The user_id is invalid")
        throw 'Failed: ${response.body}';
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e"), backgroundColor: Colors.red),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _bubbleController = AnimationController(
      duration: const Duration(seconds: 25),
      vsync: this,
    )..repeat();

    _scrollController.addListener(() {
      setState(() {
        _showBackToTop = _scrollController.offset > 300;
      });
    });
  }

  @override
  void dispose() {
    _bubbleController?.dispose();
    _scrollController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _scrollTo(GlobalKey key) {
    Scrollable.ensureVisible(
      key.currentContext!,
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<PortfolioViewModel>(context);
    final size = MediaQuery.of(context).size;
    final bool isDesktop = size.width > 900;

    return MouseRegion(
      onHover: (event) {
        setState(() {
          _mousePos = event.localPosition;
        });
      },
      child: Scaffold(
        key: _scaffoldKey,
        extendBodyBehindAppBar: true,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(70),
          child: _buildNavBar(isDesktop),
        ),
        drawer: !isDesktop ? _buildDrawer() : null,
        floatingActionButton: _showBackToTop
            ? FloatingActionButton(
                onPressed: () {
                  _scrollController.animateTo(
                    0,
                    duration: const Duration(milliseconds: 1000),
                    curve: Curves.fastOutSlowIn,
                  );
                },
                backgroundColor: Colors.white.withOpacity(0.2),
                elevation: 0,
                child: const Icon(Icons.arrow_upward, color: Colors.white),
              )
            : null,
        body: Stack(
          children: [
            _buildBackground(size, isDesktop),
            Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: isDesktop ? 1200 : double.infinity,
                ),
                child: SingleChildScrollView(
                  controller: _scrollController,
                  padding: EdgeInsets.symmetric(
                    horizontal: isDesktop ? 20 : 15,
                    vertical: 100,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildHeroSection(vm, isDesktop, key: _heroKey),
                      const SizedBox(height: 50),
                      _buildStatsSection(vm, isDesktop),
                      const SizedBox(height: 100),
                      _buildAboutMeSection(vm, isDesktop, key: _aboutKey),
                      const SizedBox(height: 100),
                      _buildSkillsSection(vm, isDesktop, key: _skillsKey),
                      const SizedBox(height: 100),
                      _buildExperienceSection(
                        vm,
                        isDesktop,
                        key: _experienceKey,
                      ),
                      const SizedBox(height: 100),
                      _buildProjectsSection(vm, isDesktop, key: _projectsKey),
                      const SizedBox(height: 100),
                      _buildAchievementsSection(
                        vm,
                        isDesktop,
                        key: _achievementsKey,
                      ),
                      const SizedBox(height: 100),
                      _buildEducationSection(vm, isDesktop, key: _educationKey),
                      const SizedBox(height: 100),
                      _buildGitHubSection(vm),
                      const SizedBox(height: 100),
                      _buildContactSection(vm, isDesktop, key: _contactKey),
                      const SizedBox(height: 60),
                      _buildFooter(vm),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBackground(Size size, bool isDesktop) {
    return Container(
      width: size.width,
      height: size.height,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xff57054e), Color(0xff67135e), Color(0xffa53298)],
        ),
      ),
      child: Stack(
        children: [
          if (isDesktop && _mousePos != null)
            Positioned(
              left: _mousePos!.dx - 150,
              top: _mousePos!.dy - 150,
              child: Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      Colors.white.withOpacity(0.08),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
          if (_bubbleController != null)
            AnimatedBuilder(
              animation: _bubbleController!,
              builder: (context, child) {
                return Stack(
                  children: [
                    _buildBubble(
                      size,
                      0.1,
                      0.2,
                      140,
                      Colors.tealAccent.withOpacity(0.3),
                      1.2,
                    ),
                    _buildBubble(
                      size,
                      0.8,
                      0.1,
                      160,
                      Colors.pinkAccent.withOpacity(0.25),
                      0.8,
                    ),
                    _buildBubble(
                      size,
                      0.5,
                      0.8,
                      220,
                      Colors.purpleAccent.withOpacity(0.3),
                      1.5,
                    ),
                    _buildBubble(
                      size,
                      0.9,
                      0.7,
                      130,
                      Colors.orangeAccent.withOpacity(0.2),
                      1.0,
                    ),
                    _buildBubble(
                      size,
                      0.2,
                      0.9,
                      170,
                      Colors.blueAccent.withOpacity(0.25),
                      1.3,
                    ),
                    _buildBubble(
                      size,
                      0.7,
                      0.4,
                      110,
                      Colors.yellowAccent.withOpacity(0.2),
                      0.9,
                    ),
                    _buildBubble(
                      size,
                      0.3,
                      0.5,
                      150,
                      Colors.indigoAccent.withOpacity(0.2),
                      1.1,
                    ),
                  ],
                );
              },
            ),
        ],
      ),
    );
  }

  Widget _buildBubble(
    Size size,
    double x,
    double y,
    double radius,
    Color color,
    double speedFactor,
  ) {
    if (_bubbleController == null) return const SizedBox.shrink();
    final double time = _bubbleController!.value * 2 * pi;
    final offset = Offset(
      size.width * x + sin(time * speedFactor) * 70,
      size.height * y + cos(time * speedFactor * 0.7) * 70,
    );
    return Positioned(
      left: offset.dx - radius,
      top: offset.dy - radius,
      child: Container(
        width: radius * 2,
        height: radius * 2,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [color, color.withOpacity(0)],
            stops: const [0.6, 1.0],
          ),
        ),
      ),
    );
  }

  Widget _buildNavBar(bool isDesktop) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: GlassContainer(
        height: 60,
        width: double.infinity,
        borderRadius: 30,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              const Text(
                "BAISHAKHEE",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                  color: Colors.white,
                ),
              ),
              const Spacer(),
              if (isDesktop)
                Row(
                  children: [
                    _navItem("Introduction", () => _scrollTo(_heroKey)),
                    _navItem("About", () => _scrollTo(_aboutKey)),
                    _navItem("Skills", () => _scrollTo(_skillsKey)),
                    _navItem("Experience", () => _scrollTo(_experienceKey)),
                    _navItem("Projects", () => _scrollTo(_projectsKey)),
                    _navItem("Education", () => _scrollTo(_educationKey)),
                    _navItem("Contact", () => _scrollTo(_contactKey)),
                  ],
                )
              else
                IconButton(
                  icon: const Icon(Icons.menu, color: Colors.white),
                  onPressed: () {
                    _scaffoldKey.currentState?.openDrawer();
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      backgroundColor: const Color(0xff57054e).withOpacity(0.9),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: Colors.transparent),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "BAISHAKHEE",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),
                Container(width: 50, height: 2, color: Colors.white),
              ],
            ),
          ),
          _drawerItem("Introduction", () {
            Navigator.pop(context);
            _scrollTo(_heroKey);
          }),
          _drawerItem("About", () {
            Navigator.pop(context);
            _scrollTo(_aboutKey);
          }),
          _drawerItem("Skills", () {
            Navigator.pop(context);
            _scrollTo(_skillsKey);
          }),
          _drawerItem("Experience", () {
            Navigator.pop(context);
            _scrollTo(_experienceKey);
          }),
          _drawerItem("Projects", () {
            Navigator.pop(context);
            _scrollTo(_projectsKey);
          }),
          _drawerItem("Education", () {
            Navigator.pop(context);
            _scrollTo(_educationKey);
          }),
          _drawerItem("Contact", () {
            Navigator.pop(context);
            _scrollTo(_contactKey);
          }),
        ],
      ),
    );
  }

  Widget _drawerItem(String title, VoidCallback onTap) => ListTile(
    title: Text(
      title,
      style: const TextStyle(color: Colors.white, fontSize: 16),
    ),
    onTap: onTap,
  );

  Widget _buildStatsSection(PortfolioViewModel vm, bool isDesktop) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Wrap(
        spacing: 20,
        runSpacing: 20,
        alignment: WrapAlignment.center,
        children: vm.stats.map((stat) {
          return GlassContainer(
            width: isDesktop ? 250 : null,
            height:
                220, // Increased further to accommodate wrapping text safely
            borderRadius: 15,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    stat["value"],
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    stat["label"],
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white70,
                      height: 1.4, // Better line height for wrapped text
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _navItem(String title, VoidCallback onTap) => TextButton(
    onPressed: onTap,
    child: Text(
      title,
      style: const TextStyle(color: Colors.white, fontSize: 14),
    ),
  );

  Widget _buildHeroSection(PortfolioViewModel vm, bool isDesktop, {Key? key}) {
    return Column(
      key: key,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: isDesktop
                    ? CrossAxisAlignment.start
                    : CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Hello, I'm",
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    vm.name,
                    style: TextStyle(
                      fontSize: isDesktop ? 70 : 45,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      height: 1.1,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    vm.title,
                    textAlign: isDesktop ? TextAlign.left : TextAlign.center,
                    style: TextStyle(
                      fontSize: isDesktop ? 22 : 18,
                      color: Colors.tealAccent,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Text(
                    vm.shortIntro,
                    textAlign: isDesktop ? TextAlign.left : TextAlign.center,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      height: 1.6,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  const SizedBox(height: 40),
                  Wrap(
                    spacing: 20,
                    runSpacing: 20,
                    alignment: isDesktop
                        ? WrapAlignment.start
                        : WrapAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () => _scrollTo(_contactKey),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white.withOpacity(0.9),
                          foregroundColor: const Color(0xFF36d1dc),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 30,
                            vertical: 20,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        child: const Text(
                          "Hire Me",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(width: 20),
                      OutlinedButton(
                        onPressed: () => vm.downloadResume(),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 30,
                            vertical: 20,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          side: const BorderSide(color: Colors.white, width: 2),
                        ),
                        child: const Text(
                          "Download CV",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            if (isDesktop) Expanded(child: Center(child: _buildIDEScreen())),
          ],
        ),
      ],
    );
  }

  Widget _buildIDEScreen() {
    return GlassContainer(
      width: 500,
      height: 350,
      borderRadius: 12,
      child: Column(
        children: [
          Container(
            height: 30,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.2),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Row(
              children: [
                Row(
                  children: [
                    _buildDot(Colors.red),
                    const SizedBox(width: 6),
                    _buildDot(Colors.orange),
                    const SizedBox(width: 6),
                    _buildDot(Colors.green),
                  ],
                ),
                const SizedBox(width: 20),
                Container(
                  height: 20,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Center(
                    child: Text(
                      "main.dart",
                      style: TextStyle(color: Colors.white70, fontSize: 10),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Container(
                  width: 100,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    border: Border(
                      right: BorderSide(color: Colors.white.withOpacity(0.05)),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(
                      8,
                      (index) => Container(
                        height: 4,
                        width: 30 + (index % 3) * 15.0,
                        margin: const EdgeInsets.only(bottom: 12),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildCodeLine(60, const Color(0xFF64ffda)),
                        _buildCodeLine(120, const Color(0xFF48cae4), indent: 1),
                        _buildCodeLine(90, const Color(0xFFcaf0f8), indent: 2),
                        _buildCodeLine(150, const Color(0xFF90e0ef), indent: 2),
                        _buildCodeLine(100, const Color(0xFF00b4d8), indent: 2),
                        _buildCodeLine(40, const Color(0xFF64ffda), indent: 1),
                        _buildCodeLine(80, const Color(0xFF64ffda)),
                        _buildCodeLine(110, const Color(0xFF48cae4), indent: 1),
                        _buildCodeLine(130, const Color(0xFFcaf0f8), indent: 2),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDot(Color color) => Container(
    width: 10,
    height: 10,
    decoration: BoxDecoration(
      color: color.withOpacity(0.7),
      shape: BoxShape.circle,
    ),
  );
  Widget _buildCodeLine(double width, Color color, {int indent = 0}) =>
      Container(
        height: 6,
        width: width,
        margin: EdgeInsets.only(bottom: 14, left: indent * 20.0),
        decoration: BoxDecoration(
          color: color.withOpacity(0.4),
          borderRadius: BorderRadius.circular(3),
        ),
      );

  Widget _buildAboutMeSection(
    PortfolioViewModel vm,
    bool isDesktop, {
    Key? key,
  }) => Column(
    key: key,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      const Text(
        "About Me",
        style: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      const SizedBox(height: 8),
      Container(
        width: 80,
        height: 4,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(2),
        ),
      ),
      const SizedBox(height: 30),
      ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: isDesktop ? 1000 : double.infinity,
        ),
        child: GlassContainer(
          height: null,
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(40.0),
            child: Text(
              vm.aboutMe,
              style: const TextStyle(
                fontSize: 18,
                height: 1.8,
                color: Colors.white,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
      ),
    ],
  );

  Widget _buildSkillsSection(
    PortfolioViewModel vm,
    bool isDesktop, {
    Key? key,
  }) {
    return Column(
      key: key,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          "Skills & Technologies",
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: 80,
          height: 4,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(height: 50),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: isDesktop ? 3 : 1,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
            mainAxisExtent: isDesktop ? 350 : null,
          ),
          itemCount: vm.skillsCategory.length,
          itemBuilder: (context, index) =>
              _buildSkillCard(vm.skillsCategory[index], isDesktop),
        ),
      ],
    );
  }

  Widget _buildSkillCard(SkillCategory category, bool isDesktop) {
    return GlassContainer(
      height: isDesktop ? 350 : null,
      width: double.infinity,
      borderRadius: 15,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: isDesktop ? MainAxisSize.max : MainAxisSize.min,
          children: [
            Row(
              children: [
                Icon(category.icon, color: Colors.white, size: 24),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    category.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            if (isDesktop)
              Expanded(
                child: SingleChildScrollView(
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: category.skills
                        .map<Widget>((skill) => _buildSkillItemTag(skill))
                        .toList(),
                  ),
                ),
              )
            else
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: category.skills
                    .map<Widget>((skill) => _buildSkillItemTag(skill))
                    .toList(),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildSkillItemTag(String skill) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    decoration: BoxDecoration(
      color: Colors.white.withOpacity(0.15),
      borderRadius: BorderRadius.circular(5),
      border: Border.all(color: Colors.white.withOpacity(0.2)),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          skill,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    ),
  );

  Widget _buildExperienceSection(
    PortfolioViewModel vm,
    bool isDesktop, {
    Key? key,
  }) {
    return Column(
      key: key,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          "Professional Experience",
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: 80,
          height: 4,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(height: 30),
        ...vm.experiences.map(
          (exp) => Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: GlassContainer(
              height: null,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            exp.role,
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Text(
                          exp.period,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      exp.company,
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.tealAccent,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 15),
                    ...exp.description.map(
                      (desc) => Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "• ",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                desc,
                                style: const TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProjectsSection(
    PortfolioViewModel vm,
    bool isDesktop, {
    Key? key,
  }) {
    return Column(
      key: key,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          "Projects",
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: 80,
          height: 4,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(height: 30),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: isDesktop ? 2 : 1,
            crossAxisSpacing: 30,
            mainAxisSpacing: 30,
            mainAxisExtent: isDesktop ? 650 : null,
          ),
          itemCount: vm.projects.length,
          itemBuilder: (context, index) =>
              ProjectCard(project: vm.projects[index], isDesktop: isDesktop),
        ),
      ],
    );
  }

  Widget _buildAchievementsSection(
    PortfolioViewModel vm,
    bool isDesktop, {
    Key? key,
  }) {
    return Column(
      key: key,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          "Achievements",
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: 80,
          height: 4,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(height: 30),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: isDesktop ? 3 : 1,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
            mainAxisExtent: isDesktop ? 400 : null,
          ),
          itemCount: vm.achievements.length,
          itemBuilder: (context, index) =>
              _buildAchievementCard(vm.achievements[index], isDesktop),
        ),
      ],
    );
  }

  Widget _buildAchievementCard(achievement, bool isDesktop) {
    return GlassContainer(
      height: isDesktop ? 300 : null,
      width: double.infinity,
      borderRadius: 15,
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.emoji_events, color: Colors.amberAccent, size: 30),
            const SizedBox(height: 15),
            Text(
              achievement.title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Text(
                achievement.description,
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.white70,
                  height: 1.5,
                ),
                overflow: TextOverflow.fade,
              ),
            ),
            const SizedBox(height: 15),
            Text(
              achievement.date,
              style: const TextStyle(
                fontSize: 13,
                color: Colors.tealAccent,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEducationSection(
    PortfolioViewModel vm,
    bool isDesktop, {
    Key? key,
  }) {
    return Column(
      key: key,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          "Education",
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: 80,
          height: 4,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(height: 30),
        ...vm.educationList.map(
          (edu) => Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: GlassContainer(
              height: null,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            edu["degree"]!,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Text(
                          edu["duration"]!,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      edu["university"]!,
                      style: const TextStyle(
                        fontSize: 17,
                        color: Colors.tealAccent,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Score: ${edu["score"]!}",
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGitHubSection(PortfolioViewModel vm) => InkWell(
    onTap: () => _launchURL(vm.githubUrl),
    child: GlassContainer(
      height: 150,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const FaIcon(FontAwesomeIcons.github, size: 50, color: Colors.white),
          const SizedBox(width: 30),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Visit my Open Source Garden",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const Text(
                "See more projects and contributions",
                style: TextStyle(fontSize: 14, color: Colors.white70),
              ),
            ],
          ),
        ],
      ),
    ),
  );

  Widget _buildContactSection(
    PortfolioViewModel vm,
    bool isDesktop, {
    Key? key,
  }) {
    return Column(
      key: key,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          "What's Next?",
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: 80,
          height: 4,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(height: 30),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isDesktop)
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Get In Touch",
                      style: TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "I'm currently looking for new opportunities. Whether you have a question or just want to say hi, I'll try my best to get back to you!",
                      style: TextStyle(
                        fontSize: 16,
                        height: 1.6,
                        color: Colors.white,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    const SizedBox(height: 40),
                    _buildContactMethod(
                      Icons.location_on,
                      "Location: ${vm.location}",
                      null,
                    ),
                    const SizedBox(height: 15),
                    _buildContactMethod(
                      Icons.work,
                      "Availability: ${vm.availability}",
                      null,
                    ),
                    const SizedBox(height: 15),
                    _buildContactMethod(
                      Icons.timer,
                      "Notice Period: ${vm.noticePeriod}",
                      null,
                    ),
                    const SizedBox(height: 15),
                    _buildContactMethod(
                      Icons.home_work,
                      "Preference: ${vm.workPreference}",
                      null,
                    ),
                    const SizedBox(height: 30),
                    const Divider(color: Colors.white24),
                    const SizedBox(height: 30),
                    _buildContactMethod(
                      Icons.email,
                      vm.email,
                      () => _launchURL("mailto:${vm.email}"),
                    ),
                    const SizedBox(height: 20),
                    _buildContactMethod(
                      FontAwesomeIcons.linkedin,
                      "LinkedIn Profile",
                      () => _launchURL(vm.linkedInUrl),
                    ),
                    const SizedBox(height: 20),
                    _buildContactMethod(
                      FontAwesomeIcons.github,
                      "GitHub Profile",
                      () => _launchURL(vm.githubUrl),
                    ),
                  ],
                ),
              ),
            if (isDesktop) const SizedBox(width: 60),
            Expanded(child: _buildContactForm(vm)),
          ],
        ),
      ],
    );
  }

  Widget _buildContactMethod(dynamic icon, String text, VoidCallback? onTap) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          if (icon is IconData)
            Icon(icon, color: Colors.tealAccent, size: 20)
          else
            FaIcon(icon, color: Colors.tealAccent, size: 20),
          const SizedBox(width: 15),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactForm(PortfolioViewModel vm) {
    return GlassContainer(
      height: null,
      width: double.infinity,
      borderRadius: 20,
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Connect ",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 30),
            Row(
              children: [
                Expanded(
                  child: _buildInputField(
                    "Your name *",
                    "Enter your name",
                    controller: _nameController,
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: _buildInputField(
                    "Your e-mail *",
                    "Email Address",
                    controller: _emailController,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              "Your attachments",
              style: TextStyle(color: Colors.white70, fontSize: 14),
            ),
            const SizedBox(height: 8),
            const Text(
              "We work in accordance with the latest standards...",
              style: TextStyle(color: Colors.white38, fontSize: 12),
            ),
            const SizedBox(height: 15),
            _buildUploadPlaceholder(),
            const SizedBox(height: 25),
            _buildInputField(
              "Your message *",
              "Your message description",
              isLarge: true,
              controller: _messageController,
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Checkbox(
                  value: true,
                  onChanged: (v) {},
                  side: const BorderSide(color: Colors.white38),
                ),
                const Expanded(
                  child: Text(
                    "I accept processing to take place in accordance with notice and the privacy policy.",
                    style: TextStyle(color: Colors.white38, fontSize: 12),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                onPressed: () => _sendEmail(vm.email),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white.withOpacity(0.1),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 50,
                    vertical: 20,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                    side: const BorderSide(color: Colors.white12),
                  ),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Send message",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 10),
                    Icon(Icons.arrow_forward, size: 18),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField(
    String label,
    String hint, {
    bool isLarge = false,
    TextEditingController? controller,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          height: isLarge ? 120 : 50,
          padding: const EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.2),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.white10),
          ),
          child: TextField(
            controller: controller,
            maxLines: isLarge ? 5 : 1,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hint,
              hintStyle: const TextStyle(color: Colors.white24, fontSize: 14),
            ),
            style: const TextStyle(color: Colors.white, fontSize: 14),
          ),
        ),
      ],
    );
  }

  Widget _buildUploadPlaceholder() => Container(
    width: double.infinity,
    height: 50,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Colors.white10),
    ),
    child: const Center(
      child: Text(
        "Click here to upload attachment",
        style: TextStyle(color: Colors.white38, fontSize: 14),
      ),
    ),
  );

  Widget _buildFooter(PortfolioViewModel vm) => Column(
    children: [
      const Divider(color: Colors.white24),
      const SizedBox(height: 20),
      const Text(
        "Designed & Built by BAISHAKHEE",
        style: TextStyle(color: Colors.white70, fontSize: 12),
      ),
      const SizedBox(height: 10),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () => _launchURL(vm.githubUrl),
            icon: const FaIcon(
              FontAwesomeIcons.github,
              size: 16,
              color: Colors.white70,
            ),
          ),
          const SizedBox(width: 10),
          IconButton(
            onPressed: () => _launchURL(vm.linkedInUrl),
            icon: const FaIcon(
              FontAwesomeIcons.linkedin,
              size: 16,
              color: Colors.white70,
            ),
          ),
          const SizedBox(width: 10),
          IconButton(
            onPressed: () => _launchURL("mailto:${vm.email}"),
            icon: const Icon(Icons.email, size: 16, color: Colors.white70),
          ),
        ],
      ),
    ],
  );

  void _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      debugPrint('Could not launch $url');
    }
  }
}

class ProjectCard extends StatefulWidget {
  final ProjectModel project;
  final bool isDesktop;

  const ProjectCard({
    super.key,
    required this.project,
    required this.isDesktop,
  });

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedScale(
        scale: _isHovered ? 1.02 : 1.0,
        duration: const Duration(milliseconds: 200),
        child: GlassContainer(
          height: null,
          width: double.infinity,
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const FaIcon(
                          FontAwesomeIcons.folderOpen,
                          color: Colors.tealAccent,
                          size: 35,
                        ),
                        if (widget.project.githubUrl != null)
                          IconButton(
                            icon: const FaIcon(
                              FontAwesomeIcons.github,
                              color: Colors.white70,
                              size: 20,
                            ),
                            onPressed: () =>
                                _launchURL(widget.project.githubUrl!),
                          ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Text(
                      widget.project.title,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    if (widget.project.role != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Text(
                          widget.project.role!,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.tealAccent,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    const SizedBox(height: 15),
                    Text(
                      widget.project.description,
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        height: 1.6,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    if (widget.project.features != null) ...[
                      const SizedBox(height: 20),
                      const Text(
                        "Key Features:",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white70,
                        ),
                      ),
                      const SizedBox(height: 10),
                      ...widget.project.features!.map(
                        (feature) => Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "▹ ",
                                style: TextStyle(color: Colors.tealAccent),
                              ),
                              Expanded(
                                child: Text(
                                  feature,
                                  style: const TextStyle(
                                    fontSize: 13,
                                    color: Colors.white70,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                    if (widget.project.result != null) ...[
                      const SizedBox(height: 20),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.star,
                              color: Colors.amberAccent,
                              size: 16,
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                widget.project.result!,
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: Colors.white,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                    const SizedBox(height: 25),
                    Wrap(
                      spacing: 10,
                      runSpacing: 8,
                      children: widget.project.techStack
                          .map<Widget>(
                            (tech) => Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 5,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.tealAccent.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                  color: Colors.tealAccent.withOpacity(0.3),
                                ),
                              ),
                              child: Text(
                                tech,
                                style: const TextStyle(
                                  fontSize: 11,
                                  color: Colors.tealAccent,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ],
                ),
              ),
              if (widget.project.isFeatured == true)
                Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: const BoxDecoration(
                      color: Colors.tealAccent,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(12),
                        bottomLeft: Radius.circular(12),
                      ),
                    ),
                    child: const Text(
                      "FEATURED",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      debugPrint('Could not launch $url');
    }
  }
}

class GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.05)
      ..strokeWidth = 1;
    const spacing = 40.0;
    for (double i = 0; i < size.width; i += spacing) {
      canvas.drawLine(Offset(i, 0), Offset(i, size.height), paint);
    }
    for (double i = 0; i < size.height; i += spacing) {
      canvas.drawLine(Offset(0, i), Offset(size.width, i), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
