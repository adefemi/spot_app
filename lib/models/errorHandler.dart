
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
    if(["200", "201", "202", "203"].contains(response.statusCode.toString())){
      return;
    }
    else{
      Map decodedResponse = json.decode(response.body) as Map;

      hasError = true;
      if(decodedResponse["error"] != null){
        try{
          errorMessage =  decodedResponse["error"]["responseMessage"];
        }catch(e){
          errorMessage = decodedResponse["error"];
        }
      }
      else{
        if(decodedResponse["data"] != null){
          errorMessage = decodedResponse["data"];
        }
        else{
          errorMessage = "An error occurred";
        }

      }
    }
  }
}