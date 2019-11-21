//
//  AKCalendarView.swift
//  iLifeKit
//
//  Created by 侯逸仙 on 2019/11/19.
//  Copyright © 2019 侯逸仙. All rights reserved.
//

import UIKit

/// weekday的返回是按照第一列是周日来处理的，因为这个是系统默认的方式，好处理
open class AUCalendarView: UIView {

    private var months = [AUCalendarModel]()
    public var isBeginEndlessScroll = false
    /// 视图刚加载的时候获取到的当前日期
    private let initDate = Date()
    private lazy var collectionView: MyCollection = {
        let collectionViewLayout = UICollectionViewFlowLayout()
        let collectionView = MyCollection(frame: .zero, collectionViewLayout: collectionViewLayout)
        let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout
        flowLayout?.minimumInteritemSpacing = 0
        flowLayout?.scrollDirection = .vertical
        collectionView.register(AUCalendarEvaluationCollectionViewCell.self, forCellWithReuseIdentifier: AUCalendarEvaluationCollectionViewCell.ReuseIdentifier)
        collectionView.register(AUCalendarSectionHeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: AUCalendarSectionHeaderCollectionReusableView.ReuseIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.scrollsToTop = false
        collectionView.decelerationRate = UIScrollView.DecelerationRate.init(rawValue: 0)
        print("滚动速度\(collectionView.decelerationRate)")
        return collectionView
    }()

    public override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(collectionView)
        collectionView.snp.makeConstraints { (m) in
            m.edges.equalToSuperview()
        }
        let calendar = Calendar.current
        var beginDate = initDate
        for _ in 1...5 {
            // 初始化往前构造30个月的数据
            let dateComponents = calendar.dateComponents([.year, .month, .day], from: beginDate)
            if let year = dateComponents.year,
                let month = dateComponents.month,
                let dayRangeOfCurrentMonth = calendar.range(of: .day, in: .month, for: beginDate),
                let firstWeekday = firstWeekdayOfMonth(from: beginDate) {
                months.insert(AUCalendarModel(year: year, month: month, dayCounts: dayRangeOfCurrentMonth.count, firstWeekDay: firstWeekday, belongedDate: beginDate), at: 0)
            }
            // 让beginDate往前挪一个月
            var backOneMonthDateComponents = DateComponents()
            backOneMonthDateComponents.month = -1
            if let backDate = calendar.date(byAdding: backOneMonthDateComponents, to: beginDate) {
                beginDate = backDate
            }
        }
        collectionView.reloadData()
    }

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func firstWeekdayOfMonth(from date: Date) -> Int? {
        let calendar = Calendar.current
        var dateComponents = calendar.dateComponents([.era, .year, .month], from: date)
        dateComponents.day = 1
        if let firstDayOfMonth = calendar.date(from: dateComponents) {
            let firstDayDateComponents = calendar.dateComponents([.weekday], from: firstDayOfMonth)
            if let systemWeekday = firstDayDateComponents.weekday {
//                return systemWeekday - 1 == 0 ? 7 : systemWeekday - 1
                return systemWeekday
            } else {
                return nil
            }
        } else {
            return nil
        }
    }
}

// MARK: - 外部使用的方法
extension AUCalendarView {

    public func reloadData() {
        collectionView.reloadData()
    }

    public func toggleEndlessScroll() {
        isBeginEndlessScroll = !isBeginEndlessScroll
    }
    public func scrollToBottom() {
        if let lastSection = months.last {
            collectionView.scrollToItem(at: IndexPath(item: lastSection.dayCounts + lastSection.firstWeekDay - 2, section: months.count - 1), at: .bottom, animated: false)
        }
    }
}

// MARK: - 数据源代理方法
extension AUCalendarView: UICollectionViewDataSource {
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return months.count
    }
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return months[section].dayCounts + months[section].firstWeekDay - 1
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AUCalendarEvaluationCollectionViewCell.ReuseIdentifier, for: indexPath) as! AUCalendarEvaluationCollectionViewCell
//        cell.day = (indexPath.row + months[indexPath.section].firstWeekDay) % 7 + 1
        cell.day = indexPath.row - months[indexPath.section].firstWeekDay + 2
        return cell
    }

    public func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: AUCalendarSectionHeaderCollectionReusableView.ReuseIdentifier, for: indexPath) as! AUCalendarSectionHeaderCollectionReusableView
        header.title = "\(months[indexPath.section].year)年\(months[indexPath.section].month)月"
        return header
    }
}

// MARK: - UICollectionViewDelegateFlowLayout相关的方法
extension AUCalendarView: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (bounds.width / 7).rounded(.down), height: 100)
    }

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: bounds.width, height: 40)
    }



    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        print("contentSize = \(scrollView.contentSize)")
//        print("months.count = \(months.count)")
//        return
        // 让month的总月数保持到100以内
        if isBeginEndlessScroll {
            // 在滚动的时候开始填充数据源
            if scrollView.contentOffset.y < bounds.height {
                print("上部的contentOffset \(scrollView.contentOffset)")
                print(months.first?.year)
                if let firstYear = months.first?.year {
                    if firstYear < 2000 {
                        isBeginEndlessScroll = false
                        collectionView.reloadData()
                        collectionView.layoutIfNeeded()
                        print("firstYear < 2000")
                        return
                    }
                }
                print("Calendar.current")
                // 开始往顶部填充数据源
                let calendar = Calendar.current
                var dateComponents = DateComponents()
                dateComponents.month = -1
                if let firstDate = months.first?.belongedDate, var beginDate = calendar.date(byAdding: dateComponents, to: firstDate) {
                    for _ in 1...150 {
                        // 初始化往前构造30个月的数据
                        let dateComponents = calendar.dateComponents([.year, .month, .day], from: beginDate)
                        if let year = dateComponents.year,
                            let month = dateComponents.month,
                            let dayRangeOfCurrentMonth = calendar.range(of: .day, in: .month, for: beginDate),
                            let firstWeekday = firstWeekdayOfMonth(from: beginDate) {
                            months.insert(AUCalendarModel(year: year, month: month, dayCounts: dayRangeOfCurrentMonth.count, firstWeekDay: firstWeekday, belongedDate: beginDate), at: 0)
                        } else {
                            fatalError("找不到当前正在计算的月份")
                        }
                        // 让beginDate往前挪一个月
                        var backOneMonthDateComponents = DateComponents()
                        backOneMonthDateComponents.month = -1
                        if let backDate = calendar.date(byAdding: backOneMonthDateComponents, to: beginDate) {
                            beginDate = backDate
                        } else {
                            fatalError("找不到上一个要计算的月份")
                        }
                    }
                    let beforeContentSize = collectionView.contentSize
                    // collectionView的reloadData()似乎是保证操作前后的contentOffset一致
                    print("reloadData")
                    collectionView.reloadData()
                    DispatchQueue.main.async {
                        print("layoutIfNeeded")
                        self.collectionView.layoutIfNeeded()
                        let afterContentSize = self.collectionView.contentSize
                        let afterContentOffset = self.collectionView.contentOffset
                        let newContentOffset = CGPoint(x: afterContentOffset.x, y: afterContentOffset.y + afterContentSize.height - beforeContentSize.height)
                        self.collectionView.contentOffset = newContentOffset
                        print("for _ in 1...30")
                    }
                    // 往后的30年的数据已经构造完毕，假如总数据源数量大于100，把100以后的所有数据都移除了
//                    if months.count >= 40 {
//                        months.removeLast(months.count - 40)
//                        collectionView.reloadData()
//                        collectionView.layoutIfNeeded()
//                    }
                }
            }
            if scrollView.contentOffset.y > scrollView.contentSize.height - 1000 {
                return
                print("下部的contentOffset \(scrollView.contentOffset)")
                // 开始往底部填充数据源
                let calendar = Calendar.current
                var dateComponents = DateComponents()
                dateComponents.month = 1
                if let lastDate = months.last?.belongedDate, var beginDate = calendar.date(byAdding: dateComponents, to: lastDate) {
                    for _ in 1...30 {
                        // 初始化往前构造30个月的数据
                        let dateComponents = calendar.dateComponents([.year, .month, .day], from: beginDate)
                        if let year = dateComponents.year,
                            let month = dateComponents.month,
                            let dayRangeOfCurrentMonth = calendar.range(of: .day, in: .month, for: beginDate),
                            let firstWeekday = firstWeekdayOfMonth(from: beginDate) {
                            months.append(AUCalendarModel(year: year, month: month, dayCounts: dayRangeOfCurrentMonth.count, firstWeekDay: firstWeekday, belongedDate: beginDate))
                        } else {
                            fatalError("找不到当前正在计算的月份")
                        }
                        // 让beginDate往前挪一个月
                        var backOneMonthDateComponents = DateComponents()
                        backOneMonthDateComponents.month = 1
                        if let backDate = calendar.date(byAdding: backOneMonthDateComponents, to: beginDate) {
                            beginDate = backDate
                        } else {
                            fatalError("找不到下一个要计算的月份")
                        }
                    }
                    let beforeContentSize = collectionView.contentSize
                    // collectionView的reloadData()似乎是保证操作前后的contentOffset一致
                    collectionView.reloadData()
                    collectionView.layoutIfNeeded()
//                    let afterContentSize = collectionView.contentSize
//                    let afterContentOffset = collectionView.contentOffset
//                    let newContentOffset = CGPoint(x: afterContentOffset.x, y: afterContentOffset.y + afterContentSize.height - beforeContentSize.height)
//                    collectionView.contentOffset = newContentOffset
                }
                print("已经停止了无限滚动了啊")
//                isBeginEndlessScroll = false
            }
        }
    }

}
