//Import header 
fetch('./util/admin-header.html')
    .then(data => data.text())
    .then(html => document.getElementById('header').innerHTML = html);
    
//Import sidebar 
fetch('./util/admin-sidebar.html')
    .then(data => data.text())
    .then(html => document.getElementById('sidebar').innerHTML = html);
    

window.onload = function () {

	var chart = new CanvasJS.Chart("chartContainer-1", {
		// title: {
		//     text: "Percentage Collections by Brand"
		// },
		theme: "light2", // "light1", "light2", "dark1", "dark2"
		animationEnabled: true,
		axisX: {
			interval: 1,
			intervalType: "month"
		},
		toolTip: {
			shared: true
		},
		data: [
			{
				type: "stackedArea100",
				name: "ADIDAS",
				xValueFormatString: "MMM, YYYY",
				showInLegend: "true",
				dataPoints: [
					{ x: new Date(2016, 00, 1), y: 1100 },
					{ x: new Date(2016, 01, 1), y: 1200 },
					{ x: new Date(2016, 02, 1), y: 1000 },
					{ x: new Date(2016, 03, 1), y: 1200 },
					{ x: new Date(2016, 04, 1), y: 1600 },
					{ x: new Date(2016, 05, 1), y: 1800 },
					{ x: new Date(2016, 06, 1), y: 1400 },
					{ x: new Date(2016, 07, 1), y: 1500 },
					{ x: new Date(2016, 08, 1), y: 1600 },
					{ x: new Date(2016, 09, 1), y: 1800 }
				]
			},
			{
				type: "stackedArea100",
				name: "NEW BALANCE",
				showInLegend: "true",
				dataPoints: [
					{ x: new Date(2016, 00, 1), y: 150 },
					{ x: new Date(2016, 01, 1), y: 171 },
					{ x: new Date(2016, 02, 1), y: 155 },
					{ x: new Date(2016, 03, 1), y: 150 },
					{ x: new Date(2016, 04, 1), y: 165 },
					{ x: new Date(2016, 05, 1), y: 195 },
					{ x: new Date(2016, 06, 1), y: 155 },
					{ x: new Date(2016, 07, 1), y: 145 },
					{ x: new Date(2016, 08, 1), y: 140 },
					{ x: new Date(2016, 09, 1), y: 151 }
				]
			},
			{
				type: "stackedArea100",
				name: "NIKE",
				showInLegend: "true",
				dataPoints: [
					{ x: new Date(2016, 00, 1), y: 71 },
					{ x: new Date(2016, 01, 1), y: 41 },
					{ x: new Date(2016, 02, 1), y: 55 },
					{ x: new Date(2016, 03, 1), y: 50 },
					{ x: new Date(2016, 04, 1), y: 65 },
					{ x: new Date(2016, 05, 1), y: 95 },
					{ x: new Date(2016, 06, 1), y: 45 },
					{ x: new Date(2016, 07, 1), y: 95 },
					{ x: new Date(2016, 08, 1), y: 60 },
					{ x: new Date(2016, 09, 1), y: 40 }
				]
			},
			{
				type: "stackedArea100",
				name: "PUMA",
				showInLegend: "true",
				dataPoints: [
					{ x: new Date(2016, 00, 1), y: 861 },
					{ x: new Date(2016, 01, 1), y: 761 },
					{ x: new Date(2016, 02, 1), y: 775 },
					{ x: new Date(2016, 03, 1), y: 680 },
					{ x: new Date(2016, 04, 1), y: 785 },
					{ x: new Date(2016, 05, 1), y: 374 },
					{ x: new Date(2016, 06, 1), y: 365 },
					{ x: new Date(2016, 07, 1), y: 455 },
					{ x: new Date(2016, 08, 1), y: 657 },
					{ x: new Date(2016, 09, 1), y: 659 }
				]
			}
		]
	});
	chart.render();

	// ============================================================
	var chart = new CanvasJS.Chart("chartContainer-2", {
		animationEnabled: true,
		title: {
			// text: "Total Revenue"
		},
		axisX: {
			valueFormatString: "MMM YYYY",
			minimum: new Date(2017, 1, 5, 23),
			maximum: new Date(2017, 1, 12, 1)
		},
		axisY: {
			title: "Number of Messages"
		},
		legend: {
			verticalAlign: "top",
			horizontalAlign: "right",
			dockInsidePlotArea: true
		},
		toolTip: {
			shared: true
		},
		data: [{
			name: "redistribute",
			showInLegend: true,
			legendMarkerType: "square",
			type: "area",
			color: "rgba(40,175,101,0.6)",
			markerSize: 0,
			dataPoints: [
				{ x: new Date(2017, 1, 6), y: 220 },
				{ x: new Date(2017, 1, 7), y: 120 },
				{ x: new Date(2017, 1, 8), y: 144 },
				{ x: new Date(2017, 1, 9), y: 162 },
				{ x: new Date(2017, 1, 10), y: 129 },
				{ x: new Date(2017, 1, 11), y: 109 },
				{ x: new Date(2017, 1, 12), y: 129 }
			]
		},
		{
			name: "Retail",
			showInLegend: true,
			legendMarkerType: "square",
			type: "area",
			color: "rgba(0,75,141,0.7)",
			markerSize: 0,
			dataPoints: [
				{ x: new Date(2017, 1, 6), y: 42 },
				{ x: new Date(2017, 1, 7), y: 34 },
				{ x: new Date(2017, 1, 8), y: 29 },
				{ x: new Date(2017, 1, 9), y: 42 },
				{ x: new Date(2017, 1, 10), y: 53 },
				{ x: new Date(2017, 1, 11), y: 15 },
				{ x: new Date(2017, 1, 12), y: 12 }
			]
		}, {
			name: "Online shopping",
			showInLegend: true,
			legendMarkerType: "square",
			type: "area",
			color: "rgba(75,75,75,0.7)",
			markerSize: 0,
			dataPoints: [
				{ x: new Date(2017, 1, 6), y: 82 },
				{ x: new Date(2017, 1, 7), y: 94 },
				{ x: new Date(2017, 1, 8), y: 39 },
				{ x: new Date(2017, 1, 9), y: 12 },
				{ x: new Date(2017, 1, 10), y: 63 },
				{ x: new Date(2017, 1, 11), y: 125 },
				{ x: new Date(2017, 1, 12), y: 42 }
			]
		}
		]
	});
	chart.render();


	// ================================================================

	var chart = new CanvasJS.Chart("chartContainer-3", {
		theme: "light2",
		animationEnabled: true,
		title: {
			text: "Shares of Electricity Generation by Fuel"
		},
		// subtitles: [{
		// 	text: "United Kingdom, 2016",
		// 	fontSize: 16
		// }],
		data: [{
			type: "pie",
			indexLabelFontSize: 13,
			radius: 80,
			indexLabel: "{label} - {y}",
			yValueFormatString: "###0.0\"%\"",
			click: explodePie,
			dataPoints: [
				{ y: 42, label: "HCM" },
				{ y: 21, label: "HN" },
				{ y: 24.5, label: "DN" },
				{ y: 12.5, label: "Online" },
			]
		}]
	});
	chart.render();

	function explodePie(e) {
		for (var i = 0; i < e.dataSeries.dataPoints.length; i++) {
			if (i !== e.dataPointIndex)
				e.dataSeries.dataPoints[i].exploded = false;
		}
	}


	// ================================================================================
	var chart = new CanvasJS.Chart("chartContainer-4", {
		animationEnabled: true,
		title: {
			// text: "Evening Sales in a Restaurant"
		},
		axisX: {
			valueFormatString: "DDD"
		},
		axisY: {
			prefix: "$"
		},
		toolTip: {
			shared: true
		},
		legend: {
			cursor: "pointer",
			itemclick: toggleDataSeries
		},
		data: [{
			type: "stackedBar",
			name: "Meals",
			showInLegend: "true",
			xValueFormatString: "DD, MMM",
			yValueFormatString: "$#,##0",
			dataPoints: [
				{ x: new Date(2017, 0, 30), y: 56 },
				{ x: new Date(2017, 0, 31), y: 45 },
				{ x: new Date(2017, 1, 1), y: 71 },
				{ x: new Date(2017, 1, 2), y: 41 },
				{ x: new Date(2017, 1, 3), y: 60 },
				{ x: new Date(2017, 1, 4), y: 75 },
				{ x: new Date(2017, 1, 5), y: 98 }
			]
		},
		{
			type: "stackedBar",
			name: "Snacks",
			showInLegend: "true",
			xValueFormatString: "DD, MMM",
			yValueFormatString: "$#,##0",
			dataPoints: [
				{ x: new Date(2017, 0, 30), y: 86 },
				{ x: new Date(2017, 0, 31), y: 95 },
				{ x: new Date(2017, 1, 1), y: 71 },
				{ x: new Date(2017, 1, 2), y: 58 },
				{ x: new Date(2017, 1, 3), y: 60 },
				{ x: new Date(2017, 1, 4), y: 65 },
				{ x: new Date(2017, 1, 5), y: 89 }
			]
		},
		{
			type: "stackedBar",
			name: "Drinks",
			showInLegend: "true",
			xValueFormatString: "DD, MMM",
			yValueFormatString: "$#,##0",
			dataPoints: [
				{ x: new Date(2017, 0, 30), y: 48 },
				{ x: new Date(2017, 0, 31), y: 45 },
				{ x: new Date(2017, 1, 1), y: 41 },
				{ x: new Date(2017, 1, 2), y: 55 },
				{ x: new Date(2017, 1, 3), y: 80 },
				{ x: new Date(2017, 1, 4), y: 85 },
				{ x: new Date(2017, 1, 5), y: 83 }
			]
		},
		{
			type: "stackedBar",
			name: "Dessert",
			showInLegend: "true",
			xValueFormatString: "DD, MMM",
			yValueFormatString: "$#,##0",
			dataPoints: [
				{ x: new Date(2017, 0, 30), y: 61 },
				{ x: new Date(2017, 0, 31), y: 55 },
				{ x: new Date(2017, 1, 1), y: 61 },
				{ x: new Date(2017, 1, 2), y: 75 },
				{ x: new Date(2017, 1, 3), y: 80 },
				{ x: new Date(2017, 1, 4), y: 85 },
				{ x: new Date(2017, 1, 5), y: 105 }
			]
		},
		{
			type: "stackedBar",
			name: "Takeaway",
			showInLegend: "true",
			xValueFormatString: "DD, MMM",
			yValueFormatString: "$#,##0",
			dataPoints: [
				{ x: new Date(2017, 0, 30), y: 52 },
				{ x: new Date(2017, 0, 31), y: 55 },
				{ x: new Date(2017, 1, 1), y: 20 },
				{ x: new Date(2017, 1, 2), y: 35 },
				{ x: new Date(2017, 1, 3), y: 30 },
				{ x: new Date(2017, 1, 4), y: 45 },
				{ x: new Date(2017, 1, 5), y: 25 }
			]
		}]
	});
	chart.render();

	function toggleDataSeries(e) {
		if (typeof (e.dataSeries.visible) === "undefined" || e.dataSeries.visible) {
			e.dataSeries.visible = false;
		}
		else {
			e.dataSeries.visible = true;
		}
		chart.render();
	}

	// ===========================================================================

	var chart = new CanvasJS.Chart("chartContainer-5", {
		animationEnabled: true,
		title: {
			// text: "Total Revenue"
		},
		axisX: {
			valueFormatString: "MMM YYYY",
			minimum: new Date(2017, 1, 5, 23),
			maximum: new Date(2017, 1, 12, 1)
		},
		axisY: {
			title: "Number of Messages"
		},
		legend: {
			verticalAlign: "top",
			horizontalAlign: "right",
			dockInsidePlotArea: true
		},
		toolTip: {
			shared: true
		},
		data: [{
			name: "redistribute",
			showInLegend: true,
			legendMarkerType: "square",
			type: "area",
			color: "rgba(40,175,101,0.6)",
			markerSize: 0,
			dataPoints: [
				{ x: new Date(2017, 1, 6), y: 220 },
				{ x: new Date(2017, 1, 7), y: 120 },
				{ x: new Date(2017, 1, 8), y: 144 },
				{ x: new Date(2017, 1, 9), y: 162 },
				{ x: new Date(2017, 1, 10), y: 129 },
				{ x: new Date(2017, 1, 11), y: 109 },
				{ x: new Date(2017, 1, 12), y: 129 }
			]
		},
		{
			name: "Retail",
			showInLegend: true,
			legendMarkerType: "square",
			type: "area",
			color: "rgba(0,75,141,0.7)",
			markerSize: 0,
			dataPoints: [
				{ x: new Date(2017, 1, 6), y: 42 },
				{ x: new Date(2017, 1, 7), y: 34 },
				{ x: new Date(2017, 1, 8), y: 29 },
				{ x: new Date(2017, 1, 9), y: 42 },
				{ x: new Date(2017, 1, 10), y: 53 },
				{ x: new Date(2017, 1, 11), y: 15 },
				{ x: new Date(2017, 1, 12), y: 12 }
			]
		}, {
			name: "Online shopping",
			showInLegend: true,
			legendMarkerType: "square",
			type: "area",
			color: "rgba(75,75,75,0.7)",
			markerSize: 0,
			dataPoints: [
				{ x: new Date(2017, 1, 6), y: 82 },
				{ x: new Date(2017, 1, 7), y: 94 },
				{ x: new Date(2017, 1, 8), y: 39 },
				{ x: new Date(2017, 1, 9), y: 12 },
				{ x: new Date(2017, 1, 10), y: 63 },
				{ x: new Date(2017, 1, 11), y: 125 },
				{ x: new Date(2017, 1, 12), y: 42 }
			]
		}
		]
	});
	chart.render();


	// =======================================================================


	var chart = new CanvasJS.Chart("chartContainer-6", {
		animationEnabled: true,

		// title:{
		// 	text:"Top sale product"
		// },

		axisX: {
			interval: 1
		},
		axisY2: {
			interlacedColor: "rgba(1,77,101,.2)",
			gridColor: "rgba(1,77,101,.1)",
			// title: "Number of Companies"
		},
		data: [{
			type: "bar",
			name: "Product",
			axisYType: "secondary",
			// color: "#888",
			dataPoints: [
				{ y: 13, label: "Product_A" },
				{ y: 17, label: "Product_A" },
				{ y: 15, label: "Product_A" },
				{ y: 19, label: "Product_A" },
				{ y: 27, label: "Product_A" },
				{ y: 27, label: "Product_A" },
				{ y: 38, label: "Product_A" },
				{ y: 39, label: "Product_A" },
				{ y: 41, label: "Product_A" },
				{ y: 45, label: "Product_A" },
				{ y: 52, label: "Product_A" },
				{ y: 55, label: "Product_A" },
				{ y: 55, label: "Product_A" },
				{ y: 58, label: "Product_A" },
				{ y: 59, label: "Product_A" },
				{ y: 62, label: "Product_A" },
				{ y: 68, label: "Product_A" },
				{ y: 70, label: "Product_A" }
			]
		}]
	});
	chart.render();

}