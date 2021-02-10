import UIKit
import Charts
import Firebase

class SecondItem: UIViewController {
    
    var statisticData : Statistic = Statistic()
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var monthProgress: CircularProgressView!
    @IBOutlet weak var yearProgress: CircularProgressView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var monthChartLabel: UILabel!
    @IBOutlet weak var yearChartLabel: UILabel!
    @IBOutlet weak var monthRatio: UILabel!
    @IBOutlet weak var yearRatio: UILabel!
    
    
    @IBOutlet weak var monthContainer: UIView!
    @IBOutlet weak var yearContainer: UIView!
    
    @IBOutlet weak var monthBarChart: BarChartView!
    @IBOutlet weak var yearBarChart: BarChartView!
    
    var months: [String] = ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"]
    var years: [String] = ["2016","2017","2018","2019","2020"]
    var monthData : [Double] = [0,0,0,0,0,0,0,0,0,0,0,]
    var yearData : [Double] = [0,0,0,0,0]
    var monthGoal : String = ""
    var yearGoal : String = ""
    let queue = DispatchQueue(label: "queue")
    var count : Int = 0
    
    
    override func viewDidLoad() {
        
        
        scrollView.isScrollEnabled = true
        self.monthRatio.text = "  %"
        self.yearRatio.text = "  %"
        monthProgress.tag = 101
        yearProgress.tag = 102
        monthContainer.layer.cornerRadius = 25
        yearContainer.layer.cornerRadius = 25
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        monthProgress.trackColor = UIColor.white
        monthProgress.progressColor = UIColor.init(red: 248/255, green: 228/255, blue: 141/255, alpha: 1)
       
        
        yearProgress.trackColor = UIColor.white
        yearProgress.progressColor = UIColor.init(red: 248/255, green: 228/255, blue: 141/255, alpha: 1)
        
        let month = self.view.viewWithTag(101) as! CircularProgressView
        month.setProgressWithAnimation(duration: 0.0, value: 0.0)
        let year = self.view.viewWithTag(102) as! CircularProgressView
        year.setProgressWithAnimation(duration: 0.0, value: 0.0)
        
        self.monthData = [0,0,0,0,0,0,0,0,0,0,0,0]
        self.yearData = [0,0,0,0,0]
        let db = Firestore.firestore()
        let uid = Auth.auth().currentUser?.uid ?? ""
        let docRef = db.collection("User").document("\(uid)")
        db.collection("User").document("\(uid)").collection("Book").getDocuments(){ (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                var currentMonthCnt : Double = 0
                var currentYearCnt : Double = 0
                for document in querySnapshot!.documents {
                    let month : String = document.data()["month"] as? String ?? ""
                    let year : String = document.data()["year"] as? String ?? ""
                    if(year == "2020"){
                        switch month{
                        case "01":
                            self.monthData[0] = self.monthData[0] + 1
                        case "02":
                            self.monthData[1] = self.monthData[1] + 1
                        case "03":
                            self.monthData[2] = self.monthData[2] + 1
                        case "04":
                            self.monthData[3] = self.monthData[3] + 1
                        case "05":
                            self.monthData[4] = self.monthData[4] + 1
                        case "06":
                            self.monthData[5] = self.monthData[5] + 1
                        case "07":
                            self.monthData[6] = self.monthData[6] + 1
                        case "08":
                            currentMonthCnt += 1
                            self.monthData[7] = self.monthData[7] + 1
                        case "09":
                            self.monthData[8] = self.monthData[8] + 1
                        case "10":
                            self.monthData[9] = self.monthData[9] + 1
                        case "11":
                            self.monthData[10] = self.monthData[10] + 1
                        case "12":
                            self.monthData[11] = self.monthData[11] + 1
                        default:
                            print("error")
                        }
                        
                        currentYearCnt += 1
                    }
                    
                    switch year {
                    case "2020":
                        self.yearData[4] = self.yearData[4] + 1
                    case "2019":
                        self.yearData[3] = self.yearData[3] + 1
                    case "2018":
                        self.yearData[2] = self.yearData[2] + 1
                    case "2017":
                        self.yearData[1] = self.yearData[1] + 1
                    case "2016":
                        self.yearData[0] = self.yearData[0] + 1
                    default:
                        print("error")
                    }
                }
                self.statisticData.monthData = self.monthData
                self.statisticData.yearData = self.yearData
                self.statisticData.monthCurrent = currentMonthCnt
                self.statisticData.yearCurrent = currentYearCnt
            }
            
            
            docRef.getDocument(){ (document, error) in
                if let document = document, document.exists {
                    let mGoal :String = document.get("monthGoal") as? String ?? "0"
                    let yGoal :String = document.get("yearGoal") as? String ?? "0"
                    let total :Int = document.get("totalBookCount") as? Int ?? 0
                    self.titleLabel.text = "지금까지 총 \(total)권 읽었습니다."
                    self.perform(#selector(self.animateProgress), with: nil, afterDelay: 0.0)
                    self.statisticData.monthGoal = Double(mGoal)!
                    self.statisticData.yearGoal = Double(yGoal)!
                    if(self.count == 0 ) { self.viewWillAppear(true) }
                } else {
                    print("Document does not exist")
                }
                
                
            }
            
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.viewDidLoad()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
    
        
        setYearChart(chart: yearBarChart,yearData: statisticData.yearData)
        setMonthChart(chart: monthBarChart)
        let numberFormatter = NumberFormatter()
        numberFormatter.roundingMode = .floor
        numberFormatter.minimumSignificantDigits = 0
        numberFormatter.maximumSignificantDigits = 0
        
        let monthValue = Double((self.statisticData.monthCurrent / self.statisticData.monthGoal)*100)
        let yearValue = Double((self.statisticData.yearCurrent / self.statisticData.yearGoal)*100)
        
        
        let monthNum = numberFormatter.string(from: NSNumber(value: monthValue)) ?? ""
        let yearNum = numberFormatter.string(from: NSNumber(value: yearValue)) ?? ""
        
        self.monthRatio.text = statisticData.monthCurrent != 0 ? "\(monthNum)%" : "   %"
        self.yearRatio.text = statisticData.yearCurrent != 0 ? "\(yearNum)%" : "   %"
        
        
    }
    
    
    
    @objc func animateProgress() {
        
        let monthValue = Float(self.statisticData.monthCurrent / self.statisticData.monthGoal)
        let yearValue = Float(self.statisticData.yearCurrent / self.statisticData.yearGoal)
        
        
        let month = self.view.viewWithTag(101) as! CircularProgressView
        month.setProgressWithAnimation(duration: 0.5, value: monthValue)
        let year = self.view.viewWithTag(102) as! CircularProgressView
        year.setProgressWithAnimation(duration: 0.5, value: yearValue)
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setMonthChart(chart : BarChartView){
        
        let test = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11]
        var dataEntries: [BarChartDataEntry] = []
        for i in 0..<12 {
            let dataEntry = BarChartDataEntry(x: Double(test[i]), y: Double(self.statisticData.monthData[i]))
            dataEntries.append(dataEntry)
            
        }
        let chartDataSet = BarChartDataSet(entries: dataEntries, label: "")
        
        let chartData = BarChartData(dataSet: chartDataSet)
        
        chartDataSet.colors = [UIColor.init(red: 248/255, green: 228/255, blue: 141/255, alpha: 1)]
        
        let currencyNumberFormatter = NumberFormatter()
        currencyNumberFormatter.numberStyle = .decimal
        currencyNumberFormatter.minimumFractionDigits = 0
        currencyNumberFormatter.maximumFractionDigits = 0
        
        chartDataSet.valueFormatter = ChartValueFormatter(numberFormatter: currencyNumberFormatter)
        
        
        chart.xAxis.enabled = true
        chart.xAxis.labelPosition = .bottom
        chart.xAxis.valueFormatter = IndexAxisValueFormatter(values: months)
        
        chart.xAxis.granularityEnabled = true
        chart.xAxis.drawGridLinesEnabled = false
        chart.xAxis.labelCount = 12
        chart.leftAxis.drawGridLinesEnabled = false
        chart.rightAxis.drawGridLinesEnabled = false
        chart.rightAxis.enabled = false
        chart.legend.enabled = false
        chart.data = chartData
    }
    
    func setYearChart(chart : BarChartView,yearData : [Double]){
        
        //        let unitsSold = [10,12,5,8,20]
        let test = [0, 1, 2, 3, 4]
        var dataEntries: [BarChartDataEntry] = []
        for i in 0..<5 {
            let dataEntry = BarChartDataEntry(x: Double(test[i]), y: Double(yearData[i]))
            dataEntries.append(dataEntry)
            
        }
        let chartDataSet = BarChartDataSet(entries: dataEntries, label: "")
        
        let chartData = BarChartData(dataSet: chartDataSet)
        
        chartDataSet.colors = [UIColor.init(red: 248/255, green: 228/255, blue: 141/255, alpha: 1)]
        
        let currencyNumberFormatter = NumberFormatter()
        currencyNumberFormatter.numberStyle = .decimal
        currencyNumberFormatter.minimumFractionDigits = 0
        currencyNumberFormatter.maximumFractionDigits = 0
        
        chartDataSet.valueFormatter = ChartValueFormatter(numberFormatter: currencyNumberFormatter)
        
        
        chart.xAxis.enabled = true
        chart.xAxis.labelPosition = .bottom
        chart.xAxis.valueFormatter = IndexAxisValueFormatter(values: years)
        
        chart.xAxis.granularityEnabled = true
        chart.xAxis.drawGridLinesEnabled = false
        chart.xAxis.labelCount = 12
        
        chart.leftAxis.axisMinimum = 0
        
        
        
        chart.leftAxis.drawGridLinesEnabled = false
        chart.rightAxis.drawGridLinesEnabled = false
        chart.rightAxis.enabled = false
        chart.legend.enabled = false
        chart.data = chartData
    }
    
    
}

class ChartValueFormatter: NSObject, IValueFormatter {
    fileprivate var numberFormatter: NumberFormatter?
    
    convenience init(numberFormatter: NumberFormatter) {
        self.init()
        self.numberFormatter = numberFormatter
    }
    
    func stringForValue(_ value: Double, entry: ChartDataEntry, dataSetIndex: Int, viewPortHandler: ViewPortHandler?) -> String {
        guard let numberFormatter = numberFormatter
            else {
                return ""
        }
        return numberFormatter.string(for: value)!
    }
}
