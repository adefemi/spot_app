
class NetworkData{
  static final clientId = "staging_zHHPqPn.Gp2ZSTkRM81Sksp3Ig0~d1F8..b3dWN3XtTRZS8MYMy28poWD7v6UKQsFptXN15MtxHw9uL59LCfaGVy5LFPFu.j9qnP";
  static final clientSecret = "e3B3cDyU-KjI7hL90Bw82rbRuosbSbDv_mEKbdeqde2xW9lOcRWEO7lpMv0VH22RNg3E~7qKJMlMc.WwF9AQLtKYvHu9hy0t7v~T";
  static final baseMainUrl = "https://staging.api.humbergames.com/";
  static final baseUrl = "http://thor.paypad.com.ng:8090/";
  static final userBase = baseMainUrl + "users/v1/";
  static final paymentBase = baseMainUrl + "payments/v1/";
  static final billingBase = baseMainUrl + "billings/";

  Map<String, String> headers = {
    "Content-Type": "application/x-www-form-urlencoded",
    "client-id": clientId,
    "client_secret": clientSecret
  };
  String tempToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhdXRoIjp7InVzZXJJZCI6IjVlZWU5OTlkNDIzZjc1MDAxYjc2NjJjMyIsInJvbGVJZCI6IjVlNzdhZmU5OTMwZWIzMDAxNzFhNzEwMyIsImNsaWVudElkIjoic3RhZ2luZ196SEhQcVBuLkdwMlpTVGtSTTgxU2tzcDNJZzB-ZDFGOC4uYjNkV04zWHRUUlpTOE1ZTXkyOHBvV0Q3djZVS1FzRnB0WE4xNU10eEh3OXVMNTlMQ2ZhR1Z5NUxGUEZ1Lmo5cW5QIiwicGhvbmVOdW1iZXIiOiIyMzQ4MTExMTExMTExIiwiY3JlYXRlZEF0IjoiMjAyMC0wNi0yMFQyMzoxOTo1Ny42ODlaIiwidXBkYXRlZEF0IjoiMjAyMC0wNi0yMFQyMzoxOTo1Ny42ODlaIiwiaWQiOiI1ZWVlOTk5ZDQyM2Y3NTAwMWI3NjYyYzQiLCJwcm9maWxlIjp7Im5hbWUiOiJUb2Z1bm1pIiwiY2xpZW50SWQiOiJzdGFnaW5nX3pISFBxUG4uR3AyWlNUa1JNODFTa3NwM0lnMH5kMUY4Li5iM2RXTjNYdFRSWlM4TVlNeTI4cG9XRDd2NlVLUXNGcHRYTjE1TXR4SHc5dUw1OUxDZmFHVnk1TEZQRnUuajlxblAiLCJtZXRhIjp7ImFjY291bnRUeXBlIjoiRGlhbW9uWHRyYSIsImFjY291bnRUb2tlbiI6IjA3MTliMDhkOTI1ZDQyMTJiMjAwZTRkOTQzODQ1ZTZmIiwiZG9iIjoiMDIwNCIsImFnZVJhbmdlIjoiMTgtMjUiLCJTdGF0ZSI6IkxBR09TIiwiZ2VuZGVyIjoiTSIsImxhc3RUcmFuc2FjdGlvbkRhdGUiOiIyMDE5LTA1LTA5IiwiYWNjb3VudENyZWF0ZURhdGUiOiIyMDE4LTA0LTEwIiwiYmFsYW5jZSI6IjIwOTg5MjkwMiIsImNsaWVudElkIjoic3RhZ2luZ196SEhQcVBuLkdwMlpTVGtSTTgxU2tzcDNJZzB-ZDFGOC4uYjNkV04zWHRUUlpTOE1ZTXkyOHBvV0Q3djZVS1FzRnB0WE4xNU10eEh3OXVMNTlMQ2ZhR1Z5NUxGUEZ1Lmo5cW5QIn0sImNyZWF0ZWRBdCI6IjIwMjAtMDYtMjBUMjM6MTk6NTcuNDYxWiIsInVwZGF0ZWRBdCI6IjIwMjAtMDYtMjBUMjM6MTk6NTcuNDYxWiIsImlkIjoiNWVlZTk5OWQ0MjNmNzUwMDFiNzY2MmMzIn19LCJ0eXBlIjoiYXV0aCIsImNsaWVudElkIjoic3RhZ2luZ196SEhQcVBuLkdwMlpTVGtSTTgxU2tzcDNJZzB-ZDFGOC4uYjNkV04zWHRUUlpTOE1ZTXkyOHBvV0Q3djZVS1FzRnB0WE4xNU10eEh3OXVMNTlMQ2ZhR1Z5NUxGUEZ1Lmo5cW5QIiwiYXV0aG9yaXNlZFNlcnZpY2UiOlsic3VwcG9ydC1zZXJ2aWNlIiwicGF5bWVudC1zZXJ2aWNlIl0sImlhdCI6MTU5MjY5NTE5N30.hlVWuLwpRdog0CnpVhtx_AhNuzhgg559PnH5cN_UcP8";
  String getVerifyPhoneUrl() => userBase + "auths/verify";
  String getVerifyCodeUrl() => userBase + "auths/verify/code";
  String getRolesUrl() => userBase + "roles";
  String getUsersUrl() => userBase + "users";
  String getClientId() => clientId;
  String getClientSecret() => clientSecret;
  String getMe() => userBase + "auths/me";
  String getCategory() => baseUrl + "category";
  String deal() => baseUrl + "deal";
  String dealSummary() => baseUrl + "deal/interest/summary";
  String pinDealUrl = baseUrl + "deal/pin";
  String mallUrl = baseUrl + "mall";
  String paymentCardsUrl = paymentBase + "cards/";
  String paymentInitializerUrl = paymentBase + "paystack/initialize";
  String paymentVerifyUrl = paymentBase + "paystack/verify/";
  String paymentChargeAuthUrl = paymentBase + "paystack/charge";
  String walletChargeUrl = billingBase + "charge";
  String walletUrl = billingBase + "wallets";

  Map<String, String> setHeader({bool userBearer = false, bool userJson = false, String token }) {
    final Map<String, String> newHeaders = headers;
    if(userBearer) newHeaders["authorization"] = "Bearer $token";
    if(userJson) newHeaders["Content-Type"] = "application/json";
    if(userJson) newHeaders["accept"] = "application/json";
    return newHeaders;
  }
}

final networkData = NetworkData();