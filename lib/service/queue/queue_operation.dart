class QueueOperation {
  QueueOperation(this.operation) {
    operation.whenComplete(() => isCompleted = true);
  }

  final Future<void> operation;
  bool isCompleted = false;
}
