
class NetworkData{
  static final clientId = "staging_p54CY0wHFEgA8LE.HEv7dEY5rLZeVZGILtCmcqje7Z-03liKtjENo2niJtNwJQubuXxsBfKmMxx7cXs59LDUHxZa_i9q~MKmePW0";
  static final clientSecret = "Fwi6HrD.8~Zx_zVZ4Ofvpb4M7IRDmHEVG~QUCE9mVKHT3Q-2qsBIrj1oRvp~tRr8A8sZN.NpZ5_IfgZADQPNtgsBW1AdZ8A8WdL8";
  static final baseUrl = "http://staging-1.tm30.net:8000/";
  static final userBase = baseUrl + "users/v1/";

  Map<String, String> headers = {
    "Content-Type": "application/x-www-form-urlencoded",
    "client_id": clientId
  };

  // defining the endpoints...

  static final verifyPhoneUrl = userBase + "auths/verify";
  static final verifyCodeUrl = userBase + "auths/verify/code";
  static final getRoleUrl = userBase + "roles";
  static final usersUrl = userBase + "users";
  static final meUrl = userBase + "auths/me";

  String getVerifyPhoneUrl() => verifyPhoneUrl;
  String getVerifyCodeUrl() => verifyCodeUrl;
  String getRolesUrl() => getRoleUrl;
  String getUsersUrl() => usersUrl;
  String getClientId() => clientId;
  String getClientSecret() => clientSecret;
  String getMe() => meUrl;

  Map<String, String> setHeader({bool userBearer = false, bool userJson = false, String token }) {
    final Map<String, String> newHeaders = headers;
    if(userBearer) newHeaders["authorization"] = "Bearer $token";
    if(userJson) newHeaders["Content-Type"] = "application/json";
    return newHeaders;
  }
}

final networkData = NetworkData();