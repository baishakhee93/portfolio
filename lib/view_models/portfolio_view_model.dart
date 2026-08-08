import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/achievement_model.dart';
import '../models/experience_model.dart';
import '../models/project_model.dart';

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
  final String name = "BAISHAKHEE MARDI";
  final String title = "Senior Android, Flutter & Cross-Platform Developer";

  final String shortIntro =
      "I am a Senior Software Developer with over 7 years of expertise in building high-performance Mobile, Web, and Desktop applications. I specialize in the Android and Flutter ecosystems, delivering seamless cross-platform solutions for Android, Windows, and Web with a focus on complex system architectures.\n\n"
      "✔ 7+ Years Professional Experience\n"
      "✔ Expert in Android, Windows & Web Development\n"
      "✔ Flutter (Dart) & Android (Kotlin/Java) Specialist\n"
      "✔ Multimedia Systems & IoT Integration Expert\n"
      "✔ Scalable Architecture (MVVM, Clean Architecture, SOLID)";

  final String aboutMe =
      "I am a results-driven Senior Software Developer with a proven track record of over 7 years in delivering robust, scalable cross-platform solutions. My technical journey is defined by a passion for building high-performance applications across Android, Windows, and Web platforms using modern frameworks like Flutter.\n\n"
      "My core expertise lies in architecting and deploying seamless experiences from consumer-facing mobile apps to enterprise-level Windows desktop and Web applications. I have a specialized background in multimedia, having built advanced systems for video streaming, real-time audio processing, and large-scale digital signage campaign broadcasting.\n\n"
      "I thrive in environments that require deep hardware integration and cross-platform synergy. I have successfully interfaced apps with a wide array of IoT devices and specialized systems across multiple operating environments. My experience also extends to real-time communication protocols, low-level optimizations, and secure API integrations.\n\n"
      "As a strong advocate for modern software engineering practices, I consistently apply MVVM, Clean Architecture, and SOLID principles to ensure long-term project success. I am dedicated to continuous learning and am always exploring the next frontier of cross-platform technology to build innovative, impactful products.";

  final List<SkillCategory> skillsCategory = [
    SkillCategory(
      title: "Android Platform & System",
      icon: Icons.developer_mode,
      skills: [
        "AOSP",
        "Android Framework",
        "Binder IPC",
        "Android System Services",
        "Android Services",
        "BroadcastReceiver",
        "ContentProvider",
        "ADB",
        "Gradle",
        "Android Debugging",
        "ANR/Crash Analysis",
        "Logcat",
        "ProGuard / R8",
        "APK / AAB",
        "Google Play Console",
      ],
    ),
    SkillCategory(
      title: "Mobile App Development",
      icon: Icons.phone_android,
      skills: [
        "Flutter",
        "Dart",
        "Kotlin",
        "Java",
        "Android SDK",
        "Android NDK",
        "Jetpack Components",
        "Jetpack Compose",
        "Coroutines",
        "Flow",
        "LiveData",
        "ViewModel",
        "Navigation Component",
        "WorkManager",
        "Hilt/Dagger",
      ],
    ),
    SkillCategory(
      title: "Multimedia & Media Systems",
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
        "Android TV / Android Box",
      ],
    ),
    SkillCategory(
      title: "Networking & Real-Time Comm",
      icon: Icons.network_check,
      skills: [
        "REST",
        "WebSocket",
        "MQTT",
        "TCP/IP",
        "UDP",
        "Multicast",
        "NSD",
        "JSON",
        "Dio",
        "Retrofit",
        "OkHttp",
      ],
    ),
    SkillCategory(
      title: "IoT & Hardware Integration",
      icon: Icons.memory,
      skills: [
        "Bluetooth Classic",
        "BLE",
        "USB/Serial Communication",
        "Barcode/QR Scanners",
        "Thermal/POS Printers",
        "Camera Devices",
        "Payment Terminals",
        "Sensors",
        "Proximity Sensors",
        "Android Hardware SDKs",
      ],
    ),
    SkillCategory(
      title: "Architecture & System Design",
      icon: Icons.account_tree,
      skills: [
        "SOLID Principles",
        "OOP",
        "Design Patterns",
        "Clean Architecture",
        "MVVM",
        "Repository Pattern",
        "Dependency Injection",
        "Modular Architecture",
        "Performance Optimization",
        "Debugging",
        "Code Review",
        "Offline-First Architecture",
        "Background Synchronization",
        "Network Recovery",
      ],
    ),
    SkillCategory(
      title: "Database, Cloud & Storage",
      icon: Icons.storage,
      skills: [
        "SQLite",
        "Room Database",
        "Hive",
        "SharedPreferences",
        "Firebase Firestore",
        "Firebase Realtime Database",
        "Firebase Auth",
        "Firebase Cloud Messaging",
        "MySQL",
        "PostgreSQL",
        "Local Storage Management",
      ],
    ),
    SkillCategory(
      title: "Tools, CI/CD & Deploy",
      icon: Icons.build_outlined,
      skills: [
        "Android Studio",
        "VS Code",
        "Git",
        "GitHub",
        "GitLab",
        "GitHub Actions",
        "CI/CD",
        "Gradle Automation",
        "Release Management",
        "Firebase Crashlytics",
        "Play Store Deployment",
        "Figma",
        "Postman",
      ],
    ),
  ];

  final List<Map<String, dynamic>> stats = [
    {"label": "Years Experience", "value": "7+"},
    {"label": "Production Projects", "value": "20+"},
    {"label": "Specialization", "value": "Cross-Platform Systems"},
    {"label": "Platforms", "value": "Android, Windows & Web"},
  ];

  final List<ProjectModel> projects = [
    ProjectModel(
      title: "Video Wall & Synchronized Playback System",
      role: "Senior Android & Flutter Developer",
      description:
          "Engineered a multi-device synchronized video-wall playback system for Android displays with master/slave coordination.",
      features: [
        "Master/slave coordination for grid playback.",
        "Low-latency LAN communication via UDP/Multicast.",
        "Precision synchronized playback across multiple screens.",
        "Offline fallback and local campaign caching.",
      ],
      techStack: [
        "Flutter",
        "Kotlin",
        "UDP/Multicast",
        "ExoPlayer",
        "MethodChannel",
        "Hive",
        "Android TV",
      ],
      isFeatured: true,
      result:
          "Successfully deployed in high-traffic commercial zones with 99.9% uptime.",
    ),
    ProjectModel(
      title: "Digital Signage Campaign Player",
      role: "Senior Android & Flutter Developer",
      description:
          "A high-performance media player for digital signage campaigns with scheduling and remote management.",
      features: [
        "Scheduled multimedia campaign playback.",
        "Offline-first campaign storage and local database management.",
        "Integrated Android native ExoPlayer through Flutter MethodChannels.",
        "Remote device monitoring and health reporting.",
      ],
      techStack: [
        "Flutter",
        "Android SDK",
        "ExoPlayer",
        "REST API",
        "WorkManager",
        "SQLite",
      ],
      isFeatured: true,
      result:
          "Optimized playback performance and reduced data usage by 40% via intelligent caching.",
    ),
    ProjectModel(
      title: "Android TV Device Detection & Management",
      role: "Lead Developer",
      description:
          "Network-based system to detect, monitor, and manage Android TV/Box devices remotely.",
      techStack: ["Android", "Kotlin", "NSD", "WebSockets", "AOSP"],
      isFeatured: true,
      result: "Reduced manual device setup time by 80% for fleet management.",
    ),
    ProjectModel(
      title: "Smart POS & Payment Gateway",
      role: "Software Engineer",
      description:
          "A secure Android-based point of sale system with integrated thermal printer and multi-provider payment gateway support.",
      techStack: [
        "Android",
        "Java",
        "Hardware SDK",
        "BLE",
        "Thermal Printer",
        "Encryption",
      ],
      isFeatured: true,
      result:
          "Deployed across 200+ retail locations with secure PCI-compliant transactions.",
    ),
    ProjectModel(
      title: "AI-Powered Gesture Control App",
      description:
          "Real-time AI application using ML Kit to control devices via hand gestures, integrated with CameraX.",
      techStack: ["Flutter", "ML Kit", "CameraX", "Kotlin"],
    ),
    ProjectModel(
      title: "Enterprise ERP Mobile Sync",
      description:
          "Real-time data synchronization app for enterprise resource planning with offline-first architecture.",
      techStack: [
        "Flutter",
        "SQLite",
        "Dio",
        "Background Synchronization",
        "WorkManager",
      ],
    ),
  ];

  final List<ExperienceModel> experiences = [
    ExperienceModel(
      company: "Freelance Senior Developer",
      role: "Cross-Platform & Android Specialist",
      period: "2017 – Present",
      description: [
        "Delivered custom Android and Flutter solutions for international clients across retail, logistics, and media domains.",
        "Architected and deployed specialized apps including real-time tracking systems and hardware-integrated POS tools.",
        "Provided technical consultancy on AOSP, hardware abstraction layers, and system-level Android optimizations.",
        "Built and maintained high-performance web-based business management dashboards.",
      ],
    ),
    ExperienceModel(
      company: "Adroit Information Solutions / Fuerte Solutions",
      role: "Software Developer",
      period: "Nov 2024 – Present",
      description: [
        "Architecting scalable Flutter and Android applications for enterprise-grade multimedia campaign platforms.",
        "Optimized Android/Flutter multimedia playback, memory utilization, and lifecycle handling for long-running digital-signage devices.",
        "Engineered high-performance video-wall synchronization systems using custom native integrations.",
        "Integrating complex IoT hardware including proximity sensors and specialized camera modules.",
      ],
    ),
    ExperienceModel(
      company: "GenySoft – Integration & ERP Experts",
      role: "Software Engineer",
      period: "Oct 2023 – Jul 2024",
      description: [
        "Led end-to-end development of ERP-integrated Android applications with offline-first capabilities.",
        "Implemented robust background synchronization and conflict resolution mechanisms using WorkManager.",
        "Developed secure REST API integrations and real-time communication features using WebSockets.",
        "Optimized application startup and data processing efficiency for large enterprise datasets.",
      ],
    ),
    ExperienceModel(
      company: "Versatile Mobitech Pvt Ltd",
      role: "Android Developer",
      period: "Nov 2022 – Aug 2023",
      description: [
        "Developed mission-critical Android applications with a focus on high-performance UI and hardware synergy.",
        "Integrated third-party hardware SDKs for Bluetooth printers and payment terminals.",
        "Refactored legacy codebases into modern MVVM architecture, improving testability and maintenance.",
        "Collaborated on production-ready software with strict performance and security requirements.",
      ],
    ),
    ExperienceModel(
      company: "Exceloid Soft Systems Pvt Ltd",
      role: "Software Engineer",
      period: "Oct 2019 – Oct 2022",
      description: [
        "Built and maintained multiple Android applications using Java and Kotlin, focusing on POS and retail systems.",
        "Managed full release cycles on Google Play Console, including app signing and production deployment.",
        "Reduced application crash rates by 60% through proactive debugging and crashlytics monitoring.",
        "Implemented complex local storage solutions and hardware device integrations.",
      ],
    ),
  ];

  final List<Map<String, String>> educationList = [
    {
      "degree": "Master of Computer Applications (MCA)",
      "university": "Chandigarh University, Mohali, Punjab, India",
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
      title: "Production Android Releases",
      description:
          "Successfully architected and deployed multiple enterprise-grade applications to Google Play Store and private distribution channels.",
      date: "2019 - Present",
    ),
    AchievementModel(
      title: "Multimedia System Specialist",
      description:
          "Recognized for expertise in building complex synchronized video wall systems and high-performance signage players.",
      date: "Ongoing",
    ),
    AchievementModel(
      title: "Certified Android Developer",
      description:
          "Professional certification in Android application development and modern architectural patterns.",
      date: "2020",
    ),
  ];

  final String githubUrl = "https://github.com/baishakhee93";
  final String email = "baishu9534@gmail.com";
  final String linkedInUrl =
      "https://www.linkedin.com/in/baishakhee-mardi-733b3a175";
  final String resumeUrl = "assets/cv.pdf";

  final String location = "India";
  final String availability = "Open to Opportunities";
  final String noticePeriod = "Negotiable";
  final String workPreference = "Remote / Hybrid / On-site";

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
