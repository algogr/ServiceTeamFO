import QtQuick 2.0
import QtQml.Models 2.3

Item {
    id: tldf
    signal mySignal
    property bool occupied: false

    Flickable {
        id: flick

        width: parent.width
        height:parent.height
        //anchors { top: row1.bottom; bottom: parent.bottom }
        contentHeight: 820
        //pressDelay: 1000 //events delivered after 1 sec



        Column{
            Repeater{

                id: timerepeat
                model:13



      Rectangle{
                id: timerect
                width: flick.width-10
                height:60
                border.width: 1
                anchors.margins: 1
                color:"#d1e0e0"




                Row{
                Rectangle {
                    y:5
                    width: 40
                    height: 40
                    color: "#800000"

                }





                Text {

                    text: (index+8)+":00"
                    font.bold: true
                    anchors.verticalCenter: parent.verticalCenter


                }
                /*
                Text {

                    //text: name
                    font.bold: true
                    anchors.verticalCenter: parent.verticalCenter
                }
                */
                Rectangle{
                    id:ph
                    y:5
                    //width:400
                    width: flick.width-15
                    height:50
                    color:"#d1e0e0"
                    property bool occupied: false



                    DropArea {

                                enabled: ph.occupied?false:true
                                anchors.fill: parent
                                onEntered: {

                                    drag.source.caught = true;
                                    ph.color= "lightsteelblue"

                                }
                                onExited: {
                                    drag.source.caught = false;
                                    ph.color= "#d1e0e0"

                                }
                                onDropped: {

                                    //drag.source.parent=ph
                                    //drag.source.x=ph.x
                                    //drag.source.y=ph.y
                                    ph.color= "#d1e0e0"

                                    //Insert record to appointmenttModel

                                    var today=new Date()
                                    var dayoftw=today.getDay()
                                    var appdate=new Date()

                                    if (daytab<dayoftw)
                                        appdate.setDate(today.getDate()+7-(dayoftw-daytab))

                                    else
                                       appdate.setDate(today.getDate()+(daytab-dayoftw))

                                    var rowcount=appointmentModel.rowCount()
                                    console.log("DROPPED"+rowcount)
                                    appointmentModel.insertRow(rowcount);
                                    var indexticketid=appointmentModel.index(rowcount,1)
                                    var indextechid=appointmentModel.index(rowcount,2)
                                    var indexapp=appointmentModel.index(rowcount,3)
                                    appointmentModel.setData(indexticketid,drag.source.ticketid)
                                    appointmentModel.setData(indextechid,id)
                                    appdate.setHours(index+8)
                                    appdate.setMinutes(0)
                                    appdate.setSeconds(0)
                                    console.log("DROPPED"+rowcount+":"+appdate)

                                    appointmentModel.setData(indexapp,appdate)

                                    appointmentModel.submitAll()
                                    appointmentModel.commit()

                                    appointmentModel.select()


                                    //drag.source.state="gone"
                                    //drag.source.state="gone"

                                    appCustomerTicketModel.refresh()

                                    appointmentModel.select()

                                    list1.model.filterOnGroup="refresh"
                                    rootrect.mySignal(index,id)
                                    taskEmail.setTo("jimpar@algo.gr")
                                    taskEmail.setToName("Jimakos")
                                    taskEmail.setTitle("Ανάθεση σε τεχνικό")
                                    //taskEmail.setAttachments(attachments)
                                    var b1="Παρακαλώ για την ανάθεση των παρακάτω<br><br>"

                                    var b2="<B> Τεχνικός"+"</B><br><br>"
                                    var b3="'<B>Εργασίες: </B><br><br>"
                                    var b4="<B>TICKET: "+"</B><br><br>"

                                    taskEmail.setBody(b1+b2+b3+b4)
                                    taskEmail.send()


                                    //list1.model.filterOnGroup="selected"


                                }
                            }
                    ListView{
                        id:list1
                        width:400
                        y:2.5
                        height:40
                        model:dgm
                        spacing:1





                       DelegateModel

                        {
                            id:dgm

                            model:appCustomerTicketModel
                            groups: [

                            DelegateModelGroup
                                {

                                    name: "selected"
                                    includeByDefault: false
                                }
                                ,
                                DelegateModelGroup
                                    {

                                        name: "refresh"
                                        //includeByDefault: true
                                    }
                                    ]
                            filterOnGroup: "selected"

                            delegate:AppTicketListDelegate
                            {
                                         //id:appticketdelegate
                                         property bool occupied:false
                                         //width:400
                                         //height:50
                                         width:list1.width

                                         height:list1.height



                                     }
                            onFilterGroupChanged: {
                                var rowCount = appCustomerTicketModel.rowCount()
                                //var listRowCount=dgm.count
                               //console.log("RowCoynt:"+rowCount+"-"+listRowCount)
                               //if (rowCount>0)
                                  items.remove(0,rowCount);

                                for( var i = 0;i < rowCount;i++ )
                                {

                                    var entry = appCustomerTicketModel.get(i);
                                    var techid= entry.atechid
                                    var appdate=entry.appdate
                                    var day=appdate.getDay()
                                    var hour=appdate.getHours()

                                    if(hour===index+8 && day===pg.pindex && techid===id)
                                    {
                                        items.insert(entry, "refresh");


                                    }
                                }

                            }

                            Component.onCompleted: {
                                var rowCount = appCustomerTicketModel.rowCount()

                                items.remove(0,rowCount);
                                for( var i = 0;i < rowCount;i++ )
                                {

                                    var entry = appCustomerTicketModel.get(i);
                                    var techid= entry.atechid
                                    var appdate=entry.appdate
                                    var day=appdate.getDay()
                                    var hour=appdate.getHours()

                                    if(hour===index+8 && day===pg.pindex && techid===id)
                                    {
                                        items.insert(entry, "selected");


                                    }
                                }

                            }

                        }







                    }


                }
                }


            }

}



        }

    }

}
