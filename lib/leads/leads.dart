class Lead {
  final String firstName;
  final String lastName;
  final String email;

  Lead({required this.firstName, required this.lastName, required this.email});

  factory Lead.fromJson(dict) {
    // The API returns the first name and the last name in a single string.
    final name = dict['firstName'].split(' ');

    return Lead(
        firstName: name[0],
        lastName: name[1],
        email: dict['email']
    );
  }
}