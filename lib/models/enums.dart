enum Provider {
  google,
  email,
}

enum LoginPageType {
  create("Create Account"),
  signIn("Sign In");

  final String text;
  const LoginPageType(this.text);
}
