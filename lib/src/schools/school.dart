class School {
  final int id;
  final String name;
  final String street;
  final String number;
  final String neighborhood;
  final String complement;
  final String city;
  final String state;

  School(
      {required this.id,
      required this.name,
      required this.street,
      required this.number,
      required this.neighborhood,
      required this.complement,
      required this.city,
      required this.state});

  factory School.fromJson(Map<String, dynamic> json) {
    return School(
      id: json['id'],
      name: json['name'],
      street: json['street'],
      number: json['number'],
      neighborhood: json['neighborhood'],
      complement: json['complement'],
      city: json['city'],
      state: json['state'],
    );
  }
}
