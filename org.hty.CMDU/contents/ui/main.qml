import QtQuick 2.0
import QtQuick.Layouts 1.1

import org.kde.plasma.plasmoid 2.0
import org.kde.plasma.core 2.0 as PlasmaCore

Item {
    property var uptime: ''
    property var cpu: 0
    property var mema: 0
    property var memt: 0
    property var rd: 0
    property var rdt: 0
    property var td: 0
    property var tdt: 0
    
    Plasmoid.toolTipMainText: 'Uptime: ' + uptime
	Plasmoid.toolTipSubText: 'CPU: ' + cpu + '%\nMem: ' + mem(mema, memt) + '\nDown: ' + kb(rdt) + '  ' + kb(rd) + '/s\nUp: ' + kb(tdt) + '  ' + kb(td) + '/s'

	Plasmoid.preferredRepresentation: Plasmoid.compactRepresentation
    Plasmoid.compactRepresentation: CompactRepresentation { }
    
    Component.onCompleted: {
        // trigger adding all sources already available
        for (var i in dataSource.sources) {
            dataSource.sourceAdded(dataSource.sources[i]);
        }
    }
    
    PlasmaCore.DataSource {
        id: dataSource
        engine: 'systemmonitor'
        interval: 1000

        onSourceAdded: {
        	if (source.startsWith("network/interfaces/lo"))
        		return
        		
        	// match(/*/)斜杠首尾表示是正则表达式，^匹配开头，\/转义/，()提取，(a|b)包含a或b，$匹配结尾
	        var match = source.match(/^network\/interfaces\/(\w+)\/(receiver|transmitter)\/data(Total)?$/)        	
		    if (match)
			    console.log(match)
        
            if (source == 'system/uptime' || source == 'cpu/system/idle' || source == 'mem/physical/available' || source == 'mem/physical/total' || source == 'network/interfaces/enp1s0/receiver/data' || source == 'network/interfaces/enp1s0/receiver/dataTotal' || source == 'network/interfaces/enp1s0/transmitter/data'
|| source == 'network/interfaces/enp1s0/transmitter/dataTotal')
            	connectSource(source)
        }

        onSourceRemoved: {
            console.log('remove: ' + source)
        }

        onNewData: {
	        if (data.value === undefined) {
                return
            }
            
            if (sourceName == 'system/uptime') {
		    	var s = Number(data.value)
		    	var d = parseInt(s / (24 * 60 * 60))
		    	var dd = ''
		    	if (d > 0)
		    		dd = d + ' d '
		    	s -= d * 24 * 60 * 60
				var h = parseInt(s / (60 * 60))
				s -= h * 60 * 60
				var m = Math.floor(s / 60)
				s -= m * 60
				s = parseInt(s)
				if (h < 10) h = '0' + h
				if (m < 10) m = '0' + m
				if (s < 10) s = '0' + s
				uptime = dd + h + ':' + m + ':' + s
			} else if (sourceName == 'cpu/system/idle') {
				cpu = 100 - parseInt(Number(data.value))
			} else if (sourceName == 'mem/physical/available') {
				mema = data.value
			} else if (sourceName == 'mem/physical/total') {
				memt = data.value
			} else if (sourceName == 'network/interfaces/enp1s0/receiver/data') {
        	    rd = data.value
        	} else if (sourceName == 'network/interfaces/enp1s0/receiver/dataTotal') {
        	    rdt = data.value
        	} else if (sourceName == 'network/interfaces/enp1s0/transmitter/data') {
        	    td = data.value
        	} else if (sourceName == 'network/interfaces/enp1s0/transmitter/dataTotal') {
        	    tdt = data.value
        	}
        }
    }
    
    function kb(k) {
    	var s = ''
    	if (k > 999999) {
    		k = k / 1024 / 1024;
    		if (k > 100)
    			k = k.toFixed(0);
    		else if (k > 10)
    			k = k.toFixed(1);
    		else
    			k = k.toFixed(2);    		
    		s = k + ' GB'
    	} else if (k > 999) {
    		k = k / 1024;
    		if (k > 100)
    			k = k.toFixed(0);
    		else if (k > 10)
    			k = k.toFixed(1);
    		else
    			k = k.toFixed(2);    		
    		s = k + ' MB'
    	} else {
    		s = k + ' KB'
    	}
    	return s
    }
    
    function mem(mema, memt) {
    	var memu = memt - mema
    	var p = parseInt(memu * 100 / memt)
    	var s = kb(memu) + " / " + kb(memt) + " = " + p + "%"
    	return s
    }
    
}
