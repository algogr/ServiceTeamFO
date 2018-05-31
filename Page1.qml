import QtQuick 2.7
import Qt.labs.calendar 1.0
import QtQuick.Controls 2.2
import QtGraphicalEffects 1.0

    Item {

Rectangle{
        id:rootrect
        anchors.fill: parent
        signal mySignal(int ind,int technicianid)
        //color:"#bfbfbf"
        LinearGradient {
               anchors.fill: parent
               start: Qt.point(0, 0)
               end: Qt.point(0, 300)
               gradient: Gradient {
                   GradientStop { position: 0.0; color: "#e6e6e6" }
                   GradientStop { position: 1.0; color: "#333333" }

               }
           }


        TicketList
        {

            id:tickets
            width: parent.width/2
            height: parent.height*2/3


        }


      TechList
      {
            id:techs
            width: parent.width/2
            height: parent.height*2/3
            anchors.left: tickets.right


        }


      DailyProgramList{

          id:daily
          width: parent.width-25
          height: parent.height/3
          anchors.top: tickets.bottom
          anchors.left: parent.left
          anchors.right: parent.right
          anchors.bottom: parent.bottom
          anchors.margins: 25

      }


/*


        Test{
            id:techs
            width: parent.width/2
            height: parent.height
            anchors.left: tickets.right

        }

*/
    }


    }

