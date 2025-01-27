class DBTables {
  // Companies Table
  static const String companiesTableSql = '''
    CREATE TABLE companies (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      company_owner_name TEXT NOT NULL,
      company_user_email TEXT UNIQUE NOT NULL,
      company_user_password TEXT NOT NULL,
      company_name TEXT NOT NULL,
      company_industry TEXT NOT NULL,
      company_size TEXT,
      company_location TEXT,
      company_email TEXT UNIQUE NOT NULL,
      company_phone TEXT,
      company_website TEXT,
      company_logo BLOB, -- Use BLOB for storing images
      company_description TEXT,
      trade_register_number TEXT UNIQUE NOT NULL,
      tax_identification_number TEXT UNIQUE NOT NULL,
      created_at TEXT DEFAULT (datetime('now'))
    );
  ''';

  // Job Seekers Table
  static const String jobSeekersTableSql = '''
    CREATE TABLE job_seekers (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        full_name TEXT NOT NULL,
        job_seeker_email TEXT UNIQUE NOT NULL,
        job_seeker_password TEXT NOT NULL,
        job_seeker_phone TEXT, 
        job_seeker_address TEXT,
        profile_picture TEXT,
        about_me TEXT,
        work_experience TEXT, -- [jobtitle, company, duration] comma separated values , and | separated if more than one experience
        education TEXT, --[degree, istitution] comma separated values , and | separated if more than one education
        skills TEXT, --comma separated values
        languages TEXT, --comma separated values
        job_preferences TEXT, --comma separated values
        job_type_preferences TEXT, --comma separated values
        job_location_preferences TEXT, --comma separated values
        created_at TEXT DEFAULT (datetime('now'))
      );
  ''';

  // Education Experiences Table
  static const String educationExperiencesTableSql = '''
    CREATE TABLE education_experiences (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        job_seeker_id INTEGER NOT NULL,
        institution_name TEXT NOT NULL,
        program_details TEXT,
        start_date TEXT NOT NULL,
        end_date TEXT,
        FOREIGN KEY (job_seeker_id) REFERENCES job_seekers (id) ON DELETE CASCADE
      );
  ''';

  // Professional Experiences Table
  static const String professionalExperiencesTableSql = '''
    CREATE TABLE professional_experiences (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        job_seeker_id INTEGER NOT NULL,
        job_title TEXT NOT NULL,
        job_details TEXT,
        start_date TEXT NOT NULL,
        end_date TEXT,
        is_current_job INTEGER DEFAULT 0,
        FOREIGN KEY (job_seeker_id) REFERENCES job_seekers (id) ON DELETE CASCADE
      );
  ''';

  // Jobs Table
  static const String jobsTableSql = '''
    CREATE TABLE jobs (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        job_title TEXT NOT NULL,
        job_description TEXT,
        job_category TEXT NOT NULL,
        job_sub_category TEXT,
        job_location TEXT,
        job_address TEXT,
        job_type TEXT NOT NULL,
        salary_lower_bound REAL,
        salary_upper_bound REAL,
        job_facilities TEXT,
        job_responsibilities TEXT,
        job_requirements TEXT,
        company_id INTEGER NOT NULL,
        created_at TEXT DEFAULT (datetime('now')),
        job_status TEXT DEFAULT 'open',
        FOREIGN KEY (company_id) REFERENCES companies (id) ON DELETE CASCADE
      );
  ''';

  // Applications Table
  static const String applicationsTableSql = '''
    CREATE TABLE applications (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        job_id INTEGER NOT NULL,
        job_seeker_id INTEGER NOT NULL,
        application_status TEXT DEFAULT 'pending',
        applied_at TEXT DEFAULT (datetime('now')),
        FOREIGN KEY (job_id) REFERENCES jobs (id) ON DELETE CASCADE,
        FOREIGN KEY (job_seeker_id) REFERENCES job_seekers (id) ON DELETE CASCADE
      );
  ''';

  // Seeker Application Table
  static const String seekerApplicationTableSql = '''
    CREATE TABLE seeker_application (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        job_id INTEGER NOT NULL,
        job_seeker_id INTEGER NOT NULL,
        cv_file TEXT NOT NULL, -- File path for the CV
        motivation_file TEXT NOT NULL, -- File path for the motivation letter
        portfolio_link TEXT, -- Optional field
        application_status TEXT DEFAULT 'pending',
        created_at TEXT DEFAULT (datetime('now')),
        FOREIGN KEY (job_id) REFERENCES jobs (id) ON DELETE CASCADE,
        FOREIGN KEY (job_seeker_id) REFERENCES job_seekers (id) ON DELETE CASCADE
      );
  ''';
}
