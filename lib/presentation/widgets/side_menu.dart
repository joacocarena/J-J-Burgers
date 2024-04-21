import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SideMenu extends ConsumerStatefulWidget {
  
  final GlobalKey<ScaffoldState> scaffoldKey;
  
  const SideMenu(this.scaffoldKey, {super.key});

  @override
  SideMenuState createState() => SideMenuState();
}

class SideMenuState extends ConsumerState<SideMenu> {
  
  int navDrawerIndex = 0;
  
  @override
  Widget build(BuildContext context) {
    final hasNotch = MediaQuery.of(context).viewPadding.top > 35;
    final textStyles = Theme.of(context).textTheme;
  
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const SizedBox(height: 60),

          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 16, 10),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Column(
                children: [
                  Text('Hola!', style: textStyles.headlineLarge),
                  Text('Joaquin', style: textStyles.headlineSmall),
                ],
              ),
            )
          ),
          const SizedBox(height: 10),
          ListTile(
            leading: const Icon(Icons.home_rounded, size: 30),
            title: Text('Productos', style: textStyles.bodyLarge),
            onTap: () => context.pop(),
          ),

          const Divider(),
          const SizedBox(height: 15),

          ListTile(
            leading: const Icon(Icons.location_on_rounded, size: 30),
            title: Text('Encontranos', style: textStyles.bodyLarge),
            onTap: () => context.push('/location'),
          ),
          const SizedBox(height: 15),
          ListTile(
            leading: const Icon(Icons.wallet_rounded, size: 30),
            title: Text('Mis pedidos', style: textStyles.bodyLarge),
            onTap: () => context.push('/orders'),
          ),
          const SizedBox(height: 15),
          ListTile(
            leading: const Icon(Icons.card_giftcard_rounded, size: 30),
            title: Text('Mis cupones', style: textStyles.bodyLarge),
            onTap: () => context.push('/cupons'),
          ),
          const SizedBox(height: 15),
          ListTile(
            leading: const Icon(Icons.person, size: 30),
            title: Text('Mi cuenta', style: textStyles.bodyLarge),
            onTap: () => context.push('/account'),
          ),
        ],
      ),
    );
  }
}