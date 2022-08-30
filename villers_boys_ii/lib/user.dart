class User {
  User(this._userName, this._age, this._reactionBaseline, this._memoryBaseline);

  String _userName;
  int _age;
  double _reactionBaseline;
  double _memoryBaseline;

  void setUserName(String userName) {
    _userName = userName;
  }

  String getUserName() {
    return _userName;
  }

  void setAge(int age) {
    _age = age;
  }

  int getAge() {
    return _age;
  }

  void setReactionBaseline(double reactionBaseline) {
    _reactionBaseline = reactionBaseline;
  }

  double getReactionBaseline() {
    return _reactionBaseline;
  }

  void setMemoryBaseline(double memoryBaseline) {
    _memoryBaseline = memoryBaseline;
  }

  double getMemoryBaseline() {
    return _memoryBaseline;
  }

  void reset() {
    setUserName('Jacob');
    setAge(32);
    setReactionBaseline(64);
    setMemoryBaseline(128);
  }
}