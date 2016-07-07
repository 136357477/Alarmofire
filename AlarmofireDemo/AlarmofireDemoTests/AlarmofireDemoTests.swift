//
//  AlarmofireDemoTests.swift
//  AlarmofireDemoTests
//
//  Created by guohui on 16/5/10.
//  Copyright © 2016年 guohui. All rights reserved.
//

import XCTest
import Alamofire

@testable import AlarmofireDemo

class AlarmofireDemoTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        //TODO:测试的操作
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        //TODO:测试完成的操作
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    //自己写的测试请求的方法
    let URLStringGetBooks = "https://api.douban.com/v2/book/search"
    //使用 框架 模拟runtime 的功能
    func testAlamofireRequest(){
        let expection = expectationWithDescription("expection")
        Alamofire.request(.GET, URLStringGetBooks, parameters: ["tag":"swift","count":1], encoding: .URL, headers: nil).responseJSON { (resp) in
            if let error = resp.result.error{
                print(error)
            }else if let value = resp.result.value{
                print(value)
            }
            expection.fulfill()
        }
        waitForExpectationsWithTimeout(10, handler: nil)
    }
    
    //Alamofire 下载功能
    var resumeData = NSData()
    func testAlamofireDownLoad(){
       let URLStringImage = "http://img.pconline.com.cn/images/photoblog/1/7/7/4/1774994/20063/28/1143511691007.JPG"
        let expection2 = expectationWithDescription("expection2")
        print(NSHomeDirectory())
  
        Alamofire.download(.GET, URLStringImage, destination: Alamofire.Request.suggestedDownloadDestination()).progress { (readBytes, totalBytestRead, totalBytesExpectedToRead) in
            let progress = Int(Double(totalBytestRead)/Double(totalBytesExpectedToRead) * 100)
            print("\(progress)%")
        }.response { (requ, resp, data, error) in
            if let error = error{
                print(error)
                if let data = data{
                    self.resumeData = data
                }       
            }else{
                print("Download Successfully!")
            }
            expection2.fulfill()
        }
        waitForExpectationsWithTimeout(80, handler: nil)
    }
    
    
    
    
    //测试方法1
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
       
        
    }
    //测试方法2
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}
