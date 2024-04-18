import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:jj_burgers/presentation/models/burger_model.dart';
import 'package:jj_burgers/presentation/providers/cart_provider.dart';
import 'package:jj_burgers/presentation/widgets/side_menu.dart';
import 'dart:convert';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final scaffoldKey = GlobalKey<ScaffoldState>();
  late CartNotifier cart;
  List<dynamic> data = [];
  bool isDataLoaded = false;
  List<dynamic> burgerData = [];
  bool hayProdEnCarro = false;

  getBurgers() async {
    Uri url = Uri.parse('http://192.168.0.132:4000/api/burgers');
    http.Response response = await http.get(url);
    List<dynamic> responseData = json.decode(response.body);
    
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('burgerData', json.encode(responseData));
    
    setState(() {
      burgerData = responseData;
    });
  }

  void addToCart(Burger burger) {
    setState(() {
      cart.addItem(burger);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Añadiste ${burger.name} al carrito!"),
        duration: const Duration(seconds: 2),
      )
    );
    hayProdEnCarro = true;
  }

  void loadBurgers() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? burgerDataString = prefs.getString('burgerData');
    if (burgerDataString != null) {
      setState(() {
        burgerData = json.decode(burgerDataString);
      });
    } else {
      getBurgers();
    }
  }

  @override
  void initState() {
    super.initState();
    loadBurgers();
    cart = Provider.of<CartNotifier>(context, listen: false);
    // getBurgers();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideMenu(scaffoldKey),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: [
          Consumer<CartNotifier>(
            builder: (context, cart, _) {
              return IconButton(
                onPressed: () => context.push('/cart'), 
                icon: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                  child: Stack(
                    children: [
                      FaIcon(
                        FontAwesomeIcons.cartShopping, 
                        size: 28, 
                        color: Theme.of(context).primaryColor,
                      ),
                      if (cart.itemLength > 0)
                        Positioned(
                          right: 0,
                          bottom: 15,
                          child: Container(
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(18)
                            ),
                            constraints: const BoxConstraints(
                              minHeight: 15,
                              minWidth: 15
                            ),
                            child: Text(
                              cart.items.length.toString(),
                              style: const TextStyle(
                                color: Colors.white, 
                                fontSize: 10, 
                                fontWeight: FontWeight.bold
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                    ]
                  ),
                )
              );
            },
          )
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 15),
          const Row(
            children: [
              SizedBox(width: 15),
              Text('¿Y si te das un gustito?', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30), textAlign: TextAlign.start),
            ],
          ),
          const SizedBox(height: 5),
          const Center(child: SearchBar()),
          const SizedBox(height: 25),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: SizedBox(
                height: MediaQuery.of(context).size.width,
                
                child: CustomScrollView(
                  slivers: [
                    SliverGrid(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 20,
                        childAspectRatio: 0.66
                      ),
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          return Card(
                            elevation: 3,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Column(
                                children: [
                                  AspectRatio(
                                    aspectRatio: 16/9,
                                    child: Image.asset('assets/images/${burgerData[index]['name']}.png', fit: BoxFit.cover),
                                  ),
                                  Center(
                                    child: Column(
                                      children: [
                                        const SizedBox(height: 8),
                                        Text(burgerData[index]['name'], style: const TextStyle(fontSize: 20.5, fontWeight: FontWeight.w500)),
                                        const SizedBox(height: 5),
                                        Text(burgerData[index]['description'], style: const TextStyle(fontSize: 16), textAlign: TextAlign.center),
    
                                        const SizedBox(height: 10),
    
                                        Column(
                                          children: [
                                            Text('\$${burgerData[index]['price']}', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: Colors.orange.shade400)),
                                            FilledButton(
                                              onPressed: () {
                                                addToCart(
                                                  Burger(
                                                    name: burgerData[index]['name'],
                                                    description: burgerData[index]['description'],
                                                    price: double.parse(burgerData[index]['price'].toString()),
                                                  )
                                                );
    
                                              }, 
                                                
                                              style: ButtonStyle(
                                                shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                                                backgroundColor: MaterialStateProperty.all(const Color.fromRGBO(239, 161, 53, 0.678))
                                              ), 
                                              child: const Text('Agregar', style: TextStyle(fontSize: 18)),
                                            )
                                          ],
                                        ),
                                        
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                        childCount: burgerData.length,
                      ), 
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      )
    );
  }
}

class SearchBar extends StatefulWidget {
  const SearchBar({super.key});

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: TextField(
            controller: _controller,
            decoration: InputDecoration(
              hintText: 'Buscar...',
              hintStyle: const TextStyle(color: Colors.grey),
              suffixIcon: IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () => _controller.clear(),
              ),
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Theme.of(context).primaryColor)
              )
            ),
            onChanged: (value) {
              //! ACCIONES EN LA BUSQUEDA...
            },
          ),
        ),
      ),
    );
  }
}