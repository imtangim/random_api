import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<void> fetchData() async {
  try {
    final response =
        await http.get(Uri.parse('http://127.0.0.1:4000/get_values'));

    if (response.statusCode == 200) {
      // Parse the JSON response
      final Map<String, dynamic> apiData = json.decode(response.body);

      // Check if the "values" key exists and if it contains a list of doubles
      if (apiData.containsKey("values") && apiData["values"] is List<dynamic>) {
        List<dynamic> apiValues = apiData["values"];
        List<dynamic> newData =
            apiValues.map((value) => value.toDouble()).toList();

        // Print the values
        print("Values are: $newData");

        // You can add code here to update your widget or do other processing
      } else {
        return;
      }
    } else {
      print("HTTP request failed with status code ${response.statusCode}");
    }
  } catch (e) {
    print("Error during HTTP request: $e");
  }
}

void main() async {
  await fetchData(); // Wait for fetchData to complete
}
