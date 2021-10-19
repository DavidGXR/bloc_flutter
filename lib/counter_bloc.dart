import 'dart:async';

enum Event {
  Increment,
  Decrement
}

class CounterBloc {
  int _counter = 0;

  // ******* Event ******* //
  final _counterEventController = StreamController<Event>();
  // For events, exposing only a sink which is an input
  Sink<Event> get counterEventSink => _counterEventController.sink;

  // ******* State ******* //
  final _counterStateController = StreamController<int>();
  StreamSink<int> get _inCounter => _counterStateController.sink;
  // For state, exposing only a stream which outputs data
  Stream<int> get counter => _counterStateController.stream;

  CounterBloc() {
    // Whenever there is a new event, we want to map it to a new state
    _counterEventController.stream.listen(_mapEventToState);
  }

  void _mapEventToState(Event event) {
    if (event == Event.Increment) {
      _counter++;
    } else {
      _counter--;
    }
    _inCounter.add(_counter); // add into sink (state)
  }

  void dispose() {
    _counterStateController.close();
    _counterEventController.close();
  }
}