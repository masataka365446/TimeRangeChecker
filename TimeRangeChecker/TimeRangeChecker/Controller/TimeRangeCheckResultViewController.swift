//
//  TimeRangeCheckResultViewController.swift
//  TimeRangeChecker
//
//  Created by 福原雅隆 on 2024/10/08.
//

import UIKit

class TimeRangeCheckResultViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {
    
    @IBOutlet weak var tableView: UITableView!
    
    var results: [TimeRangeCheck] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        registerTableViewCells()
        setupNavigationBar()
        loadResults()
    }
    
    private func registerTableViewCells() {
        let nib = UINib(nibName: "TimeRangeCheckResultListTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "TimeRangeCheckResultListTableViewCell")
    }
    
    private func setupNavigationBar() {
        let resetButton = UIBarButtonItem(title: NSLocalizedString("ResetData", comment: ""), style: .plain, target: self, action: #selector(resetResult))
        navigationItem.rightBarButtonItem = resetButton
    }
    
    private func loadResults() {
        results = TimeRangeModel.shared.loadResults()
        tableView.reloadData()
    }
    
    @objc func resetResult() {
        TimeRangeModel.shared.resetResults()
        results = []
        tableView.reloadData()
    }
    
    // MARK: UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TimeRangeCheckResultListTableViewCell", for: indexPath) as? TimeRangeCheckResultListTableViewCell else {
            return UITableViewCell()
        }
        
        let result = results[indexPath.row]
        cell.startTimeTextLabel.text = "\(NSLocalizedString("StartTime", comment: ""))\(result.startHour)\(NSLocalizedString("Clock", comment: ""))"
        cell.endTimeTextLabel.text = "\(NSLocalizedString("EndTime", comment: ""))\(result.endHour)\(NSLocalizedString("Clock", comment: ""))"
        cell.targetTimeTextLabel.text = "\(NSLocalizedString("TargetTime", comment: ""))\(result.targetHour)\(NSLocalizedString("Clock", comment: ""))"
        cell.resultTextLabel.text = "\(NSLocalizedString("ResultText", comment: ""))\(result.result)"
        
        return cell
    }
    
    // MARK: UITableViewDelegate
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

}
