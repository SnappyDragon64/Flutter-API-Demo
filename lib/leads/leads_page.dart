import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'leads.dart';

class LeadsPage extends StatefulWidget {
  const LeadsPage({super.key, required this.title});

  final String title;

  @override
  State<LeadsPage> createState() => _LeadsPageState();
}

class _LeadsPageState extends State<LeadsPage> {
  List<dynamic> _leads = [];
  List<dynamic> _filteredLeads = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchLeads();
  }

  Future<void> _fetchLeads() async {
    final response = await http.post(
      Uri.parse('https://api.thenotary.app/lead/getLeads'),
      body: {
        'notaryId': '6668baaed6a4670012a6e406',
      },
    );

    if (response.statusCode == 200) {
      final jsonData = response.body;
      final parsedJson = json.decode(jsonData);
      final leads = parsedJson['leads'];

      setState(() {
        _leads = leads.map((lead) => Lead.fromJson(lead)).toList();
        _filteredLeads = _leads;
        _isLoading = false;
      });
    } else {
      throw Exception('Failed to load leads');
    }
  }

  void _filterLeads(String query) {
    query = query.toLowerCase().trim();

    List<Lead> filteredByFirstName = [];

    List<Lead> filteredByFullName = [];

    for (var lead in _leads) {
      final name = lead.firstName.toLowerCase();

      if (name.contains(query)) {
        filteredByFirstName.add(lead);
      } else {
        final fullName = '${lead.firstName} ${lead.lastName}'.toLowerCase();

        if (fullName.contains(query)) {
          filteredByFullName.add(lead);
        }
      }
    }

    // To priorize first name matches
    final results = filteredByFirstName + filteredByFullName;

    setState(() {
      _filteredLeads = results;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: _filterLeads,
              decoration: InputDecoration(
                labelText: 'Leads',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredLeads.length,
              itemBuilder: (context, index) {
                final lead = _filteredLeads[index];
                return ListTile(
                  leading: CircleAvatar(
                    child: Text(lead.firstName[0]),
                  ),
                  title: Text('${lead.firstName} ${lead.lastName}'),
                  subtitle: Text(lead.email),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}