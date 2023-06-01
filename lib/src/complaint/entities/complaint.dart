class Complaint {
  final int? id;
  final int schoolId;
  final int organizationId;
  final bool isAnonymous;
  final String description;
  final String? classification;

  Complaint({
    this.id,
    required this.schoolId,
    required this.organizationId,
    required this.isAnonymous,
    required this.description,
    this.classification,
  });
}
