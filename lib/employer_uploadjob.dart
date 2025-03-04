import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:indeed/job_list_screen.dart';

class UploadJob extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: UploadJobScreen(),
    );
  }
}

class UploadJobScreen extends StatefulWidget {
  @override
  _UploadJobScreenState createState() => _UploadJobScreenState();
}

class _UploadJobScreenState extends State<UploadJobScreen> {
  TextEditingController categoryController = TextEditingController();
  TextEditingController jobPositionController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController jobTitleController = TextEditingController();
  TextEditingController companyNameController = TextEditingController();
  TextEditingController requirementController = TextEditingController();
  TextEditingController jobDescriptionController = TextEditingController();
  TextEditingController salaryController = TextEditingController();
  TextEditingController jobTypeController = TextEditingController();
  TextEditingController shiftScheduleController = TextEditingController();
  TextEditingController labelController = TextEditingController();
  TextEditingController activeController = TextEditingController();
  TextEditingController isnewController = TextEditingController();

  Future<void> uploadJob() async {
    Map<String, String> jobData = {
      'category': categoryController.text,
      'job_title': jobTitleController.text,
      'job_position': jobPositionController.text,
      'location': locationController.text,
      'company_name': companyNameController.text,
      'requirements': requirementController.text,
      'job_description': jobDescriptionController.text,
      'salary': salaryController.text,
      'job_type': jobTypeController.text,
      'shift_schedule': shiftScheduleController.text,
      'label': labelController.text,
      'active': activeController.text,
      'is_new': isnewController.text,
    };


    print(jobData);

      final response = await http.post(
      Uri.parse('http://192.168.1.91:8000/api/upload-job'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(jobData),
    );

    if (response.statusCode == 201) {
      Navigator.push(context, MaterialPageRoute(builder: (context)=>JobListScreen()));
      print('Job uploaded successfully: ${response.body}');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Job uploaded successfully!')));
    } else {
      print('Failed to upload job: ${response.body}');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to upload job!')));
    }
  }


  final List<String> categories = ['Design', 'Finance', 'Education', 'Restaurant', 'Health', 'Programmer'];
  final List<String> jobPositions = ['Intern', 'Mid Level', 'Senior Level'];
  final List<String> locations = ['California', 'New York', 'Texas', 'Florida'];
  final List<String> isnew = ['True','False'];
  final List<String> jobtype = ['Full-Time','Part-Time'];
  final List<String> shiftschedule = ['Morning-Shift','Day-Shift','Night-Shift'];
  final List<String> label =['Hiring multiple candidates','New'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(onPressed:(){}, icon:Icon(Icons.arrow_back)),
        centerTitle: true,
        title: Text(
          'Upload Job',
          style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildEditableDropdownField('Category', categories, categoryController),
            buildTextField('Job Title/Designation', jobTitleController),
            buildEditableDropdownField('Job Position', jobPositions, jobPositionController),
            buildTextField('Salary', salaryController),
            buildEditableDropdownField('Job Type', jobtype, jobTypeController),
            buildEditableDropdownField('Shift Schedule', shiftschedule, shiftScheduleController),
            buildEditableDropdownField('Location', locations, locationController),
            buildEditableDropdownField('Label', label, labelController),
            buildTextField('Company Name', companyNameController),
            buildEditableDropdownField('Is New', isnew, isnewController),
            buildTextField('Active', activeController),
            buildTextField('Requirements', requirementController, maxLines: 4),
            buildTextField('Job Description', jobDescriptionController, maxLines: 4),

            SizedBox(height: 20),
            ElevatedButton(
              onPressed: uploadJob,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(15),
                alignment: Alignment.center,
                child: Text(
                  'Upload',
                  style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildEditableDropdownField(String label, List<String> items, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 5),
          TextField(
            controller: controller,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey[200],
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide.none),
              suffixIcon: PopupMenuButton<String>(
                icon: Icon(Icons.arrow_drop_down),
                onSelected: (String value) {
                  controller.text = value;
                },
                itemBuilder: (BuildContext context) {
                  return items.map<PopupMenuItem<String>>((String value) {
                    return PopupMenuItem(
                      value: value,
                      child: Text(value),
                    );
                  }).toList();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTextField(String label, TextEditingController controller, {int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 5),
          TextField(
            controller: controller,
            maxLines: maxLines,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey[200],
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
            ),
          ),
        ],
      ),
    );
  }
}