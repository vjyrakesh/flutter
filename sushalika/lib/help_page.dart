import 'package:flutter/material.dart';

class HelpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Help'),
      ),
      body: Container(

        padding: EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(

            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 5.0),
                child: Text('Sushalika\n', style: TextStyle(fontSize: 32.0, fontFamily: 'Amperzand'),),
              ),

              Text('Sushalika is an app to simplify making shopping lists. In this page you will find information about how to use this app.\n', style: TextStyle(fontSize: 16.0),),
              Text('View shopping lists', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),),
              Text('Launching the app will take you to the home page of the app which is the \'Shopping Lists\' page.'
                  'Here you will find all the shopping lists you have created to far.', style: TextStyle(fontSize: 16.0),),
//
              Image.asset('assets/shopping_lists.png', width: 480.0, height: 720.0, fit: BoxFit.contain,),
              Text('Create new shopping list', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),),
              Text('To create a new shopping list, click the \'+\' button in the bottom right area of the page.'
                  'This will take you to the \'Items\' page where you can add items to your shopping list.\n\n', style: TextStyle(fontSize: 16.0),),
              Text('Adding items to list', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),),
              Text('To start adding items to the list, tap on any item. This will pop up a dialog asking for the quantity of that item.'
                  'Enter the quantity you need in the dialog and tap \'Save\'. You will see the quantity updated below the name of the item.'
                  'You will also notice the icon to the right of the item name turn green, indicating that the item has been added to the list.\n'
                  'Once you\'re done adding the items, you can tap the check mark button on the top right corner of the screen to save the list.'
                  'Tapping this button will pop up a dialog asking for the name of the shopping list. Enter the name of the list and tap \'Save\'.'
                  'This will save the list with the items you selected and take you to the shopping lists page where you will see your newly added list.', style: TextStyle(fontSize: 16.0), softWrap: true,),
              Image.asset('assets/add_list_items.png', width: 480.0, height: 720.0, fit: BoxFit.contain,),
              Text('View items in shopping list', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),),
              Text('Tap a shopping list to see the items that have been added to that list.', style: TextStyle(fontSize: 16.0),),
              Image.asset('assets/view_list_items.png', width: 480.0, height: 720.0, fit: BoxFit.contain,),
              Text('Remove item from list', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),),
              Text('To remove an item from a list, swipe an item to the right.\n\n', style: TextStyle(fontSize: 16.0),),
              Text('View all items', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),),
              Text('To view all the items that you can add in a shopping list, tap the button on the top left corner in the \'Shopping Lists\' page.'
                  'This will open up a drawer where you can see a list of menu items. Tap on \'All Items\' item. '
                  'This will take you to a list of all items currently available in the application.', style: TextStyle(fontSize: 16.0),),
              Image.asset('assets/all_items.png', width: 480.0, height: 720.0, fit: BoxFit.contain,),
              Text('Add new item', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),),
              Text('To add a new item, click the \'+\' button in the bottom right corner of the page. This will bring up a pop up enter the name of the item.'
                  'Enter the name of the item and tap \'Save\' to save the item to the application. This item will be shown in the list of items hereafter.', style: TextStyle(fontSize: 16.0),),
              Image.asset('assets/add_new_item.png', width: 480.0, height: 720.0, fit: BoxFit.contain,),
            ],
          ),
        )

      ),
    );
  }
}