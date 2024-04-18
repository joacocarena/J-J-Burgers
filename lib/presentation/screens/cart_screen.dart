import 'package:flutter/material.dart';
import 'package:jj_burgers/presentation/providers/cart_provider.dart';
import 'package:provider/provider.dart';

import '../models/burger_model.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartNotifier>(context);
    final List<Burger> items = cart.items;

    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
          width: MediaQuery.of(context).size.width * 0.68,
          child: const Center(
            child: Text('Tu pedido')
          )
        ),
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final burger = items[index];

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            child: Container( //? CARD
              color: Colors.transparent,
              height: 110,
              child: Row(
                children: [
                  SizedBox(
                    height: 100,
                    width: 120,
                    child: Image.asset('assets/images/${burger.name}.png', fit: BoxFit.cover),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 6),
                      child: Column( //? BURGER INFO
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            burger.name, 
                            textAlign: TextAlign.start, 
                            style: const TextStyle(
                              fontSize: 20.5, 
                              fontWeight: FontWeight.w500
                            )
                          ),
                          const SizedBox(height: 2),
                          SizedBox(
                            width: 105,
                            child: Text(
                              burger.description,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w400
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 3,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 100,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '\$${burger.price}', 
                          textAlign: TextAlign.end,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      cart.removeItem(burger);
                      
                    }, 
                    icon: const Icon(Icons.cancel)
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}