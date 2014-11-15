//
//  CLAuthorizationStatusExtras.swift
//  LocationExample
//
//  Created by Jeff Kempista on 11/15/14.
//  Copyright (c) 2014 Jeff Kempista. All rights reserved.
//

import Foundation
import CoreLocation

public extension CLAuthorizationStatus {
    public func toString() -> String {
        switch self {
        case .Authorized:
            return "Authorized"
        case .AuthorizedWhenInUse:
            return "Authorized When In Use"
        case .Denied:
            return "Denied"
        case .NotDetermined:
            return "Not Determined"
        case .Restricted:
            return "Restricted"
        }
    }
}
