class Steps {
  final int stepNo;
  final String stepDescription;

  Steps({
    required this.stepNo,
    required this.stepDescription,
  });

  Map<String, dynamic> toMap() {
    return {
      'stepNo': stepNo,
      'stepDescription': stepDescription,
    };
  }

  static Steps fromMap(Map<String, dynamic> map) {
    return Steps(
      stepNo: map['stepNo'],
      stepDescription: map['stepDescription'],
    );
  }
}
