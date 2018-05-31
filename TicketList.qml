import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3




Item {




        ListView {
            id: listView

            DropArea{
                anchors.fill: parent
                onEntered: {

                    drag.source.caught = true;


                }
                onExited: {
                    drag.source.caught = false;


                }


            }


            anchors.fill: parent
            anchors.margins: 5
            //anchors.bottomMargin: 250
            anchors.rightMargin: 100
            anchors.topMargin: 30
            section.property: "oname"
            clip: true

            section.criteria: ViewSection.FullString
            section.delegate: TicketListSectionDelegate{
                id:test
                width: listView.width
            }

            contentHeight: 200
            model: customerTicketModel

            delegate: TicketListDelegate{
                //anchors.fill: parent
                //anchors.margins: 10


            }
        }

}
