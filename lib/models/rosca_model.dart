class RoscaModel {
  final String id;
  final String title;
  final int totalMembers;
  final int amountPerMember;
  final DateTime startDate;
  final Duration cycleDuration; // e.g., 30 days
  final List<String> memberIds; // UIDs
  final Map<String, int> turnOrder; // uid => turn number
  final int currentRound;
  final bool isFinished;
  final List<DateTime> payoutDates;
  final String createdBy;


  RoscaModel({
    required this.id,
    required this.title,
    required this.totalMembers,
    required this.amountPerMember,
    required this.startDate,
    required this.cycleDuration,
    required this.memberIds,
    required this.turnOrder,
    required this.currentRound,
    required this.payoutDates,
    required this.createdBy,
    this.isFinished = false,
  });

  factory RoscaModel.fromMap(Map<String, dynamic> map) {
    return RoscaModel(
      id: map['id'],
      title: map['title'],
      totalMembers: map['totalMembers'],
      amountPerMember: map['amountPerMember'],
      startDate: DateTime.parse(map['startDate']),
      cycleDuration: Duration(days: map['cycleDurationDays']),
      memberIds: List<String>.from(map['memberIds']),
      turnOrder: Map<String, int>.from(map['turnOrder']),
      currentRound: map['currentRound'],
      createdBy: map['createdBy'],
      payoutDates: List<DateTime>.from(
          map['payoutDates'].map((date) => DateTime.parse(date))),
      isFinished: map['isFinished'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'totalMembers': totalMembers,
      'amountPerMember': amountPerMember,
      'startDate': startDate.toIso8601String(),
      'cycleDurationDays': cycleDuration.inDays,
      'memberIds': memberIds,
      'turnOrder': turnOrder,
      'currentRound': currentRound,
      'createdBy': createdBy,
      'payoutDates': payoutDates.map((date) => date.toIso8601String()).toList(),
      'isFinished': isFinished,
    };
  }
}
