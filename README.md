# Glassmorphism Portfolio - Flutter Web & Mobile

A modern, responsive, and visually stunning portfolio application built with Flutter. This project features a **Glassmorphism** design language, smooth animations, and a clean MVVM architecture.

## 🚀 Features

- **Glassmorphism UI**: High-quality frosted glass effects using custom containers and gradients.
- **Responsive Design**: Fully optimized for Desktop, Tablet, and Mobile screens.
- **Smooth Animations**: Animated background bubbles, hover effects, and smooth scroll transitions.
- **Dynamic Content**: Managed through a centralized ViewModel for easy updates.
- **Interactive Sections**:
    - **Hero Section**: Engaging introduction with interactive IDE-style code preview.
    - **About Me**: Detailed professional background.
    - **Skills**: Categorized expertise with visual tags.
    - **Experience**: Chronological professional history.
    - **Projects**: Portfolio showcase with tech stack details.
    - **Achievements**: Recognition and milestones.
    - **Education**: Academic background.
    - **Contact Form**: Professional inquiry form with custom-styled inputs.

## 🛠️ Tech Stack

- **Framework**: [Flutter](https://flutter.dev)
- **State Management**: [Provider](https://pub.dev/packages/provider)
- **Design Pattern**: MVVM (Model-View-ViewModel)
- **Icons**: [FontAwesome](https://pub.dev/packages/font_awesome_flutter) & Material Icons
- **Fonts**: [Google Fonts](https://pub.dev/packages/google_fonts)
- **Utilities**: `url_launcher` for external links.

## 🏗️ Work Flow & Architecture

The project follows the **MVVM (Model-View-ViewModel)** architectural pattern to ensure separation of concerns and maintainability.

### 1. Model Layer (`lib/models/`)
Defines the data structures used throughout the app.
- `ProjectModel`: Structure for portfolio projects.
- `SkillCategory`: Groups related technologies.
- `ExperienceModel`: Professional work history structure.
- `AchievementModel`: Milestone data.

### 2. ViewModel Layer (`lib/view_models/`)
Acts as the bridge between Data and UI.
- `PortfolioViewModel`: Contains all the hardcoded data or API logic. It handles logic like downloading the resume or launching URLs. It notifies the UI of any state changes using `ChangeNotifier`.

### 3. View Layer (`lib/views/`)
The UI components that observe the ViewModel.
- `HomePage`: The main entry point containing all sections. It uses `LayoutBuilder` or `MediaQuery` to adapt the layout for different screen sizes.

### 4. Widgets Layer (`lib/widgets/`)
Reusable UI components like `GlassContainer` to maintain design consistency.

---

## 🚦 Getting Started

### Prerequisites
- Flutter SDK (Latest stable version recommended)
- A code editor (VS Code or Android Studio)

### Installation
1. **Clone the repository**:
   ```bash
   git clone https://github.com/your-username/my_portfolio.git
   ```
2. **Navigate to the project directory**:
   ```bash
   cd my_portfolio
   ```
3. **Get dependencies**:
   ```bash
   flutter pub get
   ```
4. **Run the application**:
   ```bash
   flutter run -d chrome  # For Web
   # OR
   flutter run           # For Mobile/Desktop
   ```

## 📝 Important Note for Windows Users
If your project path or Flutter SDK path contains special characters (like `&`), ensure you use **forward slashes** (`/`) in your `android/local.properties` to avoid shell execution errors.

Example:
```properties
flutter.sdk=C:/src/flutter
```

## 📄 License
This project is open-source and available under the [MIT License](LICENSE).

---
Built with ❤️ by **BAISHAKHEE**
