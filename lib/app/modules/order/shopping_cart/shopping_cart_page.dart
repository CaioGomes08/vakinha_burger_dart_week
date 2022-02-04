import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:vakinha_burger/app/core/ui/formatter_helper.dart';
import 'package:vakinha_burger/app/core/ui/widgets/plus_minus_box.dart';
import 'package:vakinha_burger/app/core/ui/widgets/vakinha_button.dart';
import 'package:validatorless/validatorless.dart';
import './shopping_cart_controller.dart';

class ShoppingCartPage extends GetView<ShoppingCartController> {
  ShoppingCartPage({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, contraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: contraints.maxHeight,
              minWidth: contraints.maxWidth,
            ),
            child: IntrinsicHeight(
              child: Form(
                key: _formKey,
                child: Visibility(
                  visible: controller.products.isNotEmpty,
                  replacement: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Carrinho',
                          style: context.textTheme.headline6!.copyWith(
                            fontWeight: FontWeight.bold,
                            color: context.theme.primaryColorDark,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'Nenhum item adicionado no carrinho!',
                        ),
                      ],
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Row(
                          children: [
                            Text(
                              'Carrinho',
                              style: context.textTheme.headline6!.copyWith(
                                fontWeight: FontWeight.bold,
                                color: context.theme.primaryColorDark,
                              ),
                            ),
                            IconButton(
                              onPressed: controller.clear,
                              icon: const Icon(
                                Icons.delete_outline,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Obx(() {
                        return Column(
                          children: controller.products
                              .map(
                                (p) => Container(
                                  margin: const EdgeInsets.all(10),
                                  child: PlusMinusBox(
                                    label: p.product.name,
                                    calculateTotal: true,
                                    elevated: true,
                                    backgroundColor: Colors.white,
                                    quantity: p.quantity,
                                    price: p.product.price,
                                    minusCallback: () {
                                      controller.subtractQuantityInProduct(p);
                                    },
                                    plusCallback: () {
                                      controller.addQuantityInProduct(p);
                                    },
                                  ),
                                ),
                              )
                              .toList(),
                        );
                      }),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total do pedido',
                              style: context.textTheme.headline6!.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Obx(() {
                              return Text(
                                FormatterHelper.formatCurrency(
                                    controller.totalValue),
                                style: context.textTheme.headline6!.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              );
                            })
                          ],
                        ),
                      ),
                      const Divider(),
                      const _AddressField(),
                      const Divider(),
                      const _CpfField(),
                      const Divider(),
                      const Spacer(),
                      Center(
                        child: SizedBox(
                          child: VakinhaButton(
                            onPressed: () {
                              final formValid =
                                  _formKey.currentState?.validate() ?? false;

                              if (formValid) {
                                controller.createOrder();
                              }
                            },
                            height: 50,
                            width: context.widthTransformer(reducedBy: 10),
                            label: 'Finalizar',
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _AddressField extends GetView<ShoppingCartController> {
  const _AddressField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 35,
            child: Text(
              'Endereço de entrega',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 18),
            ),
          ),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            onChanged: (value) {
              controller.address = value;
            },
            validator: Validatorless.required('Endereço obrigatório'),
            decoration: const InputDecoration(
              hintText: 'Digite o endereço',
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}

class _CpfField extends GetView<ShoppingCartController> {
  const _CpfField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 35,
            child: Text(
              'CPF',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 18),
            ),
          ),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            onChanged: (value) {
              controller.cpf = value;
            },
            validator: Validatorless.multiple([
              Validatorless.required('CPF obrigatório'),
              Validatorless.cpf('CPF inválido'),
            ]),
            decoration: const InputDecoration(
              hintText: 'Digite o CPF',
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
