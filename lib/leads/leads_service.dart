import 'package:http/http.dart' as http;
import 'dart:convert';

import 'lead.dart';

class LeadsService {
  static Future<List<Lead>> fetchLeads() async {
    final response = await http.post(
      Uri.parse('https://api.thenotary.app/lead/getLeads'),
      body: {
        'notaryId': '6668baaed6a4670012a6e406',
      },
    );

    if (response.statusCode == 200) {
      final jsonData = response.body;
      final parsedJson = json.decode(jsonData);
      final List<dynamic> leadsJson = parsedJson['leads'];

      return leadsJson.map((lead) => Lead.fromJson(lead)).toList();
    } else {
      throw Exception('Failed to load leads');
    }
  }
}
