//
//  SharedTests.swift
//  SharedTests
//
//  Created by Laptop 3 on 07/02/2021.
//
@testable import Shared
import XCTest

final class LockTests: XCTestCase {
    func test_previous() {
        XCTAssertEqual(Lock.stJohns.previous, nil)
        XCTAssertEqual(Lock.buscot.previous, .stJohns)
        XCTAssertEqual(Lock.grafton.previous, .buscot)
        XCTAssertEqual(Lock.radcot.previous, .grafton)
        XCTAssertEqual(Lock.rushey.previous, .radcot)
        XCTAssertEqual(Lock.shifford.previous, .rushey)
        XCTAssertEqual(Lock.northmoor.previous, .shifford)
        XCTAssertEqual(Lock.pinkhill.previous, .northmoor)
        XCTAssertEqual(Lock.eynsham.previous, .pinkhill)
        XCTAssertEqual(Lock.kings.previous, .eynsham)
        XCTAssertEqual(Lock.godstow.previous, .kings)
        XCTAssertEqual(Lock.osney.previous, .godstow)
        XCTAssertEqual(Lock.iffley.previous, .osney)
        XCTAssertEqual(Lock.sandford.previous, .iffley)
        XCTAssertEqual(Lock.abingdon.previous, .sandford)
        XCTAssertEqual(Lock.culham.previous, .abingdon)
        XCTAssertEqual(Lock.clifton.previous, .culham)
        XCTAssertEqual(Lock.days.previous, .clifton)
        XCTAssertEqual(Lock.benson.previous, .days)
        XCTAssertEqual(Lock.cleeve.previous, .benson)
        XCTAssertEqual(Lock.goring.previous, .cleeve)
        XCTAssertEqual(Lock.whitchurch.previous, .goring)
        XCTAssertEqual(Lock.mapledurham.previous, .whitchurch)
        XCTAssertEqual(Lock.caversham.previous, .mapledurham)
        XCTAssertEqual(Lock.sonning.previous, .caversham)
        XCTAssertEqual(Lock.shiplake.previous, .sonning)
        XCTAssertEqual(Lock.marsh.previous, .shiplake)
        XCTAssertEqual(Lock.hambleden.previous, .marsh)
        XCTAssertEqual(Lock.hurley.previous, .hambleden)
        XCTAssertEqual(Lock.temple.previous, .hurley)
        XCTAssertEqual(Lock.marlow.previous, .temple)
        XCTAssertEqual(Lock.cookham.previous, .marlow)
        XCTAssertEqual(Lock.boulters.previous, .cookham)
        XCTAssertEqual(Lock.bray.previous, .boulters)
        XCTAssertEqual(Lock.boveney.previous, .bray)
        XCTAssertEqual(Lock.romney.previous, .boveney)
        XCTAssertEqual(Lock.oldWindsor.previous, .romney)
        XCTAssertEqual(Lock.bellWeir.previous, .oldWindsor)
        XCTAssertEqual(Lock.pentonHook.previous, .bellWeir)
        XCTAssertEqual(Lock.chertsey.previous, .pentonHook)
        XCTAssertEqual(Lock.shepperton.previous, .chertsey)
        XCTAssertEqual(Lock.sunbury.previous, .shepperton)
        XCTAssertEqual(Lock.molesey.previous, .sunbury)
        XCTAssertEqual(Lock.teddington.previous, .molesey)
    }

    func test_next() {
        XCTAssertEqual(Lock.stJohns.next, .buscot)
        XCTAssertEqual(Lock.buscot.next, .grafton)
        XCTAssertEqual(Lock.grafton.next, .radcot)
        XCTAssertEqual(Lock.radcot.next, .rushey)
        XCTAssertEqual(Lock.rushey.next, .shifford)
        XCTAssertEqual(Lock.shifford.next, .northmoor)
        XCTAssertEqual(Lock.northmoor.next, .pinkhill)
        XCTAssertEqual(Lock.pinkhill.next, .eynsham)
        XCTAssertEqual(Lock.eynsham.next, .kings)
        XCTAssertEqual(Lock.kings.next, .godstow)
        XCTAssertEqual(Lock.godstow.next, .osney)
        XCTAssertEqual(Lock.osney.next, .iffley)
        XCTAssertEqual(Lock.iffley.next, .sandford)
        XCTAssertEqual(Lock.sandford.next, .abingdon)
        XCTAssertEqual(Lock.abingdon.next, .culham)
        XCTAssertEqual(Lock.culham.next, .clifton)
        XCTAssertEqual(Lock.clifton.next, .days)
        XCTAssertEqual(Lock.days.next, .benson)
        XCTAssertEqual(Lock.benson.next, .cleeve)
        XCTAssertEqual(Lock.cleeve.next, .goring)
        XCTAssertEqual(Lock.goring.next, .whitchurch)
        XCTAssertEqual(Lock.whitchurch.next, .mapledurham)
        XCTAssertEqual(Lock.mapledurham.next, .caversham)
        XCTAssertEqual(Lock.caversham.next, .sonning)
        XCTAssertEqual(Lock.sonning.next, .shiplake)
        XCTAssertEqual(Lock.shiplake.next, .marsh)
        XCTAssertEqual(Lock.marsh.next, .hambleden)
        XCTAssertEqual(Lock.hambleden.next, .hurley)
        XCTAssertEqual(Lock.hurley.next, .temple)
        XCTAssertEqual(Lock.temple.next, .marlow)
        XCTAssertEqual(Lock.marlow.next, .cookham)
        XCTAssertEqual(Lock.cookham.next, .boulters)
        XCTAssertEqual(Lock.boulters.next, .bray)
        XCTAssertEqual(Lock.bray.next, .boveney)
        XCTAssertEqual(Lock.boveney.next, .romney)
        XCTAssertEqual(Lock.romney.next, .oldWindsor)
        XCTAssertEqual(Lock.oldWindsor.next, .bellWeir)
        XCTAssertEqual(Lock.bellWeir.next, .pentonHook)
        XCTAssertEqual(Lock.pentonHook.next, .chertsey)
        XCTAssertEqual(Lock.chertsey.next, .shepperton)
        XCTAssertEqual(Lock.shepperton.next, .sunbury)
        XCTAssertEqual(Lock.sunbury.next, .molesey)
        XCTAssertEqual(Lock.molesey.next, .teddington)
        XCTAssertEqual(Lock.teddington.next, nil)
    }

    func test_comparable() {
        Lock.allCases.suffix(from: 1).forEach {
            XCTAssertLessThan(Lock.stJohns, $0)
        }
        Lock.allCases.prefix(upTo: Lock.allCases.count - 1).forEach {
            XCTAssertGreaterThan(Lock.teddington, $0)
        }
    }
}
