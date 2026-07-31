class AdminCredentials {
  AdminCredentials._();
  static const String username = "manar@spotme.com";
  static const String password = "Manar@2026";

  static bool isAdmin(String enteredUsername, String enteredPassword) {
    return enteredUsername.trim().toLowerCase() == username.toLowerCase() &&
        enteredPassword == password;
  }
}
