// Foundation not needed



struct Queens {
    
    #if swift(>=3.0)
    enum InitError: ErrorProtocol {
        case SameSpace
        case IncorrectNumberOfCoordinates
        case InvalidCoordinates
    }
    #else
    enum InitError: ErrorType {
    case SameSpace
    case IncorrectNumberOfCoordinates
    case InvalidCoordinates
    }
    #endif
    
    
    let white: [Int]
    let black: [Int]
    var canAttack: Bool {
        return onHorizontal || onVertical || onDiagonal
    }
    
    private var onHorizontal: Bool {
        return white[0] == black[0]
    }
    private var onVertical: Bool {
        return white[1] == black[1]
    }
    private var onDiagonal: Bool {
        return abs(black[1] - black[0]) == abs(white[1] - white[0])
    }
    
    init(white: [Int] = [0, 3], black: [Int] = [7, 3]) throws {
        guard white.count == 2 && black.count == 2 else {
            throw InitError.IncorrectNumberOfCoordinates
        }
        
        for number in white + black {
            guard number >= 0 && number <= 7 else {
                throw InitError.InvalidCoordinates
            }
        }
        
        guard white != black else {
            throw InitError.SameSpace
        }
        
        self.white = white
        self.black = black
    }
    
}

extension Queens: CustomStringConvertible {
    var description: String {
        #if swift(>=3.0)
            let row = [String](repeating: "_", count: 8)
            var board = [[String]](repeating: row, count: 8)
        #else
            let row = [String](count: 8, repeatedValue: "_")
            var board = [[String]](count: 8, repeatedValue: row)
            
        #endif
        
        board[white[0]][white[1]] = "W"
        board[black[0]][black[1]] = "B"
        
        var rows = [String]()
        #if swift(>=3.0)
            
            for row in board {
                rows.append(row.joined(separator: " "))
            }
            return rows.joined(separator: "\n")
        #else
            for row in board {
            rows.append(row.joinWithSeparator(" "))
            }
            return rows.joinWithSeparator("\n")
        #endif
        
    }
}