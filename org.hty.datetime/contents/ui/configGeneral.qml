import QtQuick 2.0
import QtQuick.Layouts 1.1
import QtQuick.Controls 2.5
import org.kde.kirigami 2.4 as Kirigami

Kirigami.FormLayout {
    id: page
      
	//关联配置变量和控件属性
    property alias cfg_showSeconds: showSeconds.checked
    property alias cfg_showWeekNumbers: showWeekNumbers.checked
    property alias cfg_toolTipMain: toolTipMain.text
    property alias cfg_toolTipSub: toolTipSub.text

    CheckBox {
        id: showSeconds
        text: i18n("Show seconds")
        checked: plasmoid.configuration.showSeconds
    }
    
    CheckBox {
        id: showWeekNumbers
        text: i18n("Show week numbers")
        checked: plasmoid.configuration.showWeekNumbers
    }
	
	TextField {
        id: toolTipMain
        Kirigami.FormData.label: i18n("ToolTipMain:")
        text: plasmoid.configuration.toolTipMain
    }
	
	TextArea {
        id: toolTipSub
        Layout.fillWidth: true
        Kirigami.FormData.label: i18n("ToolTipSub:")
        Kirigami.FormData.labelAlignment: Qt.AlignTop
        text: plasmoid.configuration.toolTipSub
    }

}
