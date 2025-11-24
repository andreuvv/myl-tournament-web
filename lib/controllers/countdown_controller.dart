import 'dart:async';

class CountdownController {
  final DateTime targetDate;
  final _timeController = StreamController<Duration>.broadcast();
  Timer? _timer;
  late Duration _currentTime;

  CountdownController(this.targetDate) {
    _currentTime = _calculateTime();
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (_) => _updateTime(),
    );
  }

  Stream<Duration> get timeStream => _timeController.stream;
  Duration get initialTime => _currentTime;

  Duration _calculateTime() {
    final now = DateTime.now();
    var timeLeft = targetDate.difference(now);
    if (timeLeft.isNegative) timeLeft = Duration.zero;
    return timeLeft;
  }

  void _updateTime() {
    _currentTime = _calculateTime();
    _timeController.add(_currentTime);
  }

  void dispose() {
    _timer?.cancel();
    _timeController.close();
  }
}
