class Signinfail {
  final String msg;
  const Signinfail([this.msg = "An unknown error occured."]);
  factory Signinfail.code(String code) {
    switch (code) {
      case 'user-not-found':
        return const Signinfail('User not found for that email');
      case 'wrong-password':
        return const Signinfail('Wrong password provided for that user');
      case 'invalid-email':
        return const Signinfail('Email is not valid');
      case 'user-disabled':
        return const Signinfail('This user has been disabled');
      case 'operation-not allowed':
        return const Signinfail('Operation is not allowed');
      case 'network-request-failed':
        return const Signinfail(
            'Network error occurred. Please check your internet connection.');
      default:
        return const Signinfail();
    }
  }
}
