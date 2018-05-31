import QtQuick 2.7
import QtQuick.Controls 2.2
import QtGraphicalEffects 1.0
import QtQml.Models 2.3

Item {
    property date seldate: new Date()
    property int seltechid: 0
    Page{

         id:pg1
         width:aw.width
         height:aw.height
         signal modelChange()
         property date seldate: new Date()
         property int seltechid: 0
         signal ticketchanged(int tktid)

         LinearGradient {
                anchors.fill: parent
                start: Qt.point(0, 0)
                end: Qt.point(0, 300)
                gradient: Gradient {
                    GradientStop { position: 0.0; color: "#e6e6e6" }
                    GradientStop { position: 1.0; color: "#333333" }
                }
            }
         Row{
         TicketListPageLeft{
             width: pg1.width/2
             height: pg1.height
         }

         TicketListPageRight{
             width: pg1.width/2
             height: pg1.height
         }
         }
    }

}
