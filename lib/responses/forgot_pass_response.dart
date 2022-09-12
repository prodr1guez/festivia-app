enum ForgotPassResponse {
  ok,
  networkRequestFailed,
  userDisabled,
  userNotFound,
  wrongPassword,
  toManyRequest,
  unknown
}

ForgotPassResponse stringtToForgotPassResponse(String code) {
  switch (code) {
    case "internal-error":
      return ForgotPassResponse.toManyRequest;

    case "user-not-found":
      return ForgotPassResponse.userNotFound;
    case "user-disabled":
      return ForgotPassResponse.userDisabled;
    case "network-request-failed":
      return ForgotPassResponse.networkRequestFailed;

    default:
      return ForgotPassResponse.unknown;
  }
}
