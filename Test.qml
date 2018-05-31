import QtQuick 2.0
import QtQml.Models 2.3

Item {
    Rectangle{
        anchors.fill: parent
        border.width: 2
        border.color: "black"


    ListView {
        id: listView
        //x: 22
        //y: 18
        //width: 305
        //height: 312
        anchors.fill: parent
        model:dgm
        //clip:true
//        model:appCustomerTicketModel

        DelegateModel{
            id: dgm
            model:appCustomerTicketModel

            groups: [

            DelegateModelGroup
                {

                    name: "selected"
                    includeByDefault: false
                }

        ]
            filterOnGroup: "selected"

            delegate: Rectangle{
                    color:"black"
                    width:305
                    height: 312
                    Text {
                        text: "Name: " + name
                        color: "white"
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

                    if(hour===8 && day===0 && techid===3)
                    {
                        items.insert(entry, "selected");
                        console.log(hour+"."+day+"."+techid)


                    }
                }

            }

        }

            }
    }
}

