import QtQuick 2.7
import QtQml.Models 2.3
import QtQuick.Controls 2.2

Item {
    id:timetable

    property real detailsOpacity: 0
    property int daytab: sw.currentIndex

    //x: 5
    width: listView.width-10
    height: 40
    clip:true


    Rectangle {
        id: background
        x: 2; y: 2; width: parent.width - x*2; height: parent.height - y*2
        color: "#cccccc"
        border.color: "orange"
        radius: 5
    }




    MouseArea{
        anchors.fill: parent
        onClicked: {

            timetable.state = (detailsOpacity===0)?'Details':''
        }

    }


    Row {
        id: row1
        spacing: 10

        Rectangle {
            width: 40
            height: 40
            color: "#8c8c8c"


        }

        Text {

            text: name
            font.bold: true
            anchors.verticalCenter: parent.verticalCenter

        }
        Text {

            text: name
            font.bold: true
            anchors.verticalCenter: parent.verticalCenter
        }
    }

    Item{
        id:details
        clip: true
        x:10;
        width: listView.width-10
        height:listView.height
        anchors { top: row1.bottom;
            //topMargin: 10; bottom: parent.bottom;
            //bottomMargin: 10
        }
        opacity: timetable.detailsOpacity
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


Repeater{
                id:t
                model: ["Κυριακή","Δευτέρα","Τρίτη","Τετάρτη","Πέμπτη","Παρασκευή","Σάββατο"]
                anchors.fill: parent


                       Page{
                           property int pindex: index
                            id:pg
                            width:sw.width
                            height:sw.height



                            TechListDelegateFlickable{
                                //y:130
                                width: parent.width
                                //height:600
                                height:parent.height
                            }

                  }





                }

            }






    }




    states: State {
        name: "Details"

        //PropertyChanges { target: background; color: "white" }
        //PropertyChanges { target: recipeImage; width: 130; height: 130 } // Make picture bigger
        PropertyChanges { target: timetable; detailsOpacity: 1; x: 0 } // Make details visible
        PropertyChanges { target: timetable; height: listView.height } // Fill the entire list area with the detailed view

        // Move the list so that this item is at the top.
        PropertyChanges { target: timetable.ListView.view; explicit: true; contentY: timetable.y }

        // Disallow flicking while we're in detailed view
        PropertyChanges { target: timetable.ListView.view; interactive: false }
    }

    transitions: Transition {
        // Make the state changes smooth
        ParallelAnimation {
            ColorAnimation { property: "color"; duration: 500 }
            NumberAnimation { duration: 300; properties: "detailsOpacity,x,contentY,height,width" }
        }
    }



}


