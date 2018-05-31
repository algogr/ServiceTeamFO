import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import Backend 1.0

Item {

    StackLayout {
        id: stackLayout
        anchors.fill: parent

        Item {
        }
    }

    Page {
        id: page
        anchors.rightMargin: 0
        anchors.bottomMargin: 0
        anchors.leftMargin: 0
        anchors.topMargin: 0
        anchors.fill: parent
        TicketModel {
                        id: ticketModel
                           }

        ListView {
            id: listView
            x: 22
            y: 18
            width: 205
            height: 312
            section.property: "address"
            section.criteria: ViewSection.FirstCharacter
            section.delegate: TicketListSectionDelegate{
                id:test
                width: listView.width
            }

            contentHeight: 200
            model: ticketModel

            delegate: Item {
                x: 5
                width: 80
                height: 40
                Row {
                    id: row1
                    spacing: 10
                    Rectangle {
                        width: 40
                        height: 40
                        color: "green"
                    }

                    Text {
                        text: address
                        font.bold: true
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }
            }
        }
    }
}
