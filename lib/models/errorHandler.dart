
import 'dart:convert';

import 'package:http/http.dart';

class ErrorHandler{
  Response response;
  bool hasError = false;
  String errorMessage;

  ErrorHandler({response}){
    this.response = response;
    validateResponse();
  }

  void validateResponse(){
    if(response.statusCode.toString() == "200" || response.statusCode.toString() == "201"){
      return;
    }
    else{
      Map decodedResponse = json.decode(response.body) as Map;
      hasError = true;
      try{
        errorMessage = decodedResponse["error"];
      }catch(e){
        errorMessage = "An error occurred";
      }
    }
  }
}