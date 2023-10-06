//
//  FrankensteinTests.swift
//  FrankensteinTests
//
//  Created by Merouane Bellaha on 06/10/2023.
//

import XCTest
@testable import Frankenstein

final class HomeViewModelTests: XCTestCase {
    func test_addTask() {
        // given
        let sut = HomeViewModel()

        // when
        sut.addTask(named: "do something")

        // then
        XCTAssertEqual(sut.tasks.count, 2)
        XCTAssertEqual(sut.tasks.last?.name, "do something")
        XCTAssertTrue(sut.futureTaskName.isEmpty)
    }

    func test_deleteTask() {
        // given
        let sut = HomeViewModel()
        sut.addTask(named: "do something")
        sut.addTask(named: "do something else")

        // when
        sut.deleteTask(atIndex: IndexSet(integer: 1))

        // then
        XCTAssertEqual(sut.tasks.count, 2)
        XCTAssertEqual(sut.tasks.last?.name, "do something else")
        XCTAssertFalse(sut.tasks.contains(where: { $0.name == "do something" }))
    }
}
