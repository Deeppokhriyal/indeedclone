class JobData {
  String title;
  String company;
  String location;
  String salary;
  String type;
  String label;
  String status;
  String active;
  bool isNew;

  JobData({
    required this.title,
    required this.company,
    required this.location,
    required this.salary,
    required this.type,
    required this.label,
    required this.status,
    required this.active,
    required this.isNew,
  });

  // Convert a Map to a JobData instance
  factory JobData.fromMap(Map<String, dynamic> map) {
    return JobData(
      title: map['title'] ?? '',
      company: map['company'] ?? '',
      location: map['location'] ?? '',
      salary: map['salary'] ?? '',
      type: map['type'] ?? '',
      label: map['label'] ?? '',
      status: map['status'] ?? '',
      active: map['active'] ?? '',
      isNew: map['isNew'] ?? false,
    );
  }

  // Convert a JobData instance to a Map
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'company': company,
      'location': location,
      'salary': salary,
      'type': type,
      'label': label,
      'status': status,
      'active': active,
      'isNew': isNew,
    };
  }
}

// Store job data separately in another class
class JobDataList {
  static List<Map<String, dynamic>> jobs = [
    {
      'title': 'Multi Sports Coach',
      'company': 'Sports Guru India',
      'location': 'Vikasnagar, Dehradun, Uttarakhand',
      'salary': '₹15,000 - ₹20,000 a month',
      'type': 'Morning shift',
      'label': 'Hiring multiple candidates',
      'status': 'Fresher',
      'active': 'Active 15 days ago',
      'isNew': false,
    },
    {
      'title': 'Office Administrator/Estimator',
      'company': 'Karma Staff',
      'location': 'Dehradun, Uttarakhand',
      'salary': '₹18,000 - ₹25,000 a month',
      'type': 'Full-time',
      'label': 'New',
      'status': 'Typically responds within 3 days',
      'active': '',
      'isNew': true,
    },
    {
      'title': 'Senior Digital Marketing''\nManager',
      'company': 'LocationHQ',
      'location': 'Dehradun, Uttarakhand',
      'salary': '₹45,000 - ₹75,000 a month',
      'type': 'Full-time''\nMonday to Friday',
      'label': '',
      'status': 'Typically responds within 6 days',
      'active': '',
      'isNew': true,
    },
    {
      'title': 'Front End Developer',
      'company': 'VARUN MOTORS PVT.LTD.',
      'location': 'Visakhapatanam,Andhra Pradesh',
      'salary': 'From ₹4,00,000 a year',
      'type': 'Full-time +1',
      'label': 'Hiring multiple candiates',
      'status': '',
      'active': '',
      'isNew': false,
    },
    {
      'title': 'Traninee Programer - ' '\nFresher',
      'company': 'Evon Technology',
      'location': 'Dehradun, Uttarakhand',
      'salary': '',
      'type': '',
      'label': '',
      'status': '',
      'active': '',
      'isNew': false,
    },
    {
      'title': 'React.js Developer(Fresher)',
      'company': 'Essence Software Solutions',
      'location': 'Gurgaon, Haryana',
      'salary': '',
      'type': '',
      'label': '',
      'status': '',
      'active': '',
      'isNew': false,
    },
  ];
}

// Convert job data into a list of JobData objects
List<JobData> jobList = JobDataList.jobs.map((map) => JobData.fromMap(map)).toList();


// class jobdata{
//
//   static List<Map<String, dynamic>> jobs = [
//     {
//       'title': 'Multi Sports Coach',
//       'company': 'Sports Guru India',
//       'location': 'Vikasnagar, Dehradun, Uttarakhand',
//       'salary': '₹15,000 - ₹20,000 a month',
//       'type': 'Morning shift',
//       'label': 'Hiring multiple candidates',
//       'status': 'Fresher',
//       'active': 'Active 15 days ago',
//       'isNew': false,
//     },
//     {
//       'title': 'Office Administrator/Estimator',
//       'company': 'Karma Staff',
//       'location': 'Dehradun, Uttarakhand',
//       'salary': '₹18,000 - ₹25,000 a month',
//       'type': 'Full-time',
//       'label': 'New',
//       'status': 'Typically responds within 3 days',
//       'active': '',
//       'isNew': true,
//     },

//   ];
//
// }