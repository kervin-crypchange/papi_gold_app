extension Validator on String {
  bool get isValidEmail =>
      RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(this);

  String? get emailError => isValidEmail ? null : "Invalid email";

  String? get requiredError => isEmpty ? "Required field" : null;

  String? minLengthError(int min) =>
      (this).length < min ? 'Field must be at least $min characters' : null;

  // Esta expresión regular valida que la contraseña cumpla con:
  // (?=.*[a-z]) - Al menos una letra minúscula
  // (?=.*[A-Z]) - Al menos una letra mayúscula
  // (?=.*\d) - Al menos un número
  // .{6,} - Mínimo 6 caracteres en total
  bool get isValidPassword =>
      RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).{6,}$').hasMatch(this);
}