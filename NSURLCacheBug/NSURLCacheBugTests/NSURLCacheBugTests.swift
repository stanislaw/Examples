//
//  NSURLCacheBugTests.swift
//  NSURLCacheBugTests
//
//  Created by Stanislaw Pankevich on 09/11/16.
//  Copyright © 2016 Stanislav Pankevich. All rights reserved.
//

import XCTest
@testable import NSURLCacheBug

let fakeFileURL1 = URL(string: "https://foo.bar/RandomFile1.test")!
let fakeFileURL2 = URL(string: "https://foo.bar/RandomFile2.test")!
let fakeFileURL3 = URL(string: "https://foo.bar/RandomFile3.test")!

class NSURLCacheBugTests: XCTestCase {

    func testExample() {
      let fileURL = Bundle(for: type(of: self)).url(forResource: "c++", withExtension: "pdf")!

      let data1 = try! Data(contentsOf: fileURL)
      let data2 = try! Data(contentsOf: fileURL)
      let data3 = try! Data(contentsOf: fileURL)

      print("data size is \(data1.count)")
      print("data size is \(data2.count)")
      print("data size is \(data3.count)")

      let request1 = URLRequest(url: fakeFileURL1)
      let request2 = URLRequest(url: fakeFileURL2)
      let request3 = URLRequest(url: fakeFileURL3)

      let HTTPHeaders = [String:String]() //["Cache-Control": "public, max-age=604800"]
      //let HTTPHeaders = ["Cache-Control": "public, max-age=604800"]

      let response1 = HTTPURLResponse(url: fakeFileURL1,
                                      statusCode: 200,
                                      httpVersion: "HTTP/1.1",
                                      headerFields: HTTPHeaders)!

      let response2 = HTTPURLResponse(url: fakeFileURL2,
                                      statusCode: 200,
                                      httpVersion: "HTTP/1.1",
                                      headerFields: HTTPHeaders)!

      let response3 = HTTPURLResponse(url: fakeFileURL3,
                                      statusCode: 200,
                                      httpVersion: "HTTP/1.1",
                                      headerFields: HTTPHeaders)!

      let cachedResponse1 = CachedURLResponse(response: response1, data: data1)
      let cachedResponse2 = CachedURLResponse(response: response2, data: data2)
      let cachedResponse3 = CachedURLResponse(response: response3, data: data3)

      clearTmpDirectory()

      let diskPath = "\(NSTemporaryDirectory())CachePath"

      print("disk path \(diskPath)")

      let cache = URLCache(memoryCapacity: 0, diskCapacity: 200 * 1024 * 1024, diskPath: diskPath)

      print("cache currentDiskUsage: \(cache.currentDiskUsage), currentMemoryUsage: \(cache.currentMemoryUsage)")

      cache.removeAllCachedResponses()
      print("cache currentDiskUsage: \(cache.currentDiskUsage), currentMemoryUsage: \(cache.currentMemoryUsage)")

      cache.removeCachedResponses(since: Date.distantPast)
      print("cache currentDiskUsage: \(cache.currentDiskUsage), currentMemoryUsage: \(cache.currentMemoryUsage)")

      cache.storeCachedResponse(cachedResponse1, for: request1)
      cache.storeCachedResponse(cachedResponse2, for: request2)
      cache.storeCachedResponse(cachedResponse3, for: request3)

      let cachedResponse_1 = cache.cachedResponse(for: request1)!
      let cachedResponse_2 = cache.cachedResponse(for: request2)!
      let cachedResponse_3 = cache.cachedResponse(for: request3)!

      XCTAssertEqual(cachedResponse_1.data, data1)
      XCTAssertEqual(cachedResponse_2.data, data2)
      XCTAssertEqual(cachedResponse_3.data, data3)

      print("cache currentDiskUsage: \(cache.currentDiskUsage), currentMemoryUsage: \(cache.currentMemoryUsage)")
    }

    func clearTmpDirectory() {
      do {
        let tmpDirectory = try FileManager.default.contentsOfDirectory(atPath: NSTemporaryDirectory())
        try tmpDirectory.forEach { file in
          print("deleting file at path: \(file)")

          let path = String.init(format: "%@%@", NSTemporaryDirectory(), file)
          try FileManager.default.removeItem(atPath: path)
        }
      } catch {
        print(error)
      }
  }
}
