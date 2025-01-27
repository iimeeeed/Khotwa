# Khotwa - Job Search Application

Khotwa is a Flutter-based mobile application that connects job seekers with companies, facilitating the job search and recruitment process.

## Features

### For Job Seekers
- User authentication and profile management
- Educational and professional experience tracking
- Job search and application submission
- Profile customization with skills, languages, and preferences
- Resume and cover letter management

### For Companies
- Company profile management
- Job posting and management
- Applicant tracking
- Interview scheduling
- Candidate evaluation

## Technical Architecture

### Backend Structure
The application uses a hybrid backend approach with:
- Local SQLite database for offline data persistence
- Supabase for authentication and cloud data storage

#### Database Tables
- Companies
- Job Seekers
- Education Experiences
- Professional Experiences
- Jobs
- Applications
- Interviews

### Key Components

#### Data Layer
- Repository pattern for data access
- Model classes for type-safe data handling
- Base classes for common CRUD operations

#### Authentication
- Email/password-based authentication
- Separate flows for job seekers and companies
- Session management

## Getting Started

### Prerequisites
- Flutter SDK
- Dart SDK
- SQLite
- Supabase account

### Installation

1. Clone the repository
2. Install dependencies
3. Set up Supabase credentials in `lib/backend/supabase/supabase_config.dart`
4. Run the app

## Project Structure

lib/
├── backend/ # Data and API layer
├── models/ # Data models
├── screens/ # UI screens
├── widgets/ # Reusable components
└── utils/ # Helper functions


## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Contact

Project Link: [https://github.com/yourusername/khotwa](https://github.com/yourusername/khotwa)

---

Made with ❤️ by [Khotwa]