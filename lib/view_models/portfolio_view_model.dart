import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/achievement_model.dart';
import '../models/experience_model.dart';
import '../models/project_model.dart';

class SkillItem {
  final String name;
  final IconData icon;

  SkillItem({required this.name, required this.icon});
}

class SkillCategory {
  final String title;
  final IconData icon;
  final List<String> skills;

  SkillCategory({
    required this.title,
    required this.icon,
    required this.skills,
  });
}

class PortfolioViewModel extends ChangeNotifier {
  final String name = "BAISHAKHEE";
  final String title = "Software Developer | Android & Flutter Developer";

  final String shortIntro =
      "I am a Software Developer with 6+ years of experience in building high-performance mobile and cross-platform applications. I specialize in Android and Flutter development with strong expertise in multimedia systems, IoT device integration, and Android TV/Box solutions.\n\n"
      "✔ 6+ Years Mobile Application Development\n"
      "✔ Android, Flutter & Windows Desktop Applications\n"
      "✔ IoT Sensors, Camera & Hardware Integration\n"
      "✔ Video Wall, Media Streaming & Campaign Systems\n"
      "✔ REST API, Real-time Messaging & Payment Integration";
  final String aboutMe =
      "I am a passionate Software Developer with over 6 years of experience in Android and cross-platform application development. I have strong expertise in building scalable and high-performance applications using Flutter, Kotlin, and Java.\n\n"
      "My development experience includes Android mobile applications, Android TV systems, tablet applications, and Windows desktop applications using Flutter. I have worked extensively on multimedia applications involving video streaming, audio processing, image handling, and campaign-based media broadcasting systems.\n\n"
      "I also have experience integrating IoT devices and hardware components such as GPS, camera modules, Bluetooth printers, barcode scanners, and payment devices. My projects include real-time communication systems using MQTT, HDMI-based video wall systems, and camera-based detection solutions.\n\n"
      "I follow modern software architecture patterns like MVVM, MVP, and Clean Architecture while ensuring secure development practices including encryption, authentication, and API security. I enjoy solving complex problems, optimizing application performance, and building reliable production-ready software.\n\n"
      "I am always eager to learn new technologies and continuously improve my skills to build innovative and impactful applications.";

  final List<SkillCategory> skillsCategory = [
    SkillCategory(
      title: "Programming Languages",
      icon: Icons.code,
      skills: ["Dart", "Kotlin", "Java", "C++", "Python", "JavaScript", "SQL"],
    ),

    SkillCategory(
      title: "Mobile App Development",
      icon: Icons.phone_android,
      skills: [
        "Flutter",
        "Android SDK",
        "Kotlin",
        "Java",
        "Android NDK",
        "Jetpack Components",
        "Jetpack Compose",
        "Android TV Development",
        "Tablet Applications",
      ],
    ),

    SkillCategory(
      title: "Desktop App Development",
      icon: Icons.desktop_windows,
      skills: [
        "Flutter Windows",
        "Windows Desktop Applications",
        "Native Windows Integration",
        "Multi-Camera Handling",
        "Hardware Device Integration",
      ],
    ),

    SkillCategory(
      title: "Web Development",
      icon: Icons.web,
      skills: [
        "Flutter Web",
        "HTML5",
        "CSS3",
        "JavaScript",
        "Responsive UI Design",
      ],
    ),

    SkillCategory(
      title: "State Management",
      icon: Icons.layers,
      skills: ["setState", "Provider", "Riverpod", "GetX", "Bloc"],
    ),

    SkillCategory(
      title: "Architecture & Design Patterns",
      icon: Icons.account_tree,
      skills: [
        "MVVM Architecture",
        "MVP Architecture",
        "Clean Architecture",
        "Repository Pattern",
        "Dependency Injection",
        "Modular App Design",
      ],
    ),

    SkillCategory(
      title: "Backend Integration",
      icon: Icons.cloud_sync,
      skills: [
        "REST API Integration",
        "JSON Parsing",
        "Dio",
        "Retrofit",
        "Volley",
        "OkHttp",
        "Firebase",
        "WebSocket",
        "MQTT",
      ],
    ),

    SkillCategory(
      title: "Media & Graphics",
      icon: Icons.play_circle_outline,
      skills: [
        "ExoPlayer",
        "VideoView",
        "Audio Playback",
        "CameraX",
        "MediaCodec",
        "OpenCV",
        "ML Kit Pose Detection",
        "Image Processing",
        "Video Streaming",
        "Digital Signage Systems",
        "Video Wall Systems",
      ],
    ),

    SkillCategory(
      title: "IoT & Hardware Integration",
      icon: Icons.memory,
      skills: [
        "USB Device Communication",
        "Serial Communication",
        "Sensor Data Processing",
        "Proximity Sensors",
        "Camera Device Detection",
        "Android TV / Android Box Hardware",
        "Bluetooth Devices",
        "Barcode Scanner Integration",
        "Thermal Printer Integration",
      ],
    ),

    SkillCategory(
      title: "Database",
      icon: Icons.storage,
      skills: [
        "SQLite",
        "Room Database",
        "Hive",
        "SharedPreferences",
        "Firebase Firestore",
        "Local Storage Management",
      ],
    ),

    SkillCategory(
      title: "Tools & Platforms",
      icon: Icons.build_outlined,
      skills: [
        "Android Studio",
        "VS Code",
        "Git",
        "GitHub",
        "Postman",
        "Firebase Console",
        "Figma",
        "Jira",
        "Agile / Scrum",
      ],
    ),

    SkillCategory(
      title: "Testing",
      icon: Icons.bug_report,
      skills: [
        "JUnit",
        "Mockito",
        "Espresso",
        "Unit Testing",
        "Integration Testing",
      ],
    ),
  ];
  final List<ProjectModel> projects = [
    ProjectModel(
      title: "Flutter Campaign Media Player",
      description:
          "A high-performance media player for digital signage campaigns with scheduling and remote management.",
      techStack: ["Flutter", "ExoPlayer", "REST API", "Hive"],
    ),
    ProjectModel(
      title: "Android TV Device Detection",
      description:
          "Network-based system to detect, monitor, and manage Android TV/Box devices remotely.",
      techStack: ["Android", "Kotlin", "NSD", "WebSockets"],
    ),
    ProjectModel(
      title: "Gesture Detection App",
      description:
          "Real-time AI application using ML Kit to control devices via hand gestures.",
      techStack: ["Flutter", "ML Kit", "CameraX"],
    ),
    ProjectModel(
      title: "Video Wall System",
      description:
          "Multi-screen synchronized video playback system using custom MethodChannels.",
      techStack: ["Flutter", "MethodChannel", "C++"],
    ),
    ProjectModel(
      title: "IoT Sensor Detection",
      description:
          "Integrated app for real-time monitoring of USB and wireless IoT proximity sensors.",
      techStack: ["Flutter", "USB Serial", "MQTT"],
    ),
  ];

  final List<ExperienceModel> experiences = [
    ExperienceModel(
      company: "Adroit Information Solutions / Fuerte Solutions",
      role: "Software Developer",
      period: "Nov 2024 – Present",
      description: [
        "Developing scalable Flutter and Android applications for multimedia campaign platforms.",
        "Implementing high-performance video playback systems using ExoPlayer and Flutter.",
        "Integrating IoT devices, proximity sensors, and camera-based detection systems.",
        "Optimizing application performance and collaborating with cross-functional teams.",
      ],
    ),
    ExperienceModel(
      company: "GenySoft – Integration & ERP Experts",
      role: "Software Engineer",
      period: "Oct 2023 – Jul 2024",
      description: [
        "Led end-to-end Android application development including architecture design and deployment.",
        "Developed secure REST API integrations and real-time communication features.",
        "Implemented modular architecture and reusable components for scalability.",
        "Collaborated with backend teams and QA to deliver stable production applications.",
      ],
    ),
    ExperienceModel(
      company: "Versatile Mobitech Pvt Ltd",
      role: "Android Developer",
      period: "Nov 2022 – Aug 2023",
      description: [
        "Developed Android applications across multiple business domains.",
        "Implemented modern UI components and optimized application performance.",
        "Integrated third-party SDKs and payment services.",
        "Maintained and improved existing applications for production stability.",
      ],
    ),
    ExperienceModel(
      company: "Exceloid Soft Systems Pvt Ltd",
      role: "Software Engineer",
      period: "Oct 2019 – Oct 2022",
      description: [
        "Built and maintained multiple Android applications using Java and Kotlin.",
        "Integrated REST APIs, payment gateways, and hardware devices.",
        "Improved application performance and reduced crash rates.",
        "Released stable production versions on Google Play Store.",
      ],
    ),
  ];
  final List<Map<String, String>> educationList = [
    {
      "degree": "Master of Computer Applications (MCA)",
      "university": "Chandigarh University, Mohali, Punjab,India",
      "duration": "2022 – 2024",
      "score": "79%",
    },
    {
      "degree": "Bachelor of Computer Applications (BCA)",
      "university": "Kolhan University, Chaibasa, Jharkhand, India",
      "duration": "2013 – 2017",
      "score": "76%",
    },
  ];

  final List<AchievementModel> achievements = [
    AchievementModel(
      title: "Certified Android Developer",
      description:
          "Advanced certification in Android application development and architecture patterns.",
      date: "2020",
    ),
  ];

  final String githubUrl = "https://github.com/baishakhee93";
  final String email = "baishu9534@gmail.com";
  final String linkedInUrl =
      "https://www.linkedin.com/in/baishakhee-mardi-733b3a175";
  final String resumeUrl = "assets/cv.pdf";

  Future<void> launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      debugPrint('Could not launch $url');
    }
  }

  void downloadResume() {
    if (resumeUrl.isNotEmpty) {
      launchURL(resumeUrl);
    }
  }
}
