import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
  
    return NavigationDrawer(
      elevation: 1,
      selectedIndex: navDrawerIndex,
      onDestinationSelected: (value) {
        setState(() {
          navDrawerIndex = value;
        });
        
      },
      children: [
        const SizedBox(height: 20),
        Padding(
          padding: EdgeInsets.fromLTRB(20, hasNotch ? 0 : 20, 16, 0),
          child: Text('Hola!', style: textStyles.headlineLarge ),
        ),

        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 16, 10),
          child: Text('Joaquin', style: textStyles.headlineSmall ),
        ),

        const NavigationDrawerDestination(
            icon: Icon( Icons.home_outlined ), 
            label: Text( 'Productos' ),
        ),


        const Padding(
          padding: EdgeInsets.fromLTRB(28, 16, 28, 10),
          child: Divider(),
        ),

        const Padding(
          padding: EdgeInsets.fromLTRB(28, 10, 16, 10),
          child: Text('Otras opciones'),
        ),

      ] 
    );
  }
}