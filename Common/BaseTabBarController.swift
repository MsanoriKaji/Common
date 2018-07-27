//
//  BaseTabBarController.swift
//  Common
//
//  Created by ma_kaji on 2018/07/27.
//  Copyright © 2018年 加地　正法. All rights reserved.
//

import Foundation
import UIKit


typealias TabType = BaseTabBarController.TabType

final class BaseTabBarController: UITabBarController {

    static let statusBarHeight = UIApplication.shared.statusBarFrame.height
    static let tabBarHeight = BaseTabBarController.sharedInstance().tabBar.height

    private static var instance: BaseTabBarController?

    public class func sharedInstance() -> BaseTabBarController {
        if let instance = BaseTabBarController.instance {
            return instance
        }
        let instance = BaseTabBarController()
        BaseTabBarController.instance = instance
        return instance
    }

    public enum TabType: Int, EnumHashableProtocol {
        case home, setting

        var titleKey: String {
            switch self {
            case .home:
                return "home"
            case .setting:
                return "setting"
            }
        }

        var topViewController: UIViewController {
            switch self {
            case .home:
                return UIViewController()
            case .setting:
                return UIViewController()
            }
        }

        var image: UIImage? {
            let imageName: String
            switch self {
            case .home:
                imageName = "home"
            case .setting:
                imageName = "setting"
            return UIImage(named: imageName)
            }
        }

    }

    var navigationControllers = [TabType: UINavigationController]()

    var selectedTab: TabType {
        return TabType(rawValue: selectedIndex) ?? TabType.apart
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    func setup() {
        var viewControllers = [UIViewController]()

        UITabBar.appearance().backgroundColor = .white
        UINavigationBar.appearance().backgroundColor = .white

        for type in TabType.allValues {
            guard let image = type.image else {
                continue
            }
            let controller = type.topViewController
            controller.tabBarItem =
                UITabBarItem(title: NSLocalizedString(type.titleKey, comment: type.titleKey) ,
                             image: image,
                             tag: type.rawValue)
            let navi = UINavigationController(rootViewController: controller)

            viewControllers.append(navi)
            navigationControllers[type] = navi
        }

        self.setViewControllers(viewControllers, animated: false)
        // 初期表示はHomeとする
        self.selectedIndex = TabType.home.rawValue

        self.delegate = self
    }

    static func setUpMain() {
        reset()
        UIApplication.shared.keyWindow?.rootViewController = sharedInstance()
    }

    static func reset() {
        BaseTabBarController.instance = nil
    }

    /// タブを選択
    ///
    /// - Parameters:
    ///   - type: タブ種別
    ///   - animated: アニメーションの有無
    static func selectTab(type: TabType, animated: Bool) {
        popToRootViewController(type: type, animated: animated)
        let tabBar = BaseTabBarController.sharedInstance()
        tabBar.selectedViewController = BaseTabBarController.navigationController(type: type)
    }

    /// 指定したTabをルートに戻す
    ///
    /// - Parameters:
    ///   - type: タブ種別
    ///   - animated: アニメーションの有無
    static func popToRootViewController(type: TabType, animated: Bool) {
        guard let navi = BaseTabBarController.sharedInstance().navigationControllers[type] else {
            return
        }
        navi.popToRootViewController(animated: animated)
    }

    /// 選択中のタブかどうかを返却する
    ///
    /// - Parameter type: タブ種別
    /// - Returns: true: 選択中、 false: 非選択
    static func isSelectedTab(type: TabType) -> Bool {
        let tabController = BaseTabBarController.sharedInstance()
        return tabController.selectedIndex == type.rawValue
    }

    /// タブに対応するNavigationControllerを返却
    ///
    /// - Parameter type: タブ種別
    /// - Returns: NavigationController
    static func navigationController(type: TabType) -> UINavigationController? {
        return BaseTabBarController.sharedInstance().navigationControllers[type]
    }

    /// タブに対応するナビゲーションバーの高さを取得
    ///
    /// - Parameter type: タブ種別
    /// - Returns: 高さ
    static func navigationBarHeight(type: TabType) -> CGFloat {
        guard let navi = navigationController(type: type) else {
            return 0.0
        }
        return navi.navigationBar.height
    }

    /// タブを切り替える
    ///
    /// - Parameter type: タブ種別
    /// - Parameter setup: 遷移時に設定がある場合は処理を行う
    /// - Returns: true:遷移成功、 false:遷移失敗
    static private func setTab(type: TabType, setup: ((UIViewController) -> Void)? ) -> Bool {
        if isSelectedTab(type: type) { // 既に対応するタブを選択中の場合、処理を終了
            return true
        }

        guard let navi = navigationController(type: type) else {
            return false
        }

        if let topViewController = navi.topViewController {
            setup?(topViewController)
        }
        selectTab(type: type, animated: false)
        return true
    }

}

// MARK: - UITabBarControllerDelegate
extension BaseTabBarController: UITabBarControllerDelegate {

    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        guard let type = TabType(rawValue: item.tag) else {
            return
        }
        BaseTabBarController.selectTab(type: type, animated: false)
    }

}

