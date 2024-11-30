List<List<Map<String, String>>> candidatesData = [
  [
    // New Applicants
    {
      "name": "Nadia Belhimer",
      "jobTitle": "Product Manager",
      "appliedDate": "March 9, 2024",
      "imageUrl":
          "https://blogeral.com.br/wp-content/uploads/2023/02/imagem-profissional.png",
      "email": "nadia.belhimer@email.com",
      "phone": "+213 567 890 789",
      "address": "Algiers, Algeria",
      "skills": "Product Strategy, Roadmap Planning, Market Research",
      "experience":
          "3 years in product management, leading successful product launches.",
      "resume": "https://example.com/resume/nadia_belhimer_resume.pdf",
      "certificates":
          "https://example.com/certificates/product_manager_certificate.pdf"
    },
    {
      "name": "Ahmed Zinedine",
      "jobTitle": "Backend Developer",
      "appliedDate": "March 8, 2024",
      "imageUrl":
          "https://img.freepik.com/premium-photo/young-indian-male-designer-engineer-architect-who-is-wearing-glasses-blue-shir_398492-16045.jpg",
      "email": "ahmed.zinedine@email.com",
      "phone": "+213 671 234 567",
      "address": "Setif, Algeria",
      "skills": "Node.js, Express, MongoDB, REST APIs",
      "experience":
          "2 years in backend development, creating scalable backend solutions.",
      "resume": "https://example.com/resume/ahmed_zinedine_resume.pdf",
      "certificates":
          "https://example.com/certificates/backend_developer_certificate.pdf"
    },
    {
      "name": "Zahra Toumi",
      "jobTitle": "Data Scientist",
      "appliedDate": "March 7, 2024",
      "imageUrl":
          "https://blogeral.com.br/wp-content/uploads/2023/02/imagem-profissional.png",
      "email": "zahra.toumi@email.com",
      "phone": "+213 654 321 987",
      "address": "Oran, Algeria",
      "skills": "Data Analysis, Python, Machine Learning, SQL",
      "experience":
          "4 years in data science, analyzing large datasets to extract insights.",
      "resume": "https://example.com/resume/zahra_toumi_resume.pdf",
      "certificates":
          "https://example.com/certificates/data_science_certificate.pdf"
    },
    {
      "name": "Karim Belkacem",
      "jobTitle": "Marketing Specialist",
      "appliedDate": "March 6, 2024",
      "imageUrl":
          "https://img.freepik.com/premium-photo/young-indian-male-designer-engineer-architect-who-is-wearing-glasses-blue-shir_398492-16045.jpg",
      "email": "karim.belkacem@email.com",
      "phone": "+213 777 234 567",
      "address": "Constantine, Algeria",
      "skills": "SEO, Content Marketing, Social Media Strategy",
      "experience":
          "3 years in digital marketing, helping brands build online presence.",
      "resume": "https://example.com/resume/karim_belkacem_resume.pdf",
      "certificates":
          "https://example.com/certificates/marketing_specialist_certificate.pdf"
    },
    {
      "name": "Sonia Farouk",
      "jobTitle": "Graphic Designer",
      "appliedDate": "March 5, 2024",
      "imageUrl":
          "https://blogeral.com.br/wp-content/uploads/2023/02/imagem-profissional.png",
      "email": "sonia.farouk@email.com",
      "phone": "+213 612 345 678",
      "address": "Algiers, Algeria",
      "skills": "Photoshop, Illustrator, Graphic Design, Branding",
      "experience":
          "2 years in graphic design, working with startups on brand identity.",
      "resume": "https://example.com/resume/sonia_farouk_resume.pdf",
      "certificates":
          "https://example.com/certificates/graphic_design_certificate.pdf"
    },
  ],
  [
    // Pending Interviews
    {
      "name": "Aymen Louhaichi",
      "jobTitle": "Web Developer",
      "appliedDate": "March 6, 2024",
      "imageUrl":
          "https://img.freepik.com/premium-photo/young-indian-male-designer-engineer-architect-who-is-wearing-glasses-blue-shir_398492-16045.jpg",
      "email": "aymen.louhaichi@example.com",
      "phone": "+213 661 234 567",
      "address": "Algiers, Algeria",
      "skills": "JavaScript, HTML, CSS, React, Node.js",
      "experience": "3 years as a Web Developer at XYZ Company",
      "resume": "https://example.com/resume/aymen_louhaichi.pdf",
      "certificates": "https://example.com/certificates/web_dev_certification"
    },
    {
      "name": "Rania Oussama",
      "jobTitle": "Mobile Developer",
      "appliedDate": "March 12, 2024",
      "imageUrl":
          "https://blogeral.com.br/wp-content/uploads/2023/02/imagem-profissional.png",
      "email": "rania.oussama@example.com",
      "phone": "+213 665 876 543",
      "address": "Oran, Algeria",
      "skills": "Swift, Java, Kotlin, Android, iOS",
      "experience": "2 years in Mobile Development at ABC Corp.",
      "resume": "https://example.com/resume/rania_oussama.pdf",
      "certificates":
          "https://example.com/certificates/mobile_dev_certification"
    },
    {
      "name": "Ali Meguenni",
      "jobTitle": "Network Engineer",
      "appliedDate": "March 14, 2024",
      "imageUrl":
          "https://img.freepik.com/premium-photo/young-indian-male-designer-engineer-architect-who-is-wearing-glasses-blue-shir_398492-16045.jpg",
      "email": "ali.meguenni@example.com",
      "phone": "+213 666 543 210",
      "address": "Constantine, Algeria",
      "skills": "Cisco, Networking, TCP/IP, Routing, Security",
      "experience": "4 years as a Network Engineer at DEF Ltd.",
      "resume": "https://example.com/resume/ali_meguenni.pdf",
      "certificates":
          "https://example.com/certificates/networking_certification"
    },
    {
      "name": "Sophie Mebarki",
      "jobTitle": "Marketing Coordinator",
      "appliedDate": "March 10, 2024",
      "imageUrl":
          "https://blogeral.com.br/wp-content/uploads/2023/02/imagem-profissional.png",
      "email": "sophie.mebarki@example.com",
      "phone": "+213 667 321 987",
      "address": "Annaba, Algeria",
      "skills":
          "Marketing Strategy, Digital Marketing, SEO, Google Ads, Social Media",
      "experience": "2 years as Marketing Coordinator at GHI Co.",
      "resume": "https://example.com/resume/sophie_mebarki.pdf",
      "certificates": "https://example.com/certificates/marketing_certification"
    },
    {
      "name": "Hassan Benhamida",
      "jobTitle": "Sales Representative",
      "appliedDate": "March 11, 2024",
      "imageUrl":
          "https://img.freepik.com/premium-photo/young-indian-male-designer-engineer-architect-who-is-wearing-glasses-blue-shir_398492-16045.jpg",
      "email": "hassan.benhamida@example.com",
      "phone": "+213 668 098 765",
      "address": "Tlemcen, Algeria",
      "skills": "Sales, Negotiation, CRM, Lead Generation, Client Relations",
      "experience": "5 years in Sales at JKL Enterprises",
      "resume": "https://example.com/resume/hassan_benhamida.pdf",
      "certificates": "https://example.com/certificates/sales_certification"
    },
    {
      "name": "Omar Ali",
      "jobTitle": "Marketing Manager",
      "appliedDate": "March 5, 2024",
      "imageUrl":
          "https://img.freepik.com/premium-photo/young-indian-male-designer-engineer-architect-who-is-wearing-glasses-blue-shir_398492-16045.jpg",
      "email": "omar.ali@example.com",
      "phone": "+213 677 654 321",
      "address": "Setif, Algeria",
      "skills":
          "Branding, Marketing Strategy, Social Media, Market Research, Advertising",
      "experience": "6 years as a Marketing Manager at MNO Marketing",
      "resume": "https://example.com/resume/omar_ali.pdf",
      "certificates":
          "https://example.com/certificates/marketing_manager_certification"
    },
    {
      "name": "Yasmine Belkacem",
      "jobTitle": "HR Manager",
      "appliedDate": "March 1, 2024",
      "imageUrl":
          "https://blogeral.com.br/wp-content/uploads/2023/02/imagem-profissional.png",
      "email": "yasmine.belkacem@example.com",
      "phone": "+213 678 345 876",
      "address": "Algiers, Algeria",
      "skills":
          "Recruitment, Employee Relations, HR Policies, Training, Payroll",
      "experience": "7 years as an HR Manager at PQR Solutions",
      "resume": "https://example.com/resume/yasmine_belkacem.pdf",
      "certificates":
          "https://example.com/certificates/hr_manager_certification"
    },
    {
      "name": "Karim Rachid",
      "jobTitle": "Project Manager",
      "appliedDate": "March 2, 2024",
      "imageUrl":
          "https://img.freepik.com/premium-photo/young-indian-male-designer-engineer-architect-who-is-wearing-glasses-blue-shir_398492-16045.jpg",
      "email": "karim.rachid@example.com",
      "phone": "+213 679 234 567",
      "address": "Blida, Algeria",
      "skills":
          "Project Planning, Risk Management, Budgeting, Leadership, Agile",
      "experience": "4 years as Project Manager at STU Projects",
      "resume": "https://example.com/resume/karim_rachid.pdf",
      "certificates":
          "https://example.com/certificates/project_management_certification"
    },
    {
      "name": "Omar Khemiri",
      "jobTitle": "Business Analyst",
      "appliedDate": "March 3, 2024",
      "imageUrl":
          "https://img.freepik.com/premium-photo/young-indian-male-designer-engineer-architect-who-is-wearing-glasses-blue-shir_398492-16045.jpg",
      "email": "omar.khemiri@example.com",
      "phone": "+213 680 567 890",
      "address": "Constantine, Algeria",
      "skills":
          "Data Analysis, Business Strategy, Process Improvement, SQL, Reporting",
      "experience": "3 years as Business Analyst at VWX Solutions",
      "resume": "https://example.com/resume/omar_khemiri.pdf",
      "certificates":
          "https://example.com/certificates/business_analysis_certification"
    },
    {
      "name": "Lina Boudjemaa",
      "jobTitle": "Operations Manager",
      "appliedDate": "March 4, 2024",
      "imageUrl":
          "https://blogeral.com.br/wp-content/uploads/2023/02/imagem-profissional.png",
      "email": "lina.boudjemaa@example.com",
      "phone": "+213 681 345 678",
      "address": "Bejaia, Algeria",
      "skills":
          "Operations Management, Logistics, Team Leadership, Strategic Planning, Supply Chain",
      "experience": "5 years as Operations Manager at YZA Ltd.",
      "resume": "https://example.com/resume/lina_boudjemaa.pdf",
      "certificates":
          "https://example.com/certificates/operations_management_certification"
    }
  ]
];

final List<Map<String, dynamic>> featuredJobs = [
  {
    'title': 'Product Designer',
    'company': 'SONATRACH',
    'salary': '600,000 DA/y',
    'location': 'Algiers',
    'tags': ['Design', 'Full-Time', 'Junior'],
  },
  {
    'title': 'Frontend Developer',
    'company': 'SONATRACH',
    'salary': '160,000/year',
    'location': 'Oran',
    'tags': ['Analyst', 'Full-Time', 'Junior'],
  },
];
