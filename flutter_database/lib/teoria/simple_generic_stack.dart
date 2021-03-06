class Stack<T> {
  List<T> _stack = [];

  void push(T item) => _stack.add(item);
  T pop() => _stack.removeLast();
}

void main(List<String> args) {
  final stack = Stack<String>();
  stack.push("Uma string");

  final stack2 = Stack<int>();
  stack2.push(2);
}
