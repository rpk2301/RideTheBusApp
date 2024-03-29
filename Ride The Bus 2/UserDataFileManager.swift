import Foundation

class UserDataFileManager {
    private static let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    
    
    private static func filePath(forPlayer playerId: String) -> URL {
        return documentsDirectory.appendingPathComponent("\(playerId).txt")
    }
    
    static func saveScore(forPlayer playerId: String, score: Int) {
        let scoreString = String(score)
        let filePath = self.filePath(forPlayer: playerId)
        do {
            try scoreString.write(to: filePath, atomically: true, encoding: .utf8)
        } catch {
            print("Error saving score for player \(playerId): \(error.localizedDescription)")
        }
    }
    
 
    static func loadScore(forPlayer playerId: String) -> Int? {
        let filePath = self.filePath(forPlayer: playerId)
        do {
            let scoreString = try String(contentsOf: filePath, encoding: .utf8)
            if let score = Int(scoreString) {
                return score
            } else {
                print("Error converting score for player \(playerId) to integer")
                return nil
            }
        } catch {
            print("Error loading score for player \(playerId): \(error.localizedDescription)")
            return nil
        }
    }
    
   
    static func listPlayerFiles() -> [URL]? {
        do {
            let fileURLs = try FileManager.default.contentsOfDirectory(at: documentsDirectory, includingPropertiesForKeys: nil, options: [])
            return fileURLs.filter { $0.pathExtension == "txt" }
        } catch {
            print("Error listing player files: \(error.localizedDescription)")
            return nil
        }
    }
    
   
    static func listPlayersAndScores() {
        guard let playerFiles = listPlayerFiles() else {
            print("No player files found")
            return
        }
        
        for playerFile in playerFiles {
          
            if playerFile.lastPathComponent == "TotalScore.txt" {
                continue
            }
            
            let playerId = playerFile.deletingPathExtension().lastPathComponent
            if let score = loadScore(forPlayer: playerId) {
                print("Player ID: \(playerId), Score: \(score)")
            }
        }
    }

    static func listTextFiles() -> [String]? {
        do {
            print("listing text files")
            let fileURLs = try FileManager.default.contentsOfDirectory(at: documentsDirectory, includingPropertiesForKeys: nil, options: [])
            return fileURLs.filter { $0.pathExtension == "txt" }.map { $0.lastPathComponent }
        } catch {
            print("Error listing text files: \(error.localizedDescription)")
            return nil
        }
    }
    static func deletePlayer(_ playerId: String) {
          guard let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
              return
          }
          let fileURL = url.appendingPathComponent("\(playerId).txt")
          
          do {
              try FileManager.default.removeItem(at: fileURL)
          } catch {
              print("Error deleting player record:", error)
          }
      }
    
    static func writeTotalScore(_ score: Int) {
           guard let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
               print("Error: Unable to access documents directory.")
               return
           }
           
           let fileURL = url.appendingPathComponent("TotalScore.txt")
           
           do {
               var totalScore = 0
               
               if FileManager.default.fileExists(atPath: fileURL.path) {
                 
                   let scoreString = try String(contentsOf: fileURL)
                   
                   
                   if let existingScore = Int(scoreString.trimmingCharacters(in: .whitespacesAndNewlines)) {
                       totalScore = existingScore
                   } else {
                       print("Error: Failed to convert score to integer.")
                   }
               }
               
             
               totalScore += score
               
               try "\(totalScore)".write(to: fileURL, atomically: true, encoding: .utf8)
           } catch {
               print("Error writing score to TotalScore file:", error)
           }
       }
    
    
    
    static func displayTotalScore() -> Int {
           guard let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
               print("Error: Unable to access documents directory.")
               return 0
           }
           
           let fileURL = url.appendingPathComponent("TotalScore.txt")
           
           do {
               
               if FileManager.default.fileExists(atPath: fileURL.path) {
               
                   let scoreString = try String(contentsOf: fileURL)
                   
             
                   if let score = Int(scoreString.trimmingCharacters(in: .whitespacesAndNewlines)) {
                       return score
                   } else {
                       print("Error: Failed to convert score to integer.")
                       return 0
                   }
               } else {
                   print("Error: TotalScore file does not exist.")
                   return 0
               }
           } catch {
               print("Error reading TotalScore file:", error)
               return 0
           }
       }
}

