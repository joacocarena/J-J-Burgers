import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomAppbar extends StatefulWidget {
  const CustomAppbar({super.key});

  @override
  State<CustomAppbar> createState() => _CustomAppbarState();
}

class _CustomAppbarState extends State<CustomAppbar> {
  @override
  Widget build(BuildContext context) {

    final colors = Theme.of(context).colorScheme;

    return SafeArea(
      bottom: false,
      child: SizedBox(
        width: double.infinity,
        child: Column(
          
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 6, left: 8),
                  child: Row(
                    children: [
                      FaIcon(FontAwesomeIcons.burger, color: colors.secondary, size: 30),
                      const SizedBox(width: 5),
                      const Text('J&J Burgers'),
                    ],
                  ),
                ),
                
                Padding(
                  padding: const EdgeInsets.only(right: 14, top: 6),
                  child: IconButton(
                    onPressed: () {}, 
                    icon: FaIcon(FontAwesomeIcons.cartShopping, color: colors.secondary),
                  ),
                )
              ],
            ),

            const Text('¿Y si te das un gustito?', style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
            const SizedBox(height: 5),
            SearchAnchor(
              builder: (context, controller) {
                return SearchBar(
                  controller: controller,
                  hintText: 'Busca algo...',
                  onTap: () => controller.openView(),
                  onChanged: (_) => controller.openView(),
                  leading: const FaIcon(FontAwesomeIcons.magnifyingGlass),
                );
              }, 
              suggestionsBuilder: (context, controller) {
                return List<ListTile>.generate(3, (index) {
                  final String item = 'item $index';
                  return ListTile(
                    title: Text(item),
                    onTap: () => controller.closeView(item),
                  );
                });
              },
            ),
            
          ],
        ),
      )
    );
  }
}