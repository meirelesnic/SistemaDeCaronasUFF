import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:uff_caronas/controller/VeiculoController.dart';
import 'package:uff_caronas/model/modelos/Veiculo.dart';

void main() {
  late FakeFirebaseFirestore firestore;
  late VeiculoController veiculoController;

  setUp(() {
    firestore = FakeFirebaseFirestore();
    veiculoController = VeiculoController.comFirestore(firestore: firestore);
  });

  test('comportamento de adição de veículo da tela adicionarVeiculo', () async {
    String id = '1';
    String modelo = 'Modelo';
    String marca = 'Marca';
    String cor = 'Cor';
    int ano = 2024;
    String usuarioId = '1';
    String placa = 'AAA1234';

    Veiculo veiculo = Veiculo(id: id, modelo: modelo, marca: marca, cor: cor, ano: ano, usuarioId: usuarioId, placa: placa);

    veiculoController.salvarVeiculo(veiculo.modelo, veiculo.marca, veiculo.cor, veiculo.ano, veiculo.usuarioId, veiculo.placa);

    final querySnapshot = await firestore.collection('veiculos').get();
    expect(querySnapshot.docs.length, 1);

    final veiculoSalvo = querySnapshot.docs.first.data() as Map<String, dynamic>;
    expect(veiculoSalvo['modelo'], modelo);
    expect(veiculoSalvo['marca'], marca);
    expect(veiculoSalvo['cor'], cor);
    expect(veiculoSalvo['ano'], ano);
    expect(veiculoSalvo['usuarioId'], usuarioId);
    expect(veiculoSalvo['placa'], placa);
  });

}
