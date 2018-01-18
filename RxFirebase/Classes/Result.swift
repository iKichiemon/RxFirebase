import Foundation

enum Result<T> {
    case success(T)
    case failure(Error)
    
    enum ResultError: Error {
        case invalidImpelement
    }
    
    init(_ maybeValue: T?, _ maybeError: Error?) {
        switch (maybeValue, maybeError) {
        case (.some(let v), .none): self = .success(v)
        case (.none, .some(let error)): self = .failure(error)
        default: self = .failure(ResultError.invalidImpelement)
        }
    }
}
