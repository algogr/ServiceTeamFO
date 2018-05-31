import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.2
import QtGraphicalEffects 1.0
import QtQml.Models 2.3

Item{
    id:rs
    property int ticketid: 0

    ListView{

        id:lv1
        model: dgm3
        width: parent.width
        height:parent.height
        Connections{
            target: pg1
            onTicketchanged:{
                rs.ticketid=tktid
                dgm3.filterOnGroup=dgm3.filterOnGroup==="selected"?"refresh":"selected"
            }
        }


        DelegateModel{
            id:dgm3
            model: customerTicketModel
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

                }
]
            filterOnGroup: "selected"


            delegate:Flickable {
        id: flick
        width: lv1.width
        height:lv1.height

        contentHeight: lv1.height


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

            onFilterGroupChanged: {
                var rowCount = customerTicketModel.rowCount()
                for (var i=0;i<items.count;++i)
                {

                    items.get(i).inSelected=false
                    items.get(i).inRefresh=false

                }
                var fg=dgm3.filterOnGroup

                for( var i = 0;i < rowCount;i++ )
                {

                    var entry = customerTicketModel.get(i);
                    var ticketid= entry.tid

                    if (ticketid===rs.ticketid)

                    {

                        items.insert(entry, fg);

                    }

                }


            }

            Component.onCompleted: {
                var rowCount = customerTicketModel.rowCount()

                items.remove(0,rowCount);
                for( var i = 0;i < rowCount;i++ )
                {

                    var entry = customerTicketModel.get(i);
                    var ticketid= entry.tid

                    if (ticketid===rs.ticketid)
                    {
                        items.insert(entry, "selected");

                    }

                }

            }




        }

    }
}
