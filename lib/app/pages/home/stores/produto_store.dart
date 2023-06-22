import 'package:contacts_app/app/data/http/exceptions.dart';
import 'package:contacts_app/app/data/models/produto_model.dart';
import 'package:contacts_app/app/data/repositories/produto_repository.dart';
import 'package:flutter/material.dart';

class ProdutoStore{

   final IProdutoRepository repository;

  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);

  final ValueNotifier<List<ProdutoModel>> state =
   ValueNotifier<List<ProdutoModel>> ([]);

   final ValueNotifier<String> erro = ValueNotifier<String> ('');

   ProdutoStore({required this.repository});

   Future getProdutos() async {
    isLoading.value = true;

    try {
     final result = await repository.getProdutos();

     state.value = result;
    } on NotFoundException catch(e) {
      erro.value = e.message;
    }
    catch (e) {
      erro.value =e.toString();
    }
    isLoading.value = false;
   }
}