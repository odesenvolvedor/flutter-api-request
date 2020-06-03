import 'package:api_request/services/request.dart';
import 'package:rxdart/rxdart.dart';

class BlocRequest{
  final _service = Request();
  final _controlador = BehaviorSubject();
  
  Stream get saida => _controlador.stream;
  Sink get entrada => _controlador.sink;
  
  buscar() async {
    await _service.buscar(id: "tt0944947").then(entrada.add);
  }
  
  void dispose() {
    _controlador.close();
  }
}