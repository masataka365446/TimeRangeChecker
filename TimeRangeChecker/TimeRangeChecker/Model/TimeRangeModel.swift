//
//  TimeRangeModel.swift
//  TimeRangeChecker
//
//  Created by 福原雅隆 on 2024/10/08.
//

import Foundation

struct TimeRangeCheck {
    var startHour: Int
    var endHour: Int
    var targetHour: Int
    var result: String
}

class TimeRangeModel {
    static let shared = TimeRangeModel()

    private let userDefaultsKey = "checkResults"
    
    // 結果を保存
    func saveResult(_ check: TimeRangeCheck) {
        var results = UserDefaults.standard.object(forKey: userDefaultsKey) as? [[String: Any]] ?? []
        let newResult = [
            "targetHour": check.targetHour,
            "startHour": check.startHour,
            "endHour": check.endHour,
            "result": check.result
        ] as [String : Any]
        results.append(newResult)
        UserDefaults.standard.set(results, forKey: userDefaultsKey)
    }
    
    // 結果データをロード
    func loadResults() -> [TimeRangeCheck] {
        guard let savedResults = UserDefaults.standard.array(forKey: userDefaultsKey) as? [[String: Any]] else {
            return []
        }
        
        return savedResults.map { dict in
            TimeRangeCheck(
                startHour: dict["startHour"] as? Int ?? 0,
                endHour: dict["endHour"] as? Int ?? 0,
                targetHour: dict["targetHour"] as? Int ?? 0,
                result: dict["result"] as? String ?? ""
            )
        }
    }
    
    // すべての結果データを削除
    func resetResults() {
        UserDefaults.standard.removeObject(forKey: userDefaultsKey)
    }
}
