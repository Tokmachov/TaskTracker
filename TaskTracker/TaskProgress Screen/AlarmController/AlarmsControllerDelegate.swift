//
//  TaskTimeOutAlarmReceivingDelegate.swift
//  TaskKiller
//
//  Created by mac on 31/01/2019.
//  Copyright © 2019 Oleg Tokmachov. All rights reserved.
//

import Foundation

protocol AlarmsControllerDelegate {
    func alarmsController(_ alarmsController: AlarmsControlling, didReceiveAlarmWithResponseType responseType: AlarmResponseType)
    func didReceiveAlarmInForeGround(from alarmsController: AlarmsControlling)
    func didDismissAlarm(_ alarmsController: AlarmsControlling)
}
