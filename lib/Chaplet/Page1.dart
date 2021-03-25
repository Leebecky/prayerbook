import 'package:flutter/material.dart';
import 'package:prayerbook/CustomWidget/customListTile.dart';
import 'Page2.dart';
import 'Page3.dart';

class Chaplet extends StatelessWidget {
  final PageController chapletCtrl = PageController();
  final ScrollController intercessionCtrl = ScrollController();
  final PageController pageCtrl;
  final ValueNotifier<int> intercessionIndex = ValueNotifier<int>(0);

  Chaplet(this.pageCtrl);

  @override
  Widget build(BuildContext context) {
    List<Widget> chapletPages = [
      FirstPage(intercessionIndex, intercessionCtrl),
      SecondPage(),
      ThirdPage()
    ];

    return Scaffold(
        appBar: AppBar(
          title: Text("St Michael's Chaplet"),
        ),
        body: GestureDetector(
          onTap: () {
            //^  If we are still on the first page:
            if (chapletCtrl.page == 0) {
              //^ Go to next intercession if its not completed, else go to the next page
              (intercessionIndex.value <= 8)
                  ? intercessionCtrl.jumpTo(MediaQuery.of(context).size.width *
                      intercessionIndex.value)
                  : chapletCtrl.nextPage(
                      duration: Duration(milliseconds: 1),
                      curve: Curves.linear);

              //^ Increments the intercesionIndex when at 8 (cuz it starts at 0)
              if (intercessionIndex.value == 8) {
                intercessionIndex.value++;
              }
            } else if (chapletCtrl.page != (chapletPages.length - 1)) {
              chapletCtrl.nextPage(
                  duration: Duration(milliseconds: 1), curve: Curves.linear);
            } else {
              //^  Once done with the Chaplet, move on to the next page (Litany)
              pageCtrl.nextPage(
                  duration: Duration(milliseconds: 1), curve: Curves.linear);
            }
          },
          child: PageView(
            controller: chapletCtrl,
            children: chapletPages,
          ),
        ));
  }
}

//~  Chaplet first page - Intercessions
class FirstPage extends StatelessWidget {
  final ScrollController intercessionCtrl;
  final ValueNotifier intercessionIndex;
  FirstPage(this.intercessionIndex, this.intercessionCtrl);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            height: 20,
          ),
          Text(
            "O God, come to my assistance. O Lord, make haste to help me.",
            style: headingStyle,
          ),
          Text(
            "Glory be to the Father...",
            style: headingStyle,
          ),
          Text(
            "[Say 1 Our Father and 3 Hail Marys after each of the following salutation in honour of the nine choirs of Angels]",
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(
            height: 150,
          ),
          //~ Intercessions
          Expanded(
            child: ListView.builder(
                controller: intercessionCtrl,
                scrollDirection: Axis.horizontal,
                itemCount: intercessions.length,
                itemBuilder: (context, int i) {
                  intercessionIndex.value = i;

                  return Container(
                      width: MediaQuery.of(context).size.width,
                      child: intercessions[i]);
                }),
          ),
        ],
      ),
    );
  }

  final List<Widget> intercessions = [
    customListTile(
        title:
            "1. By the intercession of St. Michael and the celestial Choir of Seraphim, may the Lord make us worthy to burn with the fire of perfect charity.",
        subtitle: "Amen"),
    customListTile(
      title:
          "2. By the intercession of St. Michael and the celestial Choir of Cherubim, may the Lord grant us the grace to leave the ways of sin and run in the paths of Christian perfection.",
      subtitle: "Amen",
    ),
    customListTile(
        title:
            "3. By the intercession of St. Michael and the celestial Choir of Thrones, may the Lord infuse into our hearts a true and sincere spirit of humility.",
        subtitle: "Amen"),
    customListTile(
        title:
            "4. By the intercession of St. Michael and the celestial Choir of Dominations, may the Lord give us grace to govern our senses and overcome any unruly passions.",
        subtitle: "Amen"),
    customListTile(
        title:
            "5. By the intercession of St. Michael and the celestial Choir of Virtues, may the Lord preserve us from evil and falling into temptation.",
        subtitle: "Amen"),
    customListTile(
        title:
            "6. By the intercession of St. Michael and the celestial Choir of Powers, may the Lord protect our souls against the snares and temptations of the devil.",
        subtitle: "Amen"),
    customListTile(
        title:
            "7. By the intercession of St. Michael and the celestial Choir of Pricipalities, may God fill our souls with a true spirit of obedience.",
        subtitle: "Amen"),
    customListTile(
        title:
            "8. By the intercession of St. Michael and the celestial Choir of Archangels, may the Lord give us perseverance in faith and in all good works in order that we may attain the glory of heaven.",
        subtitle: "Amen"),
    customListTile(
        title:
            "9. By the intercession of St. Michael and the celestial Choir of Angels, may the Lord grant us to be protected by them in this mortal life and conducted in the life to come to heaven.",
        subtitle: "Amen"),
  ];
}