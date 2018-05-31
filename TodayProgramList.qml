import QtQuick 2.7
import QtQuick.Controls 2.2
import QtQuick.Controls 1.4
import QtGraphicalEffects 1.0

Item {


    Page{

         id:pg
         width:rootrect.width
         height:rootrect.height
         signal modelChange()
         property alias seldate: cal.rdate

         LinearGradient {
                anchors.fill: parent
                start: Qt.point(0, 0)
                end: Qt.point(0, 300)
                gradient: Gradient {
                    GradientStop { position: 0.0; color: "#e6e6e6" }
                    GradientStop { position: 1.0; color: "#333333" }
                }
            }

Column{
         Rectangle{
             width:rootrect.width
             height:rootrect.height*3/10
             MyCalendar{
                 id:cal
                 anchors.fill: parent
             }
         }

         ListView{
             id:listView
             model:techModel
             width:rootrect.width
             height:rootrect.height*7/10

             clip: true
             delegate: TodayProgramListDelegate{
                 id:dpld

             }
             Timer {
                     interval: 10000; running: true; repeat: true
                     onTriggered: {

                         ticketModel.select()
                         ticketModel.setSort(27,Qt.AscendingOrder)
                         ticketModel.select()
                         //ticketModel.setFilter("status in (1,2,3)")
                         //console.log(pg.seldate.getFullYear()+"-"+(pg.seldate.getMonth()+1)+"-"+pg.seldate.getDate())
                         //ticketModel.setFilter("date(appointmentfrom)='"+pg.seldate.getFullYear()+"-"+pg.seldate.getMonth()+1+"-"+pg.seldate.getDate())+"'"
                         //ticketModel.setFilter("date(appointmentfrom)='"+pg.seldate.setHours(0,0,0,0))
                         pg.modelChange()

                 }
         }



}

}
onSeldateChanged: {
    pg.modelChange()

}
}
    Component.onCompleted: {

        ticketModel.setSort(27,Qt.AscendingOrder)
        ticketModel.select()
        //ticketModel.setFilter("status in (1,2,3)")
        //ticketModel.setFilter("date(appointmentfrom)="+new Date().setHours(0,0,0,0))
    }

}
