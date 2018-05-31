import QtQuick 2.7
import QtQuick.Controls 2.2

Item {
    id:dp

    TabBar {

        id: bar
        clip:true
        width: parent.width
        height: 50

        currentIndex: sw.currentIndex
    Repeater {
        id:ri

        model: ["Κυριακή","Δευτέρα","Τρίτη","Τετάρτη","Πέμπτη","Παρασκευή","Σάββατο"]




        TabButton {
            id:tb


            text: modelData

            width: Math.max(50, (bar.width-20) / 7)
        }

   }
    }
        SwipeView{
            id:sw
            width:parent.width
            y:50
            height:parent.height-50
            currentIndex:  bar.currentIndex
            clip: true


Repeater{
            id:t
            model: ["Κυριακή","Δευτέρα","Τρίτη","Τετάρτη","Πέμπτη","Παρασκευή","Σάββατο"]
            anchors.fill: parent


                   Page{
                       property int pindex: index
                        id:pg
                        width:sw.width
                        height:sw.height


                        ListView{
                            id:listView
                            model:techModel
                            anchors.fill: parent
                            delegate: DailyProgramListDelegate{
                                id:dpld

                            }
                        }


              }





            }

        }

}

