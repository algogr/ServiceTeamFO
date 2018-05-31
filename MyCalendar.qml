import QtQuick 2.7
//import QtQuick.Controls 2.2
import QtQuick.Dialogs 1.2
import QtGraphicalEffects 1.0
import QtQuick.Controls 1.2
import QtQuick.Controls 2.2
import QtQuick.Controls.Private 1.0
import QtQuick.Controls.Styles 1.1
import QtQml.Models 2.3

Item {
    property date rdate: new Date()


    Row{
        anchors.fill: parent
        spacing: 10
        anchors.topMargin: 10
        anchors.bottomMargin: 10
        Rectangle{
                       id: calrect
                       width: parent.width/2
                       height: parent.height

                       //anchors.horizontalCenter: parent.horizontalCenter
                       border.width: 0

                       Calendar {
                           id: calendar
                           anchors.fill: parent
                           anchors.leftMargin: 10
                           frameVisible: true
                           weekNumbersVisible: true
                           selectedDate: new Date()
                           focus: true
                           onSelectedDateChanged:{
                               rdate=selectedDate
                               console.log(rdate)
                               }


                           style: CalendarStyle {
                               dayDelegate: Item {
                                   readonly property color sameMonthDateTextColor: "#444"
                                   readonly property color selectedDateColor: Qt.platform.os === "osx" ? "#3778d0" : "#3778d0"
                                   readonly property color selectedDateTextColor: "white"
                                   readonly property color differentMonthDateTextColor: "#bbb"
                                   readonly property color invalidDatecolor: "#dddddd"

                                   Rectangle {
                                       anchors.fill: parent
                                       border.color: "transparent"

                                       color: styleData.date !== undefined && styleData.selected ? selectedDateColor : "#f2f2f2"
                                       anchors.margins: styleData.selected ? -1 : 0
                                   }



                                   Label {
                                       id: dayDelegateText
                                       text: styleData.date.getDate()
                                       anchors.centerIn: parent
                                       color: {
                                           var color = invalidDatecolor;
                                           if (styleData.valid) {
                                               // Date is within the valid range.
                                               color = styleData.visibleMonth ? sameMonthDateTextColor : differentMonthDateTextColor;
                                               if (styleData.selected) {
                                                   color = selectedDateTextColor;
                                               }
                                           }
                                           color;
                                       }
                                   }


                               }
                           }
                       }




                   }

Column{
    width: parent.width/2
    height: parent.height
        Rectangle{

            width:  parent.width
            height: parent.height/2
            Column{
                anchors.fill: parent
                Rectangle {
                               id: eventListHeader
                               width:  parent.width/2
                               height: parent.height
                               anchors.horizontalCenter: parent.horizontalCenter


                               Row {
                                   id: eventDateRow
                                   width: parent.width
                                   height: eventDayLabel.height
                                   spacing: 30

                                   Label {
                                       id: eventDayLabel
                                       text: calendar.selectedDate.getDate()
                                       font.pointSize: 35
                                   }

                                   Column {
                                       height: eventDayLabel.height


                                       Label {
                                           readonly property var options: { weekday: "long" }
                                           text: Qt.locale().standaloneDayName(calendar.selectedDate.getDay(), Locale.LongFormat)
                                           font.pointSize: 18
                                       }
                                       Label {
                                           text: Qt.locale().standaloneMonthName(calendar.selectedDate.getMonth())
                                                 + calendar.selectedDate.toLocaleDateString(Qt.locale(), " yyyy")
                                           font.pointSize: 12
                                       }


                                   }

                               }
                           }

Rectangle{
    width: parent.width
    height: parent.height/2
    Text{
        id:time
        anchors.centerIn: parent
        text:""
        font.pointSize: 35

    }
    Timer {
            interval: 1000; running: true; repeat: true
            onTriggered: {
                var dd=new Date()
                var hours=dd.getHours()
                var minutes=dd.getMinutes()
                var seconds=dd.getSeconds()
                if (hours<10)
                    hours="0"+hours
                if (minutes<10)
                    minutes="0"+minutes
                if (seconds<10)
                    seconds="0"+seconds
                time.text= hours+":"+minutes+":"+seconds

        }
}
}


        }







    }

}




}

}
