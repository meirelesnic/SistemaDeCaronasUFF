import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:uff_caronas/model/DAO/VeiculoDAO.dart';
import 'package:uff_caronas/model/modelos/Veiculo.dart';

void main() {
  late FakeFirebaseFirestore firestore;
  late VeiculoDAO veiculoDAO;

  setUp(() {
    firestore = FakeFirebaseFirestore();
    veiculoDAO = VeiculoDAO.comFirestore(firestore: firestore);
  });

  test('salvarVeiculo salva um veículo corretamente', () async {
    await veiculoDAO.salvarVeiculo(
      'Modelo Teste',
      'Marca Teste',
      'Cor Teste',
      2023,
      'usuario_1',
      'ABC1234',
    );

    final querySnapshot = await firestore.collection('veiculos').get();
    expect(querySnapshot.docs.length, 1);

    final veiculo = querySnapshot.docs.first;
    expect(veiculo['modelo'], 'Modelo Teste');
    expect(veiculo['marca'], 'Marca Teste');
    expect(veiculo['cor'], 'Cor Teste');
    expect(veiculo['ano'], 2023);
    expect(veiculo['usuarioId'], 'usuario_1');
    expect(veiculo['placa'], 'ABC1234');
  });

  test('recuperarVeiculoDoc recupera um veículo existente', () async {
    final veiculoId = await firestore.collection('veiculos').add({
      'modelo': 'Modelo Recuperado',
      'marca': 'Marca Recuperada',
      'cor': 'Cor Recuperada',
      'ano': 2022,
      'usuarioId': 'usuario_2',
      'placa': 'DEF5678',
    });

    final veiculoRecuperado = await veiculoDAO.recuperarVeiculoDoc(veiculoId.id);

    expect(veiculoRecuperado, isNotNull);
    expect(veiculoRecuperado!.modelo, 'Modelo Recuperado');
    expect(veiculoRecuperado.marca, 'Marca Recuperada');
    expect(veiculoRecuperado.cor, 'Cor Recuperada');
    expect(veiculoRecuperado.ano, 2022);
    expect(veiculoRecuperado.usuarioId, 'usuario_2');
    expect(veiculoRecuperado.placa, 'DEF5678');
  });

  test('recuperarVeiculoDoc retorna null para veículo inexistente', () async {
    final veiculoRecuperado = await veiculoDAO.recuperarVeiculoDoc('veiculo_inexistente');

    expect(veiculoRecuperado, isNull);
  });

  test('recuperarVeiculo recupera um veículo existente', () async {
    final veiculoId = await firestore.collection('veiculos').add({
      'id': 'veiculo_1',
      'modelo': 'Modelo Consulta',
      'marca': 'Marca Consulta',
      'cor': 'Cor Consulta',
      'ano': 2021,
      'usuarioId': 'usuario_3',
      'placa': 'GHI9012',
    });

    final veiculoRecuperado = await veiculoDAO.recuperarVeiculo('veiculo_1');

    expect(veiculoRecuperado, isNotNull);
    expect(veiculoRecuperado!.modelo, 'Modelo Consulta');
    expect(veiculoRecuperado.marca, 'Marca Consulta');
    expect(veiculoRecuperado.cor, 'Cor Consulta');
    expect(veiculoRecuperado.ano, 2021);
    expect(veiculoRecuperado.usuarioId, 'usuario_3');
    expect(veiculoRecuperado.placa, 'GHI9012');
  });

  test('recuperarVeiculosPorUsuario recupera veículos de um usuário', () async {
    await firestore.collection('veiculos').add({
      'modelo': 'Modelo Usuário',
      'marca': 'Marca Usuário',
      'cor': 'Cor Usuário',
      'ano': 2020,
      'usuarioId': 'usuario_4',
      'placa': 'JKL3456',
    });

    final veiculos = await veiculoDAO.recuperarVeiculosPorUsuario('usuario_4');

    expect(veiculos.length, 1);
    expect(veiculos.first.modelo, 'Modelo Usuário');
    expect(veiculos.first.marca, 'Marca Usuário');
    expect(veiculos.first.cor, 'Cor Usuário');
    expect(veiculos.first.ano, 2020);
    expect(veiculos.first.usuarioId, 'usuario_4');
    expect(veiculos.first.placa, 'JKL3456');
  });

  test('atualizarVeiculo atualiza um veículo existente', () async {
    final veiculoId = await firestore.collection('veiculos').add({
      'modelo': 'Modelo Original',
      'marca': 'Marca Original',
      'cor': 'Cor Original',
      'ano': 2019,
      'usuarioId': 'usuario_5',
      'placa': 'MNO7890',
    });

    final veiculoAtualizado = Veiculo(
      id: veiculoId.id,
      modelo: 'Modelo Atualizado',
      marca: 'Marca Atualizada',
      cor: 'Cor Atualizada',
      ano: 2020,
      usuarioId: 'usuario_5',
      placa: 'XYZ5678',
    );

    await veiculoDAO.atualizarVeiculo(veiculoAtualizado);

    final updatedDoc = await firestore.collection('veiculos').doc(veiculoId.id).get();
    expect(updatedDoc['modelo'], 'Modelo Atualizado');
    expect(updatedDoc['marca'], 'Marca Atualizada');
    expect(updatedDoc['cor'], 'Cor Atualizada');
    expect(updatedDoc['ano'], 2020);
    expect(updatedDoc['usuarioId'], 'usuario_5');
    expect(updatedDoc['placa'], 'XYZ5678');
  });

  test('hasVeiculoIdUser retorna true se usuário tiver veículos', () async {
    await firestore.collection('veiculos').add({
      'modelo': 'Modelo Verificação',
      'marca': 'Marca Verificação',
      'cor': 'Cor Verificação',
      'ano': 2018,
      'usuarioId': 'usuario_7',
      'placa': 'BBB2222',
    });

    final hasVeiculo = await veiculoDAO.hasVeiculoIdUser('usuario_7');
    expect(hasVeiculo, true);
  });

  test('hasVeiculoIdUser retorna false se usuário não tiver veículos', () async {
    final hasVeiculo = await veiculoDAO.hasVeiculoIdUser('usuario_inexistente');
    expect(hasVeiculo, false);
  });
}