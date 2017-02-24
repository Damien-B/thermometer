//
//  GraphViewController.swift
//  thermometer
//
//  Created by Damien Bannerot on 23/02/2017.
//  Copyright © 2017 Damien Bannerot. All rights reserved.
//

import UIKit
import Charts

class GraphViewController: UIViewController {

	@IBOutlet weak var chartView: LineChartView!
	
	struct entry {
		var timestamp: Int
		var temperature: Double
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()

		var test: [entry] = []
		test.append(entry(timestamp: 1487890800, temperature: 22.4))
		test.append(entry(timestamp: 1487890830, temperature: 22.5))
		test.append(entry(timestamp: 1487890860, temperature: 22.7))
		test.append(entry(timestamp: 1487890890, temperature: 23.0))
		test.append(entry(timestamp: 1487890910, temperature: 22.8))
		test.append(entry(timestamp: 1487890940, temperature: 22.3))
		test.append(entry(timestamp: 1487890970, temperature: 22.3))
		test.append(entry(timestamp: 1487891000, temperature: 22.4))
		test.append(entry(timestamp: 1487891030, temperature: 20.2))
		test.append(entry(timestamp: 1487891060, temperature: 20.4))
		
		self.chartView.noDataText = "aucune données."
		self.chartView.chartDescription?.text = ""//"température"
		
		self.setChartView(entriesData: test)
		
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	func setChartView(entriesData: [entry]) {
		var chartEntries: [ChartDataEntry] = []
		var xStrings: [String] = []
		let sortedentriesData = entriesData.sorted { (s1: entry, s2: entry) -> Bool in
			return s1.timestamp < s2.timestamp
		}
		for (i, entry) in sortedentriesData.enumerated() {
			let newEntry = ChartDataEntry(x: Double(i), y: entry.temperature)
			chartEntries.append(newEntry)
			let dateFormatter = DateFormatter()
			dateFormatter.timeStyle = .none
			dateFormatter.dateStyle = .short
			let timeFormatter = DateFormatter()
			timeFormatter.timeStyle = .medium
			timeFormatter.dateStyle = .none
			xStrings.append("\(dateFormatter.string(from: Date.init(timeIntervalSince1970: TimeInterval(entry.timestamp))))\n\(timeFormatter.string(from: Date.init(timeIntervalSince1970: TimeInterval(entry.timestamp))))")
		}
		let set: LineChartDataSet = LineChartDataSet(values: chartEntries, label: "°C")
		set.setColor(NSUIColor.blue, alpha: CGFloat(1))
		set.circleColors = [NSUIColor.blue]
		set.circleRadius = 3
		set.mode = LineChartDataSet.Mode.cubicBezier
		
		let data: LineChartData = LineChartData(dataSet: set)
		self.chartView.xAxis.labelRotationAngle = -90
		self.chartView.xAxis.valueFormatter = DefaultAxisValueFormatter(block: {(index, _) in
			return xStrings[Int(index)]
		})
		self.chartView.xAxis.setLabelCount(xStrings.count, force: true)
		self.chartView.data = data
	}

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
