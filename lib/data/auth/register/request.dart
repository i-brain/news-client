class RegisterRequest {
  final String username;
  final String email;
  final String password;
  final String passwordConfirmation;

  RegisterRequest({
    required this.username,
    required this.email,
    required this.password,
    required this.passwordConfirmation,
  });
}
