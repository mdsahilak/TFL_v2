// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation

@main
struct TFL_v1 {
    static func main() {
        print("Welcome to the TFL v2 Application")
        
        TFLNetwork.fetchInformation()
        
        conductPerformanceAnalysis()
        
    homeLoop: while true {
        showHomeMenu()
        
        guard let input = readLine(), let option = Int(input) else {
            print("Invalid Input")
            continue
        }
        
        switch option {
        case 1:
            showEngineerMenu()
            
        case 2:
            showCustomerMenu()
            
        case 3:
            print("Thank you for your time.")
            break homeLoop
            
        default:
            print("Please choose a valid option.")
        }
    }
        
    }
    
    // MARK: Common Features
    static func showHomeMenu() {
        print("Please choose a role to proceed:")
        print("1: TFL Engineer")
        print("2: Customer")
        print("3: Exit")
    }
    
    // MARK: Engineer Features
    static func showEngineerMenu() {
    engineerLoop: while true {
            print("Please choose an option:")
            print("1: Add track section delay")
            print("2: Remove track section delay")
            print("3: Close track section")
            print("4: Open track section")
            print("5: Show track section delays")
            print("6: Show closed track sections")
            print("7: Go Back")
            
            guard let input = readLine(), let option = Int(input) else {
                print("Invalid Input")
                continue
            }
            
            switch option {
            case 1:
                addTrackSectionDelay()
                
            case 2:
                removeTrackSectionDelay()
                
            case 3:
                closeTrackSection()
                
            case 4:
                openTrackSection()
                
            case 5:
                showTrackSectionDelays()
                
            case 6:
                showClosedTrackSections()
                
            case 7:
                print("<-")
                break engineerLoop
                
            default:
                print("Please choose a valid option.")
            }
        }
    }
    
    static func addTrackSectionDelay() {
        if let section = collectTrackSectionInformation(withDelay: true) {
            TFLNetwork.addDelay(section)
        } else {
            print("ERROR: Invalid Input")
        }
    }
    
    static func removeTrackSectionDelay() {
        if let section = collectTrackSectionInformation(withDelay: false) {
            TFLNetwork.removeDelay(section)
        } else {
            print("ERROR: Invalid Input")
        }
    }
    
    static func closeTrackSection() {
        if let section = collectTrackSectionInformation(withDelay: false) {
            TFLNetwork.closeSection(section)
        } else {
            print("ERROR: Invalid Input")
        }
    }
    
    static func openTrackSection() {
        if let section = collectTrackSectionInformation(withDelay: false) {
            TFLNetwork.openSection(section)
        } else {
            print("ERROR: Invalid Input")
        }
    }
    
    static func showTrackSectionDelays() {
        TFLNetwork.showDelayedSections()
    }
    
    static func showClosedTrackSections() {
        TFLNetwork.showClosedSections()
    }
    
    static func collectTrackSectionInformation(withDelay: Bool = false) -> TrackSectionInfo? {
        print("Please enter the following details for your preferred track section")
        
        print("Start Station: ")
        let start = readLine() ?? ""
        
        print("End Station: ")
        let end = readLine() ?? ""
        
        print("Line: ")
        let line = readLine() ?? ""
        
        print("Direction: ")
        let direction = readLine() ?? ""
        
        if withDelay {
            print("Delay: ")
            guard let input = readLine(), let delay = Double(input) else { return nil }
            return TrackSectionInfo(start: start, end: end, line: line, direction: direction, delay: delay)
        } else {
            return TrackSectionInfo(start: start, end: end, line: line, direction: direction)
        }
    }
    
    
    // MARK: Customer Features
    static func showCustomerMenu() {
    customerLoop: while true {
            print("Please choose an option:")
            print("1: Find a route between two stations")
            print("2: Show information about a station")
            print("3: Go Back")
            
            guard let input = readLine(), let option = Int(input) else {
                print("Invalid Input")
                continue
            }
            
            switch option {
            case 1:
                findRouteBetweenStations()
                
            case 2:
                showInformationAboutStation()
                
            case 3:
                print("<-")
                break customerLoop
                
            default:
                print("Please choose a valid option.")
            }
        }
    }
    
    static func findRouteBetweenStations() {
        print("Please enter starting station: ")
        let stationA = readLine() ?? ""
        
        print("Please enter destination station: ")
        let stationB = readLine() ?? ""
        
        if !stationA.isEmpty && !stationB.isEmpty {
            TFLNetwork.findRouteBetween(stationA: stationA, stationB: stationB)
        } else {
            print("ERROR: Invalid Input. Please retry with valid station names!")
        }
    }
    
    static func showInformationAboutStation() {
        print("Please enter the station name: ")
        let station = readLine() ?? ""
        
        TFLNetwork.showInformation(for: station)
    }
    
    // 0.002528071403503418
    static func conductPerformanceAnalysis() {
        print("**************************************")
        print("Sample Tests: For Performance Analysis")
        print("**************************************")
        
        let start = CFAbsoluteTimeGetCurrent()
        
        TFLNetwork.findRouteBetween(stationA: "Marble Arch", stationB: "Great Portland Street")
        
        let end = CFAbsoluteTimeGetCurrent()
        
        print("**************************************")
        print("Execution Time: \(end - start) seconds")
        print("**************************************")
    }
    
}


