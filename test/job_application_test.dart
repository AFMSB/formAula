import 'package:flutter_test/flutter_test.dart';
import 'package:form_aula/models/job_application.dart';
import 'package:form_aula/models/my_applications.dart';

void main() {
  group('Unit tests examples', () {
    test('Validate the creation of a job application', () {
      final JobApplicationModel jobApplicationModel = JobApplicationModel(
          "_company",
          "_name",
          "_resume",
          DateTime.now(),
          0,
          "_email",
          "_linkedin");
      expect(jobApplicationModel.name, "_name");
      expect(jobApplicationModel.company, "_company");
      expect(jobApplicationModel.resume, "_resume");
    });

    test('Validate the MyApplications add function', () {
      final JobApplicationModel jobApplicationModel = JobApplicationModel(
          "_company",
          "_name",
          "_resume",
          DateTime.now(),
          0,
          "_email",
          "_linkedin");
      MyJobApplicationsModel model = MyJobApplicationsModel();
      expect(model.applications.length, 0);
      model.add(jobApplicationModel);
      expect(model.applications.length, 1);
    });
  });
}
