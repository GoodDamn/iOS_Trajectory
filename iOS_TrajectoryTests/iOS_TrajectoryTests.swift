//
//  iOS_TrajectoryTests.swift
//  iOS_TrajectoryTests
//
//  Created by Cell on 18.02.2023.
//

import XCTest
import UIKit;
@testable import iOS_Trajectory

class iOS_TrajectoryTests: XCTestCase {

    let idCell = "service_element";
    
    func test_StoryboardFullInformation() {
        let fullInfo = Utilities.getFullInfoViewController();
        
        XCTAssertNotNil(fullInfo);
    }
    
    func test_ServiceUITableViewCell_id() {
        XCTAssertEqual(Utilities.ID_SERVICES_ELEMENT_CELL, idCell);
    }
}
