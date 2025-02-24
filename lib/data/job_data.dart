class JobData {
  String category;
  String job_title;
  String job_position;
  String location;
  String company_name;
  String requirements;
  String job_description;
  String salary;
  String job_type;
  String shift_schedule;
  String label;
  String active;
  String is_new;

  JobData({
    required this.category,
    required this.job_title,
    required this.job_position,
    required this.location,
    required this.company_name,
    required this.requirements,
    required this.job_description,
    required this.salary,
    required this.job_type,
    required this.shift_schedule,
    required this.label,
    required this.active,
    required this.is_new,
  });

  // Convert a Map to a JobData instance
  factory JobData.fromMap(Map<String, dynamic> map) {
    return JobData(
      category: map['category'] ?? '',
      job_title: map['job_title'] ?? '',
      job_position: map['job_position'] ?? '',
      location: map['location'] ?? '',
      company_name: map['company_name'] ?? '',
      requirements: map['requirements'] ?? '',
      job_description: map['job_description'] ?? '',
      salary: map['salary'].toString(),
      job_type: map['job_type'] ?? '',
      shift_schedule: map['shift_schedule'] ?? '',
      label: map['label'] ?? '',
      active: map['active'] ?? '',
      is_new: map['is_new'] ?? '',
    );
  }

  // Convert a JobData instance to a Map
  Map<String, dynamic> toMap() {
    return {
     'category':category,
     'job_title':job_title,
     'job_position':job_position,
     'location':location,
     'company_name':company_name,
     'requirements':requirements,
     'job_description':job_description,
     'salary':salary,
     'job_type':job_type,
     'shift_schedule':shift_schedule,
     'label':label,
     'active':active,
     'is_new':is_new,
    };
  }
}
//
// // Store job data separately in another class
// class JobDataList {
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
//     {
//       'title': 'Senior Digital Marketing''\nManager',
//       'company': 'LocationHQ',
//       'location': 'Dehradun, Uttarakhand',
//       'salary': '₹45,000 - ₹75,000 a month',
//       'type': 'Full-time''\nMonday to Friday',
//       'label': '',
//       'status': 'Typically responds within 6 days',
//       'active': '',
//       'isNew': true,
//     },
//     {
//       'title': 'Front End Developer',
//       'company': 'VARUN MOTORS PVT.LTD.',
//       'location': 'Visakhapatanam,Andhra Pradesh',
//       'salary': 'From ₹4,00,000 a year',
//       'type': 'Full-time +1',
//       'label': 'Hiring multiple candiates',
//       'status': '',
//       'active': '',
//       'isNew': false,
//     },
//     {
//       'title': 'Traninee Programer - ' '\nFresher',
//       'company': 'Evon Technology',
//       'location': 'Dehradun, Uttarakhand',
//       'salary': '',
//       'type': '',
//       'label': '',
//       'status': '',
//       'active': '',
//       'isNew': false,
//     },
//     {
//       'title': 'React.js Developer(Fresher)',
//       'company': 'Essence Software Solutions',
//       'location': 'Gurgaon, Haryana',
//       'salary': '',
//       'type': '',
//       'label': '',
//       'status': '',
//       'active': '',
//       'isNew': false,
//     },
//   ];
// }
//
// // Convert job data into a list of JobData objects
// List<JobData> jobList = JobDataList.jobs.map((map) => JobData.fromMap(map)).toList();
//
//
// // class jobdata{
// //
// //   static List<Map<String, dynamic>> jobs = [
// //     {
// //       'title': 'Multi Sports Coach',
// //       'company': 'Sports Guru India',
// //       'location': 'Vikasnagar, Dehradun, Uttarakhand',
// //       'salary': '₹15,000 - ₹20,000 a month',
// //       'type': 'Morning shift',
// //       'label': 'Hiring multiple candidates',
// //       'status': 'Fresher',
// //       'active': 'Active 15 days ago',
// //       'isNew': false,
// //     },
// //     {
// //       'title': 'Office Administrator/Estimator',
// //       'company': 'Karma Staff',
// //       'location': 'Dehradun, Uttarakhand',
// //       'salary': '₹18,000 - ₹25,000 a month',
// //       'type': 'Full-time',
// //       'label': 'New',
// //       'status': 'Typically responds within 3 days',
// //       'active': '',
// //       'isNew': true,
// //     },
//
// //   ];
// //
// // }