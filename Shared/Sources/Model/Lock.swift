//
//  Location.swift
//  Shared
//
//  Created by Laptop 3 on 24/12/2020.
//
public enum Lock: String, CaseIterable, Equatable {
    case stJohns = "st"
    case buscot
    case grafton
    case radcot
    case rushey
    case shifford
    case northmoor
    case pinkhill
    case eynsham
    case kings
    case godstow
    case osney
    case iffley
    case sandford
    case abingdon
    case culham
    case clifton
    case days
    case benson
    case cleeve
    case goring
    case whitchurch
    case mapledurham
    case caversham
    case sonning
    case shiplake
    case marsh
    case hambleden
    case hurley
    case temple
    case marlow
    case cookham
    case boulters
    case bray
    case boveney
    case romney
    case oldWindsor = "old"
    case bellWeir = "bell"
    case pentonHook = "penton"
    case chertsey
    case shepperton
    case sunbury
    case molesey
    case teddington
}
extension Lock {
    public var previous: Lock? {
        guard let currentIndex = Lock.allCases.firstIndex(of: self) else {
            return nil
        }
        let previousIndex = Lock.allCases.index(currentIndex, offsetBy: -1)
        guard previousIndex >= 0 else {
            return nil
        }
        return Lock.allCases[previousIndex]
    }

    public var next: Lock? {
        guard let currentIndex = Lock.allCases.firstIndex(of: self) else {
            return nil
        }
        let nextIndex = Lock.allCases.index(currentIndex, offsetBy: 1)
        guard nextIndex < Lock.allCases.count else {
            return nil
        }
        return Lock.allCases[nextIndex]
    }
}
extension Lock: Comparable {
    public static func < (lhs: Lock, rhs: Lock) -> Bool {
        guard let lhsNext = lhs.next else {
            return false
        }
        return lhsNext == rhs ||
            lhsNext < rhs
    }
}
