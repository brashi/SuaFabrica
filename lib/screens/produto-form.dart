import 'dart:io';

import 'package:suafabrica/model/produto.dart';
import 'package:suafabrica/controller/produto-controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductFormPage extends StatefulWidget {
  const ProductFormPage({Key? key}) : super(key: key);

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final _comprimentoFocus = FocusNode();
  final _alturaFocus = FocusNode();
  final _larguraFocus = FocusNode();

  final _descriptionFocus = FocusNode();

  final _imageUrlFocus = FocusNode();
  final _imageUrlController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _formData = Map<String, Object>();

  @override
  void initState() {
    super.initState();
    _imageUrlFocus.addListener(updateImage);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_formData.isEmpty) {
      final arg = ModalRoute.of(context)?.settings.arguments;

      if (arg != null) {
        final product = arg as Produto;
        _formData['id'] = product.id;
        _formData['nome'] = product.nome;
        _formData['imagem'] = product.imagemArquivo;
        _formData['descricao'] = product.descricao;
        _formData['comprimento'] = product.comprimento;
        _formData['largura'] = product.largura;
        _formData['altura'] = product.altura;

        _imageUrlController.text = product.imagemArquivo;
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    _comprimentoFocus.dispose();
    _alturaFocus.dispose();
    _larguraFocus.dispose();
    _descriptionFocus.dispose();

    _imageUrlFocus.removeListener(updateImage);
    _imageUrlFocus.dispose();
  }

  void updateImage() {
    setState(() {});
  }

  bool isValidImageUrl(String url) {
    //bool isValidUrl = Uri.tryParse(url)?.hasAbsolutePath ?? false;
    bool endsWithFile = url.toLowerCase().endsWith('.png') ||
        url.toLowerCase().endsWith('.jpg') ||
        url.toLowerCase().endsWith('.jpeg');
    return endsWithFile;
  }

  void _submitForm() {
    final isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) {
      return;
    }

    _formKey.currentState?.save();
    Provider.of<ProdutoController>(
      context,
      listen: false,
    ).saveProduto(_formData).then((value) {
      Navigator.of(context).pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Formulário de Produto'),
        actions: [
          IconButton(
            onPressed: _submitForm,
            icon: Icon(Icons.save),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                initialValue: _formData['nome']?.toString(),
                decoration: InputDecoration(
                  labelText: 'Nome',
                ),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_comprimentoFocus);
                },
                onSaved: (name) => _formData['nome'] = name ?? '',
                validator: (_name) {
                  final name = _name ?? '';

                  if (name.trim().isEmpty) {
                    return 'Nome é obrigatório';
                  }

                  if (name.trim().length < 3) {
                    return 'Nome precisa no mínimo de 3 letras.';
                  }

                  return null;
                },
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextFormField(
                      initialValue: _formData['comprimento']?.toString(),
                      decoration: InputDecoration(labelText: 'Comprimento'),
                      textInputAction: TextInputAction.next,
                      focusNode: _comprimentoFocus,
                      keyboardType: TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_larguraFocus);
                      },
                      onSaved: (comprimento) => _formData['comprimento'] =
                          double.parse(comprimento ?? '0'),
                      validator: (_comprimento) {
                        final comprimentoString = _comprimento ?? '';
                        final comprimento =
                            double.tryParse(comprimentoString) ?? -1;

                        if (comprimento <= 0) {
                          return 'Informe um comprimento válido.';
                        }

                        return null;
                      },
                    ),
                  ),
                  Expanded(
                    child: TextFormField(
                      initialValue: _formData['largura']?.toString(),
                      decoration: InputDecoration(labelText: 'Largura'),
                      textInputAction: TextInputAction.next,
                      focusNode: _larguraFocus,
                      keyboardType: TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_alturaFocus);
                      },
                      onSaved: (largura) =>
                          _formData['largura'] = double.parse(largura ?? '0'),
                      validator: (_largura) {
                        final larguraString = _largura ?? '';
                        final largura = double.tryParse(larguraString) ?? -1;

                        if (largura <= 0) {
                          return 'Informe uma largura válido.';
                        }

                        return null;
                      },
                    ),
                  ),
                  Expanded(
                    child: TextFormField(
                      initialValue: _formData['altura']?.toString(),
                      decoration: InputDecoration(labelText: 'Altura'),
                      textInputAction: TextInputAction.next,
                      focusNode: _alturaFocus,
                      keyboardType: TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_descriptionFocus);
                      },
                      onSaved: (altura) =>
                          _formData['altura'] = double.parse(altura ?? '0'),
                      validator: (_altura) {
                        final alturaString = _altura ?? '';
                        final altura = double.tryParse(alturaString) ?? -1;

                        if (altura <= 0) {
                          return 'Informe uma altura válido.';
                        }

                        return null;
                      },
                    ),
                  ),
                ],
              ),
              TextFormField(
                initialValue: _formData['descricao']?.toString(),
                decoration: InputDecoration(labelText: 'Descrição'),
                focusNode: _descriptionFocus,
                keyboardType: TextInputType.multiline,
                maxLines: 3,
                onSaved: (description) =>
                    _formData['descricao'] = description ?? '',
                validator: (_description) {
                  final description = _description ?? '';

                  if (description.trim().isEmpty) {
                    return 'Descrição é obrigatória.';
                  }

                  if (description.trim().length < 10) {
                    return 'Descrição precisa no mínimo de 10 letras.';
                  }

                  return null;
                },
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(labelText: 'Url da Imagem'),
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.done,
                      focusNode: _imageUrlFocus,
                      controller: _imageUrlController,
                      onFieldSubmitted: (_) => _submitForm(),
                      onSaved: (imageUrl) =>
                          _formData['imagem'] = imageUrl ?? '',
                      validator: (_imageUrl) {
                        final imageUrl = _imageUrl ?? '';

                        if (!isValidImageUrl(imageUrl)) {
                          return 'Informe uma Url válida!';
                        }

                        return null;
                      },
                    ),
                  ),
                  Container(
                    height: 100,
                    width: 100,
                    margin: const EdgeInsets.only(
                      top: 10,
                      left: 10,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: _imageUrlController.text.isEmpty
                        ? Text('Informe a Url')
                        : Image.file(File(_imageUrlController.text)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
