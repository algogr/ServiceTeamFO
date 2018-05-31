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




    }

        TodayProgramList{
            anchors.fill: parent
        }

    }
