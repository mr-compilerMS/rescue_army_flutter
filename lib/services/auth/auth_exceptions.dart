// User not found
class UserNotFoundAuthException implements Exception {}

// Wrong password entered
class WrongPasswordAuthException implements Exception {}

// User already exists
class UserAlreadyExistsAuthException implements Exception {}

// Weak password
class WeakPasswordAuthException implements Exception {}

// Invalid OTP
class InvalidOtpAuthException implements Exception {}

// Generic error
class GenericAuthException implements Exception {}
