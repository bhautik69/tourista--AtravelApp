class Signoutfail {
  final String msg;
  const Signoutfail([this.msg = "An unknown error occured."]);
  factory Signoutfail.code(String code) {
    switch (code) {
      case 'user-not-found':
        return const Signoutfail('User not found for that email');
      case 'invalid-user':
        return const Signoutfail("This user is invalid user");
      case 'operation-not allowed':
        return const Signoutfail('Operation is not allowed');
      case 'network-request-failed':
        return const Signoutfail(
            'Network error occurred. Please check your internet connection.');
      default:
        return const Signoutfail();
    }
  }
}
