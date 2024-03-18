import 'package:flutter/material.dart';
import 'package:heytalkai/Provider/LanguageProvider.dart';
import 'package:heytalkai/Utilities/Constants.dart';
import 'package:provider/provider.dart';

class LanguageBottomSheet extends StatefulWidget {
  final String parameter;
  const LanguageBottomSheet({super.key, required this.parameter});

  @override
  State<LanguageBottomSheet> createState() => _LanguageBottomSheetState();
}

class _LanguageBottomSheetState extends State<LanguageBottomSheet> {
  TextEditingController searchController = TextEditingController();
  String searchQuery = "";
  String chosenLang = "";

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: TextFormField(
              controller: searchController,
              onTapOutside: (e) => FocusScope.of(context).unfocus(),
              onChanged: (value) {
                setState(() {
                  searchQuery = value.toLowerCase();
                });
              },
              decoration: InputDecoration(
                  hintText: "Search language...",
                  prefixIcon: Icon(Icons.translate_outlined,color: Colors.blue,),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)))),
            ),
          ),
          Expanded(
            child: buildSuggestions(searchQuery, languageProvider)
          )
        ],
      ),
    );
  }

  buildSuggestions(String query, LanguageProvider languageProvider) {
    final List<String> suggestionList =
    (query.isEmpty)
        ? languageList
        : languageList.where((e) => e.toLowerCase().contains(query)).toList();

    return ListView.builder(
        padding: EdgeInsets.only(top: 4,left: 26),
        shrinkWrap: true,
        itemCount: suggestionList.length,
        itemBuilder: (context,index){
          return InkWell(
            onTap: (){
              setState(() {
                chosenLang = suggestionList[index];
                (widget.parameter == 'from')?languageProvider.setFromSelectedLanguage(chosenLang):languageProvider.setToSelectedLanguage(chosenLang);
                print(chosenLang);
              });
              Navigator.pop(context);
            },
            child: Padding(
              padding: const EdgeInsets.only(bottom: 18),
              child: Text(suggestionList[index],style: TextStyle(fontSize: 16),),
            ),
          );
        });
  }
}
