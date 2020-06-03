import 'package:api_request/services/request.dart';
import 'package:rxdart/rxdart.dart';

class BlocRequestDetails{
  final _service = Request();
  final _controlador = BehaviorSubject();
  
  Stream get saida => _controlador.stream;
  Sink get entrada => _controlador.sink;
  
  buscar(int temporada) async {
    await _service.buscar(id: "tt0944947", season: temporada).then(entrada.add);
  }
  
  void dispose() {
    _controlador.close();
  }
}