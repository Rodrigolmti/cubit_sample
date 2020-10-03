class SampleData {
  final String name;
  final String lastName;
  final String document;

  String get fullName => '$name $lastName';

  const SampleData({
    this.name,
    this.lastName,
    this.document,
  });
}