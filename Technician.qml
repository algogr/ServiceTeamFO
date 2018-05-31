import QtQuick 2.6
import QtQuick.Controls 2.2
import QtQuick.Dialogs 1.2


Pane {
    id: page

    property variant techid: "-1"
    property variant taskcatid
    property variant techname

        Column {
            id:c1
            spacing: 20
            anchors.horizontalCenter: parent.horizontalCenter

            ComboBox{
                id:techname1

                width:  page.availableWidth/3
                height: page.availableHeight/15

                model:techModel
                editable: true
                currentIndex: -1

                textRole: "name"
                font.pixelSize: 25
                onCurrentTextChanged: {

                    if (techname1.currentIndex>-1)
                    {


                        //var indextech=techModel.index(techname1.currentIndex,0)
                        //var indextech=techModel.index(model.id,0)
                        techid=techModel.get(currentIndex)["id"]
                        console.log(techModel.get(currentIndex)["id"]);


                        console.log(techid)
                        techname=techname1.currentText

                        active.checked=techModel.get(currentIndex)["active"]
                        username.text=techModel.get(currentIndex)["username"]
                        password.text=techModel.get(currentIndex)["password"]
                        email.text=techModel.get(currentIndex)["email"]
                        email2.text=techModel.get(currentIndex)["email2"]
                        email3.text=techModel.get(currentIndex)["email3"]




                    }



                }
            }




            CheckBox {
                id:active
                text: "Active"
                checked: true


            }

            Rectangle{
                width:  page.availableWidth/3
                height: page.availableHeight/20
                anchors.horizontalCenter: parent.horizontalCenter
                border.width: 1

            TextArea {


                id:username
                wrapMode: TextArea.Wrap
                placeholderText: "Username"
                anchors.fill: parent

            }
            }


            Rectangle{
                width:  page.availableWidth/3
                height: page.availableHeight/20
                anchors.horizontalCenter: parent.horizontalCenter
                border.width: 1

            TextArea {


                id:password
                wrapMode: TextArea.Wrap
                placeholderText: "password"
                anchors.fill: parent

            }
            }




            Rectangle{
                width:  page.availableWidth/3
                height: page.availableHeight/20
                anchors.horizontalCenter: parent.horizontalCenter
                border.width: 1

            TextArea {


                id:email
                wrapMode: TextArea.Wrap
                placeholderText: "Email"
                anchors.fill: parent

            }
            }

            Rectangle{
                width:  page.availableWidth/3
                height: page.availableHeight/20
                anchors.horizontalCenter: parent.horizontalCenter
                border.width: 1

            TextArea {


                id:email2
                wrapMode: TextArea.Wrap
                placeholderText: "Email 2"
                anchors.fill: parent

            }
            }


            Rectangle{
                width:  page.availableWidth/3
                height: page.availableHeight/20
                anchors.horizontalCenter: parent.horizontalCenter
                border.width: 1

            TextArea {


                id:email3
                wrapMode: TextArea.Wrap
                placeholderText: "Email 3"
                anchors.fill: parent

            }
            }




            Row{
                spacing: 25
            Button{
                id:btnok

                    Image {
                        anchors.fill: parent
                        source: "qrc:images/check.png"
                    }

                    onReleased: {
                        techModel.setFilter("id="+techid)
                        techModel.select()
                        console.log()
                        var indexuser=techModel.index(0,4)
                        var indexpass=techModel.index(0,5)
                        var indexemail=techModel.index(0,2)
                        var indexemail2=techModel.index(0,7)
                        var indexemail3=techModel.index(0,8)
                        var indexactive=techModel.index(0,6)

                        techModel.setData(indexactive,active.checked)
                        techModel.setData(indexuser,username.text)
                        techModel.setData(indexpass,password.text)
                        techModel.setData(indexemail,email.text)
                        techModel.setData(indexemail2,email2.text)
                        techModel.setData(indexemail3,email3.text)
                        techModel.submitAll()
                        techModel.setFilter("")
                        techModel.select()

                        stackView.pop()
                    }

            }

            Button{
                id:btncancel


                Image {
                    anchors.fill: parent
                    source: "qrc:images/black-x-png-27.png"
                }
                onReleased: {
                    stackView.pop()
                }
            }









            }






    }




Component.onCompleted: {
    techname1.currentIndex=-1



}


}


