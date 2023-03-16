import QtQuick 2.5
import QtQuick.Layouts 1.1

Item {
	anchors.fill: parent
	Layout.preferredWidth: textMetrics.width + 2 * margin
	
	property var margin: 3
	property var fontSize: 15
	property var fontFamily: 'Noto Mono'

	TextMetrics {
        id: textMetrics
        font {
            family: fontFamily
            pixelSize: fontSize
        }
        text: '↑2.39MB/s'
	}

	TextMetrics {
        id: textMetrics1
        font {
            family: fontFamily
            pixelSize: fontSize
        }
        text: '2.39MB/s'
	}
	
	Grid {
		anchors.left: parent.left
		anchors.leftMargin: margin		
		
		columns: 2
		//verticalItemAlignment: Grid.AlignVCenter //无效
		
		Text {
			text: '↑'
		    color: theme.textColor
		    font {
            	family: fontFamily
            	pixelSize: fontSize
        	}
		}
		
		Text {
			id: speedUp
			width: textMetrics1.width
		    color: theme.textColor
		    font {
            	family: fontFamily
            	pixelSize: fontSize
        	}
		    horizontalAlignment: Text.AlignRight
		}
		
		Text {
			text: '↓'
		    color: theme.textColor
		    font {
            	family: fontFamily
            	pixelSize: fontSize
        	}
		}
		
		Text {
			id: speedDown
			width: textMetrics1.width
		    color: theme.textColor
		    font {
            	family: fontFamily
            	pixelSize: fontSize
        	}
		    horizontalAlignment: Text.AlignRight
		}
    }   
	
	Canvas {
		id: canvas
		anchors.fill: parent
		onPaint: {
			var ctx = getContext('2d')
			ctx.clearRect(0, 0, canvas.width, canvas.height)
			ctx.lineWidth = 2
			var mp = mema / memt
			if (mp > 0.1)
				ctx.strokeStyle = theme.textColor
			else
				ctx.strokeStyle = "red"
			ctx.beginPath()
			ctx.moveTo(1, canvas.height)
            ctx.lineTo(1, canvas.height * mp)
            ctx.stroke()
            if (cpu < 90)
				ctx.strokeStyle = theme.textColor
			else
				ctx.strokeStyle = "red"
			ctx.beginPath()
			ctx.moveTo(canvas.width - 1, canvas.height)
            ctx.lineTo(canvas.width - 1, canvas.height * (100 - cpu) / 100)
            ctx.stroke()
		}
	}
    
    Timer {
        //interval: 1000  //定时器时间间隔，默认1000ms
        running: true  //是否开启定时，默认是false，当为true的时候，进入此界面就开始定时
        repeat: true   //是否重复定时，默认为false
        onTriggered: { //定时触发槽,定时完成一次就进入一次
        	speedUp.text = kb(td) + "/s"
        	speedDown.text = kb(rd) + "/s"
        	canvas.requestPaint()
        }
    }    

}
