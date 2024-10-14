//
//  TimeRangeViewController.swift
//  TimeRangeChecker
//
//  Created by 福原雅隆 on 2024/10/08.
//

import UIKit

class TimeRangeViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var targetTimePickerView: UIPickerView!
    @IBOutlet weak var startTimePickerView: UIPickerView!
    @IBOutlet weak var endTimePickerView: UIPickerView!
    @IBOutlet weak var explanationTextLabel: UILabel!
    
    let hours = Array(0...23)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        targetTimePickerView.delegate = self
        targetTimePickerView.dataSource = self
        startTimePickerView.delegate = self
        endTimePickerView.delegate = self
        startTimePickerView.dataSource = self
        endTimePickerView.dataSource = self
        explanationTextLabel.text = NSLocalizedString("TimeRangeCheckeXplanation", comment: "")
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        let resultButton = UIBarButtonItem(title: NSLocalizedString("ResultsTitle", comment: ""), style: .plain, target: self, action: #selector(goToTimeRangeCheckResult))
        navigationItem.rightBarButtonItem = resultButton
    }
    
    @IBAction func checkButtonTapped(_ sender: Any) {
        // 各時刻を取得
        let startHour = hours[startTimePickerView.selectedRow(inComponent: 0)]
        let endHour = hours[endTimePickerView.selectedRow(inComponent: 0)]
        let targetHour = hours[targetTimePickerView.selectedRow(inComponent: 0)]
        
        // 指定された時刻が設定した時刻の範囲内か判定
        let result = determineRange(targetHour: targetHour, startHour: startHour, endHour: endHour)
        
        let timeRangeCheck = TimeRangeCheck(
            startHour: startHour,
            endHour: endHour,
            targetHour: targetHour,
            result: result
        )
        
        TimeRangeModel.shared.saveResult(timeRangeCheck)
        showAlertForResult(result: result)
    }
    
    func determineRange(targetHour: Int, startHour: Int, endHour: Int) -> String {
        // 開始時刻と終了時刻が同じ場合、常に範囲内と判断する
        if startHour == endHour {
            return NSLocalizedString("WithinTimeRange", comment: "")
        } else if startHour > endHour {
            // 開始時刻が終了時刻より後の場合（日をまたぐ設定）、対象時刻が開始時刻以上、または終了時刻未満かどうかで判断
            return (targetHour >= startHour || targetHour < endHour) ? NSLocalizedString("WithinTimeRange", comment: "") : NSLocalizedString("OutsideTimeRange", comment: "")
        } else {
            // 通常の範囲内での判断（開始時刻が終了時刻より前）
            return (targetHour >= startHour && targetHour < endHour) ? NSLocalizedString("WithinTimeRange", comment: "") : NSLocalizedString("OutsideTimeRange", comment: "")
        }
    }
    
    /// 結果を表示するアラート
    private func showAlertForResult(result: String) {
        let message = result
        let alertController = UIAlertController(title: NSLocalizedString("TimeRangeCheck", comment: ""), message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default)
        alertController.addAction(okAction)
        present(alertController, animated: true)
    }
    
    @objc func goToTimeRangeCheckResult() {
        // 結果一覧画面へ遷移
        if let viewController = storyboard?.instantiateViewController(withIdentifier: "TimeRangeCheckResultViewController") as? TimeRangeCheckResultViewController {
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // 各コンポーネントの行数を定義
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return hours.count
    }
    
    // 各行のタイトルを定義
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(hours[row])\(NSLocalizedString("Clock", comment: ""))"
    }
    
}
