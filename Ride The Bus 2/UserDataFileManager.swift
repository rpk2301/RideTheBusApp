import Foundation

class UserDataFileManager {
    // Define file paths
    private static let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    
    // Method to get file URL for a player's score
    private static func filePath(forPlayer playerId: String) -> URL {
        return documentsDirectory.appendingPathComponent("\(playerId).txt")
    }
    
    // Save player's score
    static func saveScore(forPlayer playerId: String, score: Int) {
        let scoreString = String(score)
        let filePath = self.filePath(forPlayer: playerId)
        do {
            try scoreString.write(to: filePath, atomically: true, encoding: .utf8)
        } catch {
            print("Error saving score for player \(playerId): \(error.localizedDescription)")
        }
    }
    
    // Load player's score
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
    
    // Method to list all player files in the documents directory
    static func listPlayerFiles() -> [URL]? {
        do {
            let fileURLs = try FileManager.default.contentsOfDirectory(at: documentsDirectory, includingPropertiesForKeys: nil, options: [])
            return fileURLs.filter { $0.pathExtension == "txt" }
        } catch {
            print("Error listing player files: \(error.localizedDescription)")
            return nil
        }
    }
    
    // Method to list all players and their scores
    static func listPlayersAndScores() {
        guard let playerFiles = listPlayerFiles() else {
            print("No player files found")
            return
        }
        
        for playerFile in playerFiles {
            // Skip the TotalScore file
            if playerFile.lastPathComponent == "TotalScore.txt" {
                continue
            }
            
            let playerId = playerFile.deletingPathExtension().lastPathComponent
            if let score = loadScore(forPlayer: playerId) {
                print("Player ID: \(playerId), Score: \(score)")
            }
        }
    }

    
    // Method to list all text files in the documents directory
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
          // Implement the logic to delete the player record with the given playerId
          // For example, if you're storing player data in files, you can delete the file corresponding to the playerId
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
               
               // Check if the "TotalScore" file exists
               if FileManager.default.fileExists(atPath: fileURL.path) {
                   // Read the content of the file as a string
                   let scoreString = try String(contentsOf: fileURL)
                   
                   // Convert the string to an integer
                   if let existingScore = Int(scoreString.trimmingCharacters(in: .whitespacesAndNewlines)) {
                       totalScore = existingScore
                   } else {
                       print("Error: Failed to convert score to integer.")
                   }
               }
               
               // Increment the total score with the new score
               totalScore += score
               
               // Write the updated total score to the "TotalScore" file
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
               // Check if the "TotalScore" file exists
               if FileManager.default.fileExists(atPath: fileURL.path) {
                   // Read the content of the file as a string
                   let scoreString = try String(contentsOf: fileURL)
                   
                   // Convert the string to an integer
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

