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

    private final let TAG = "Tests: ";
    
    func test_StoryboardFullInformation() {
        let fullInfo = Utilities.getFullInfoViewController();
        
        XCTAssertNotNil(fullInfo);
    }

    func test_downloadImage() {
        
        let testUrl = "https://mobile-olympiad-trajectory.hb.bizmrg.com/logo-vk.png";
        let expectation = self.expectation(description: "Waiting some data for image");
        
        NetworkUtilities.downloadImage(
            testUrl,
            completion: {
                image in
                expectation.fulfill();
            },
            onFailed:{
                errorMessageUI in
                XCTFail(errorMessageUI);
            }
        );
        
        waitForExpectations(timeout: 8.0) { // 8000 ms
            error in
            XCTAssertNil(error);
        }
        
    }
    
    func test_downloadFile() {
        
        let testUrl = "https://mobile-olympiad-trajectory.hb.bizmrg.com/ezgif-5-77f791c63c.gif";
        let expectation = self.expectation(description: "Waiting some bytes");
        
        var data: Data?;
        
        NetworkUtilities.downloadFile(
            testUrl,
            completion: {
                _data in
                data = _data;
                expectation.fulfill();
            }, onFailed: {
                error in
                XCTAssertNil(error);
            });
        
        waitForExpectations(timeout: 8.0) { // 8000 ms
            error in
            XCTAssertNil(error);
            XCTAssertNotNil(data);
            XCTAssertNotEqual(data?.count, 0);
        }
    }
    
    func test_getJSONFile() {
        
        let testUrl = "https://mobile-olympiad-trajectory.hb.bizmrg.com/semi-final-data.json";
        
        var services: ServicesArray? = nil;
        
        let expectation = self.expectation(description: "Waiting a JSON-data with services");
        
        NetworkUtilities.downloadJSONFile(
            testUrl,
            completion: {
                (servicesArray: ServicesArray?) in
                services = servicesArray;
                expectation.fulfill();
            },
            onFailed: {
                errorMessageUI in
                print(self.TAG, errorMessageUI);
                XCTFail();
            });
        
        waitForExpectations(timeout: 8.0) { // 8000 ms
            error in
            XCTAssertNil(error);
            XCTAssertNotNil(services);
            XCTAssertNotNil(services?.items);
        }
    }
    
}
