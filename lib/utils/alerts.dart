import 'package:flutter/material.dart';

class Alerts {

  static void addNewCurrencyAlert({required List currentCurrencyList, required List currencyList, required BuildContext context, required Function(String) callback}) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return Dialog(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: GridView.builder(
                    shrinkWrap: true,
                    itemCount: currencyList.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 20,
                        mainAxisExtent: 50),
                    itemBuilder: (context, index) {

                      Color? removeColor = Colors.white;
                      Color? addedColor = Colors.grey[300];
                      bool currencyAddedStatus = currentCurrencyList.contains(currencyList[index]) ? true : false;

                      return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: currencyAddedStatus ? addedColor : removeColor,
                        ),
                        onPressed: () {
                          callback(currencyList[index]);
                          setState(() {
                            currencyAddedStatus = !currencyAddedStatus;
                          });
                        },
                        child: Text(currencyList[index]),
                      );
                    },
                  ),
                ),
              );
            }
          );
        });
  }
}
