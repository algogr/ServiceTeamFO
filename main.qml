import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.2
import QtQuick.Dialogs 1.2
import QtGraphicalEffects 1.0



ApplicationWindow {
    id:aw
    visible: true
    width: 1024
    height: 768
    title: qsTr("ServiceTeamFO")



    header: ToolBar {


        RowLayout {
            spacing: 20
            anchors.fill: parent

            ToolButton {
               id:tb
                contentItem: Image {
                    fillMode: Image.Pad
                    horizontalAlignment: Image.AlignHCenter
                    verticalAlignment: Image.AlignVCenter
                    source:  "images/drawer.png"
                }
                onClicked:{
                                        drawer.open()

                }
            }

            Label {
                id: titleLabel
                text:  "ServiceTeamFO"
                font.pixelSize: 20
                elide: Label.ElideRight
                horizontalAlignment: Qt.AlignHCenter
                verticalAlignment: Qt.AlignVCenter
                Layout.fillWidth: true
            }

            ToolButton {
                contentItem: Image {
                    fillMode: Image.Pad
                    horizontalAlignment: Image.AlignHCenter
                    verticalAlignment: Image.AlignVCenter
                    source: "images/menu.png"
                }
                onClicked: optionsMenu.open()

                Menu {
                    id: optionsMenu
                    x: parent.width - width
                    transformOrigin: Menu.TopRight

                    MenuItem {
                        text: "Settings"
                        onTriggered: stackView.push("Settings.qml")

                    }
                    MenuItem {
                        text: "About"
                        onTriggered: aboutDialog.open()
                    }
                }
            }
        }
    }
    Drawer {
        id: drawer
        width: Math.min(aw.width,aw.height) / 3 * 2
        height: aw.height
        dragMargin: stackView.depth > 1 ? 0 : undefined

        ListView {
            id: listView

            focus: true
            currentIndex: -1
            anchors.fill: parent

            delegate: ItemDelegate {
                width: parent.width
                text: model.title
                highlighted: ListView.isCurrentItem
                onClicked: {

                    listView.currentIndex = index
                    var t=model.paramname
                    var u=model.paramvalue

                    stackView.push(model.source)

/*
                    if(model.menuno==1)
                        stackView.push(model.source,{taskid:0}) //to push sikonei parameters
                    else
                        stackView.push(model.source) //to push sikonei parameters
*/
                    drawer.close()
                }
            }

            model: ListModel {
                ListElement { title:"Τεχνικοί"; source: "qrc:/Technician.qml"}
                ListElement { title:"Ανάθεση περιοχών σε τεχνικούς"; source: "qrc:/TechDistrict.qml"}

            }

            ScrollIndicator.vertical: ScrollIndicator { }
        }
    }
StackView{
    id: stackView
    anchors.fill: parent
    initialItem:
    //SwipeView {
      //  id: swipeView
        //anchors.fill: parent
        //currentIndex: tabBar.currentIndex

        Page2 {
        }

        //Page1 {






        //}
    //}
}

}
