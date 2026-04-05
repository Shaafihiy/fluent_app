import '../models/course.dart';

class MockData {
  static const List<Course> courses = [
    Course(
      id: '1',
      title: 'Flutter & Dart — Complete Developer Bootcamp',
      description:
          'Master Flutter from the ground up. Build beautiful, natively compiled applications for mobile, web, and desktop from a single codebase. Covers widgets, state management, animations, Firebase integration, and deploying to app stores.',
      category: 'Mobile Development',
      price: 49.99,
      duration: 42.5,
      rating: 4.9,
      enrollments: 24300,
      instructor: 'Angela Yu',
      imageUrl: 'https://images.unsplash.com/photo-1555949963-aa79dcee981c?w=800&q=80',
      level: 'Beginner',
      tags: ['Flutter', 'Dart', 'Mobile', 'Firebase'],
      isFeatured: true,
      isRecentlyViewed: true,
      progress: 0.35,
    ),
    Course(
      id: '2',
      title: 'UI/UX Design Masterclass: Zero to Hero',
      description:
          'Transform your design skills with this comprehensive UI/UX course. Learn Figma, design systems, user research, prototyping, and how to create stunning interfaces that users love. Real-world projects included.',
      category: 'Design',
      price: 39.99,
      duration: 28.0,
      rating: 4.8,
      enrollments: 18750,
      instructor: 'Sarah Chen',
      imageUrl: 'https://images.unsplash.com/photo-1561070791-2526d30994b5?w=800&q=80',
      level: 'Beginner',
      tags: ['Figma', 'UI', 'UX', 'Design Systems'],
      isFeatured: true,
      isRecentlyViewed: true,
      progress: 0.72,
    ),
    Course(
      id: '3',
      title: 'Python for Data Science & Machine Learning',
      description:
          'Learn Python, NumPy, Pandas, Matplotlib, Seaborn, Scikit-Learn, TensorFlow and more! This course covers everything you need to use Python for Data Science and Machine Learning including real-world projects.',
      category: 'Data Science',
      price: 59.99,
      duration: 55.0,
      rating: 4.7,
      enrollments: 31200,
      instructor: 'Jose Portilla',
      imageUrl: 'https://images.unsplash.com/photo-1526374965328-7f61d4dc18c5?w=800&q=80',
      level: 'Intermediate',
      tags: ['Python', 'ML', 'Data Science', 'TensorFlow'],
      isFeatured: true,
    ),
    Course(
      id: '4',
      title: 'React Native — Build Mobile Apps with JavaScript',
      description:
          'Build cross-platform iOS and Android apps using React Native. Covers hooks, navigation, Redux, REST APIs, push notifications, and publishing to both app stores. Portfolio-ready projects throughout.',
      category: 'Mobile Development',
      price: 44.99,
      duration: 36.0,
      rating: 4.6,
      enrollments: 15890,
      instructor: 'Maximilian Schwarzmüller',
      imageUrl: 'https://images.unsplash.com/photo-1512941937669-90a1b58e7e9c?w=800&q=80',
      level: 'Intermediate',
      tags: ['React Native', 'JavaScript', 'iOS', 'Android'],
    ),
    Course(
      id: '5',
      title: 'The Complete Node.js Developer Course',
      description:
          'Learn Node.js by building real-world applications with Node, Express, MongoDB, Jest, and more. Covers authentication, REST APIs, GraphQL, real-time data with Socket.io, and deploying to production.',
      category: 'Backend',
      price: 34.99,
      duration: 35.5,
      rating: 4.8,
      enrollments: 22100,
      instructor: 'Andrew Mead',
      imageUrl: 'https://images.unsplash.com/photo-1627398242454-45a1465c2479?w=800&q=80',
      level: 'Intermediate',
      tags: ['Node.js', 'Express', 'MongoDB', 'REST API'],
    ),
    Course(
      id: '6',
      title: 'Advanced Swift & iOS Development',
      description:
          'Take your Swift skills to the next level. Deep dive into advanced Swift patterns, Combine, SwiftUI animations, Core Data, CloudKit, ARKit, and building production-ready iOS applications.',
      category: 'Mobile Development',
      price: 54.99,
      duration: 48.0,
      rating: 4.7,
      enrollments: 9800,
      instructor: 'Paul Hudson',
      imageUrl: 'https://images.unsplash.com/photo-1611532736597-de2d4265fba3?w=800&q=80',
      level: 'Advanced',
      tags: ['Swift', 'iOS', 'SwiftUI', 'ARKit'],
    ),
    Course(
      id: '7',
      title: 'Graphic Design Fundamentals',
      description:
          'Master the fundamentals of graphic design: color theory, typography, composition, layout, and branding. Use Adobe Illustrator and Photoshop to create professional designs for print and digital media.',
      category: 'Design',
      price: 0,
      duration: 15.0,
      rating: 4.5,
      enrollments: 41500,
      instructor: 'Lindsey Marsh',
      imageUrl: 'https://images.unsplash.com/photo-1572044162444-ad60f128bdea?w=800&q=80',
      level: 'Beginner',
      tags: ['Illustrator', 'Photoshop', 'Branding', 'Typography'],
    ),
    Course(
      id: '8',
      title: 'Kubernetes & Docker: DevOps Mastery',
      description:
          'Become a DevOps engineer. Learn Docker, Kubernetes, CI/CD pipelines, Helm, monitoring with Prometheus & Grafana, and deploying scalable microservices in production environments.',
      category: 'DevOps',
      price: 64.99,
      duration: 62.0,
      rating: 4.9,
      enrollments: 13400,
      instructor: 'Bret Fisher',
      imageUrl: 'https://images.unsplash.com/photo-1667372393119-3d4c48d07fc9?w=800&q=80',
      level: 'Advanced',
      tags: ['Docker', 'Kubernetes', 'CI/CD', 'DevOps'],
    ),
    Course(
      id: '9',
      title: 'Web3 & Blockchain Development with Solidity',
      description:
          'Build decentralized applications on Ethereum. Learn Solidity, smart contracts, Hardhat, ethers.js, IPFS, NFT marketplaces, and DeFi protocols. Deploy real dApps to the blockchain.',
      category: 'Blockchain',
      price: 74.99,
      duration: 40.0,
      rating: 4.6,
      enrollments: 7650,
      instructor: 'Patrick Collins',
      imageUrl: 'https://images.unsplash.com/photo-1639762681485-074b7f938ba0?w=800&q=80',
      level: 'Intermediate',
      tags: ['Solidity', 'Ethereum', 'Web3', 'NFT'],
    ),
    Course(
      id: '10',
      title: 'Excel & Google Sheets for Business Analytics',
      description:
          'Master spreadsheets for business analysis. Learn pivot tables, VLOOKUP, Power Query, data visualization, dashboards, financial modeling, and automation with macros and Google Apps Script.',
      category: 'Business',
      price: 0,
      duration: 18.5,
      rating: 4.4,
      enrollments: 55200,
      instructor: 'Chris Dutton',
      imageUrl: 'https://images.unsplash.com/photo-1460925895917-afdab827c52f?w=800&q=80',
      level: 'Beginner',
      tags: ['Excel', 'Google Sheets', 'Analytics', 'Business'],
    ),
  ];

  static List<Course> get featuredCourses =>
      courses.where((c) => c.isFeatured).toList();

  static List<Course> get recentlyViewed =>
      courses.where((c) => c.isRecentlyViewed).toList();

  static List<Course> get inProgressCourses =>
      courses.where((c) => c.progress != null).toList();

  static Map<String, int> get stats => {
        'enrolled': 3,
        'completed': 1,
        'certificates': 1,
        'hoursLearned': 47,
      };

  static List<String> get categories => [
        'All',
        'Mobile Development',
        'Design',
        'Data Science',
        'Backend',
        'DevOps',
        'Blockchain',
        'Business',
      ];
}
