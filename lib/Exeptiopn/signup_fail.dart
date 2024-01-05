class Signupfail {
  final String msg;
  const Signupfail([this.msg = "An unknown error occured."]);
  factory Signupfail.code(String code) {
    switch (code) {
      case 'email-already-in-use':
        return const Signupfail('An account already exists');
      case 'weak-password':
        return const Signupfail('Enter Stronger password');
      case 'invalid-email':
        return const Signupfail('Email is not valid');
      case 'user-disabled':
        return const Signupfail('This user has been disabled');
      case 'operation-not allowed':
        return const Signupfail('Operation is not allowed');
      case 'network-request-failed':
        return const Signupfail(
            'Network error occurred. Please check your internet connection.');
      default:
        return const Signupfail();
    }
  }
}
