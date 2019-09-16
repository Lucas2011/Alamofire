//
//  SafetyArea.swift
//  safeArea
//
//  Created by Lucas on 9/15/19.
//  Copyright © 2019 Lucas. All rights reserved.
//

import UIKit
let statusBarHeight = UIApplication.shared.statusBarFrame.height;


//full screen 44pt, else 20 pt
//navigation Height
let navigationHeight = (statusBarHeight + 44)
//tabBar Height
let tabBarHeight = (statusBarHeight == 44 ? 83 : 49)
//topSafeArea Height
let topSafeAreaHeight = (statusBarHeight - 20)
//bottomSafeArea Height
let bottomSafeAreaHeight = (tabBarHeight - 49)


/*
//full screen 34pt, else 0 pt
let bottomSafeAreaHeight =  UIApplication.shared.windows.last?.safeAreaInsets.bottom ?? 0.0;

//bottomSafeAreaHeight
let bottomSafeAreaHeight =  UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 0.0
//topSafeAreaHeight
let topSafeAreaHeight = (bottomSafeAreaHeight == 0 ? 0 : 24)
//statusBarHeight
let statusBarHeight = UIApplication.shared.statusBarFrame.height;
//navigationHeight
let navigationHeight = (bottomSafeAreaHeight == 0 ? 64 : 88)
//tabBarHeight
let tabBarHeight = (bottomSafeAreaHeight + 49)

*/
