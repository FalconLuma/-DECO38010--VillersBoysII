/// An instance of an editable Tyred user.
class User {
  User(this._userName, this._age, this._reactionBaseline, this._memoryBaseline);

  String _userName;
  int _age;
  double _reactionBaseline;
  double _memoryBaseline;

  /// Change the username of this Tyred user.
  void setUserName(String userName) {
    _userName = userName;
  }

  /// Return the username of this Tyred user.
  String getUserName() {
    return _userName;
  }

  /// Change the age of this Tyred user.
  void setAge(int age) {
    _age = age;
  }

  /// Return the age of this Tyred user.
  int getAge() {
    return _age;
  }

  /// Change the reaction baseline score of this Tyred user.
  void setReactionBaseline(double reactionBaseline) {
    _reactionBaseline = reactionBaseline;
  }

  /// Return the reaction baseline score of this Tyred user.
  double getReactionBaseline() {
    return _reactionBaseline;
  }

  /// Change the memory baseline score of this Tyred user.
  void setMemoryBaseline(double memoryBaseline) {
    _memoryBaseline = memoryBaseline;
  }

  /// Return the memory baseline score of this Tyred user.
  double getMemoryBaseline() {
    return _memoryBaseline;
  }

  /// Reset this Tyred user to the default user.
  void reset() {
    setUserName('Jacob');
    setAge(32);
    setReactionBaseline(64);
    setMemoryBaseline(128);
  }
}