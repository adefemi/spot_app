import 'package:http/http.dart' as http;

class HttpRequests{
  String url;
  dynamic body;
  Map<String, String> headers;

  HttpRequests({url, body, headers}){
    this.url = url;
    this.body = body;
    this.headers = headers;
  }

  Future<dynamic> get() async{
    final response = await http.get(url, headers: headers);
    return response;
  }

  Future<dynamic> post() async{
    final response = await http.post(url, body: body, headers: headers);
    return response;
  }

  Future<dynamic> put() async{
    final response = await http.put(url, body: body, headers: headers);
    return response;
  }

  Future<dynamic> patch() async{
    final response = await http.patch(url, body: body, headers: headers);
    return response;
  }
}