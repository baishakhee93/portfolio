import 'dart:math';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
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
  final GlobalKey _heroKey = GlobalKey();
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _skillsKey = GlobalKey();
  final GlobalKey _experienceKey = GlobalKey();
  final GlobalKey _projectsKey = GlobalKey();
  final GlobalKey _achievementsKey = GlobalKey();
  final GlobalKey _educationKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  AnimationController? _bubbleController;

  @override
  void initState() {
    super.initState();
    _bubbleController = AnimationController(
      duration: const Duration(seconds: 25),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _bubbleController?.dispose();
    _scrollController.dispose();
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

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: _buildNavBar(isDesktop),
      ),
      body: Stack(
        children: [
          _buildBackground(size),
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
                    const SizedBox(height: 100),
                    _buildAboutMeSection(vm, isDesktop, key: _aboutKey),
                    const SizedBox(height: 100),
                    _buildSkillsSection(vm, isDesktop, key: _skillsKey),
                    const SizedBox(height: 100),
                    _buildExperienceSection(vm, isDesktop, key: _experienceKey),
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
                    _buildFooter(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackground(Size size) {
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
                  onPressed: () {},
                ),
            ],
          ),
        ),
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
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    vm.name,
                    style: TextStyle(
                      fontSize: isDesktop ? 64 : 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    vm.title,
                    style: const TextStyle(
                      fontSize: 32,
                      color: Colors.white70,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    vm.shortIntro,
                    textAlign: isDesktop ? TextAlign.left : TextAlign.center,
                    style: const TextStyle(
                      fontSize: 16,
                      height: 1.5,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: isDesktop
                        ? MainAxisAlignment.start
                        : MainAxisAlignment.center,
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
            mainAxisExtent: isDesktop ? 300 : null,
          ),
          itemCount: vm.projects.length,
          itemBuilder: (context, index) =>
              _buildProjectCard(vm.projects[index], isDesktop),
        ),
      ],
    );
  }

  Widget _buildProjectCard(project, bool isDesktop) => GlassContainer(
    height: isDesktop ? 300 : null,
    child: Padding(
      padding: const EdgeInsets.all(25.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: isDesktop ? MainAxisSize.max : MainAxisSize.min,
        children: [
          FaIcon(FontAwesomeIcons.folder, color: Colors.white, size: 30),
          const SizedBox(height: 20),
          Text(
            project.title,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: Text(
              project.description,
              style: const TextStyle(
                fontSize: 15,
                color: Colors.white,
                height: 1.5,
                fontWeight: FontWeight.w300,
              ),
              overflow: TextOverflow.fade,
            ),
          ),
          const SizedBox(height: 20),
          Wrap(
            spacing: 10,
            runSpacing: 8,
            children: project.techStack
                .map<Widget>(
                  (tech) => Text(
                    tech,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    ),
  );

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
            mainAxisExtent: isDesktop ? 300 : null,
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FaIcon(FontAwesomeIcons.github, size: 50, color: Colors.white),
          SizedBox(width: 30),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Visit my Open Source Garden",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
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
            Expanded(child: _buildContactForm()),
          ],
        ),
      ],
    );
  }

  Widget _buildContactMethod(dynamic icon, String text, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          if (icon is IconData)
            Icon(icon, color: Colors.tealAccent, size: 20)
          else
            FaIcon(icon, color: Colors.tealAccent, size: 20),
          const SizedBox(width: 15),
          Text(
            text,
            style: const TextStyle(color: Colors.white70, fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget _buildContactForm() {
    return GlassContainer(
      height: null,
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
                  child: _buildInputField("Your name *", "Enter your name"),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: _buildInputField("Your e-mail *", "Email Address"),
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
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Checkbox(
                  value: false,
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
                onPressed: () {},
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

  Widget _buildInputField(String label, String hint, {bool isLarge = false}) {
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

  Widget _buildFooter() => Column(
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
          FaIcon(FontAwesomeIcons.github, size: 16, color: Colors.white70),
          const SizedBox(width: 20),
          FaIcon(FontAwesomeIcons.linkedin, size: 16, color: Colors.white70),
          const SizedBox(width: 20),
          FaIcon(FontAwesomeIcons.twitter, size: 16, color: Colors.white70),
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
