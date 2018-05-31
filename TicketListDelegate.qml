import QtQuick 2.7

Item {
            id:ticket

                property real detailsOpacity: 0
                property point beginDrag
                property var rparent: null
                property bool caught: false
                property int ticketid: tid
                property int listindex: listView.currentIndex
                Drag.active: mouseArea.drag.active
                //x: 5
                z: mouseArea.drag.active ||  mouseArea.pressed ? 0 : 1
                width: listView.width
                height: 40
                clip:true




                Rectangle {

                    id: background
                    x: 2; y: 2; width: parent.width - x*2; height: parent.height - y*2
                    anchors.fill: parent
                    color: "#d9e6f2"

                    //border.color: "#d1d1e0"
                    border.color: "orange"
                    radius: 5



                    ParallelAnimation {
                                   id: backAnim
                                   SpringAnimation { id: backAnimX; target: ticket; property: "x"; duration: 100; spring: 2; damping: 0.2 }
                                   SpringAnimation { id: backAnimY; target: ticket; property: "y"; duration: 100; spring: 2; damping: 0.2 }
                               }

                    MouseArea {
                                   id: mouseArea
                                   anchors.fill: parent

                                   drag.target: ticket


                                   onPressed: {

                                       rparent=ticket.parent
                                       listView.currentIndex = index

                                       ticket.beginDrag = Qt.point(ticket.x, ticket.y);
                                       ticket.z=100
                                       ticket.state="reparented"



                                   }
                                   onReleased: {
                                       if(!ticket.caught) {

                                           ticket.state="return"
                                           backAnimX.from = ticket.x;
                                           backAnimX.to = beginDrag.x;
                                           backAnimY.from = ticket.y;
                                           backAnimY.to = beginDrag.y;
                                           backAnim.start()
                                           console.log("Parent:"+ticket.parent)

                                       }
                                       else{
                                           //Update tickets set status=1
                                           ticketModel.setFilter("id="+tid)

                                           var tindex=ticketModel.index(0,16);
                                           var cindex=ticketModel.index(0,17);
                                           ticketModel.select()

                                           ticketModel.setData(tindex,1)
                                           ticketModel.setData(cindex,1)
                                           ticketModel.submitAll()
                                           customerTicketModel.refresh()





                                           ticket.Drag.drop()







                                       }
                                   }

                               }

                }

                Row {
                    id: row1
                    spacing: 10
                    Rectangle {
                        width: 40
                        height: 40
                        color: "#336699"
                        MouseArea{
                            anchors.fill: parent
                            onClicked: {

                                ticket.state = (detailsOpacity===0)?'Details':''
                            }

                        }
                    }

                    Text {
                        text: tincident
                        font.bold: true
                        anchors.verticalCenter: parent.verticalCenter
                    }
                    Text {
                        id:cityt
                        text: ccounty
                        font.bold: true
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }



                Item{
                    id:details
                    x:10;width: parent.width-20
                    anchors { top: row1.bottom;
                        topMargin: 10; bottom: parent.bottom;
                        bottomMargin: 10 }
                    opacity: ticket.detailsOpacity





                    Flickable {
                        id: flick
                        width: parent.width
                        height:parent.height

                        contentHeight: 520


                        clip: true
                        Column{



                        Text {

                                    text: "Title:"+ttitle+"<br>"
                                    font.bold: true
                                    wrapMode: Text.WordWrap
                                    //anchors.verticalCenter: parent.verticalCenter


                                }

                                Text {

                                    text: "Company:"+oname
                                    font.bold: true
                                    wrapMode: Text.WordWrap
                                    //anchors.verticalCenter: parent.verticalCenter
                                }


                                Text {

                                    text: "Service:"+tservice
                                    font.bold: true
                                    wrapMode: Text.WordWrap
                                    //anchors.verticalCenter: parent.verticalCenter
                                }


                                Text {

                                    text: "Service Recipient:"+cname
                                    font.bold: true
                                    wrapMode: Text.WordWrap
                                    //anchors.verticalCenter: parent.verticalCenter
                                }

                                Text {

                                    text: "Location:"+clocation
                                    font.bold: true
                                    wrapMode: Text.WordWrap
                                    //anchors.verticalCenter: parent.verticalCenter
                                }


                                Text {

                                    text: "City:"+ccity
                                    font.bold: true
                                    wrapMode: Text.WordWrap
                                    //anchors.verticalCenter: parent.verticalCenter
                                }

                                Text {

                                    text: "County:"+ccounty
                                    font.bold: true
                                    wrapMode: Text.WordWrap
                                    //anchors.verticalCenter: parent.verticalCenter
                                }

                                Text {

                                    text: "Address:"+caddress
                                    font.bold: true
                                    wrapMode: Text.WordWrap
                                    //anchors.verticalCenter: parent.verticalCenter
                                }

                                Text {

                                    text: "Phone:"+cphone1
                                    font.bold: true
                                    wrapMode: Text.WordWrap
                                    //anchors.verticalCenter: parent.verticalCenter
                                }

                                Text {

                                    text: "Contact Phone:"+cphone2
                                    font.bold: true
                                    wrapMode: Text.WordWrap
                                    //anchors.verticalCenter: parent.verticalCenter
                                }


                                Text {

                                    text: "Priority:"+tpriority
                                    font.bold: true
                                    wrapMode: Text.WordWrap
                                    //anchors.verticalCenter: parent.verticalCenter
                                }

                                Text {

                                    text: "Ticket No."+tcustomerticketno
                                    font.bold: true
                                    wrapMode: Text.WordWrap
                                    //anchors.verticalCenter: parent.verticalCenter
                                }

                                Text {

                                    text: "Appointment:"+tappointmentfrom
                                    font.bold: true
                                    wrapMode: Text.WordWrap
                                    //anchors.verticalCenter: parent.verticalCenter
                                }

                                Text {

                                    text: "Description:"+tdescription
                                    font.bold: true
                                    width: 80
                                    wrapMode: Text.WordWrap
                                    //anchors.verticalCenter: parent.verticalCenter
                                }

}
                    }
                }

                        states: [State {
                            name: "Details"

                            //PropertyChanges { target: background; color: "white" }
                            //PropertyChanges { target: recipeImage; width: 130; height: 130 } // Make picture bigger
                            PropertyChanges { target: ticket; detailsOpacity: 1; x: 0 } // Make details visible
                            PropertyChanges { target: ticket; height: rootrect.height/2 } // Fill the entire list area with the detailed view

                            // Move the list so that this item is at the top.
                            //PropertyChanges { target: ticket.ListView.view; explicit: true; contentY: timetable.y }

                            // Disallow flicking while we're in detailed view
                            PropertyChanges { target: ticket.ListView.view; interactive: false }
                        },

                        State {
                                   name: "reparented"
                                   ParentChange { target: ticket; parent: rootrect }
                               },
                        State {
                                   name: "reparented1"

                                   ParentChange { target: ticket; parent: rootrect}
                                   //PropertyChanges { target: background; color:"red" }


                               },
                            State {
                                       name: "return"

                                       ParentChange { target: ticket; parent:rparent}
                                       //PropertyChanges { target: background; color:"red" }


                                   },

                            State {
                                name: "gone"
                                //ParentChange { target: ticket; parent: listView}
                                /*
                                PropertyChanges {
                                    target: ticket ;opacity:0

                                }*/
                            }
                        ]

                        transitions: Transition {
                            // Make the state changes smooth
                            ParallelAnimation {
                                ColorAnimation { property: "color"; duration: 100 }
                                NumberAnimation { duration: 500; properties: "detailsOpacity,x,contentY,height,width,visible" }

                            }
                        }


            }
