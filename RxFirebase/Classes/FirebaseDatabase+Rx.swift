import RxSwift
import FirebaseDatabase

extension Reactive where Base: DatabaseReference {
    
    public func runTransaction(block: @escaping (MutableData) -> TransactionResult, withLocalEvents: Bool)  -> Single<DataSnapshot> {
        return .create { observer in
            self.base.runTransactionBlock(block, andCompletionBlock: {
                switch Result($2, $0) {
                case .success(let v): observer(.success(v))
                case .failure(let e): observer(.error(e))
                }
            }, withLocalEvents: withLocalEvents)
            return Disposables.create()
        }
    }

    public func removeValue() -> Single<DatabaseReference> {
        return .create { observer in
            self.base.removeValue {
                switch Result($1, $0) {
                case .success(let v): observer(.success(v))
                case .failure(let e): observer(.error(e))
                }
            }
            return Disposables.create()
        }
    }
    
    public func updateChildValues(values: [AnyHashable: Any]) -> Single<DatabaseReference> {
        return .create { observer in
            self.base.updateChildValues(values) {
                switch Result($1, $0) {
                case .success(let v): observer(.success(v))
                case .failure(let e): observer(.error(e))
                }
            }
            return Disposables.create()
        }
    }
    
    public func observeSingleEvent(eventType: DataEventType) -> Single<DataSnapshot> {
        return .create { observer in
            self.base.observeSingleEvent(of: eventType, with: { observer(.success($0)) }, withCancel: { observer(.error($0)) })
            return Disposables.create()
        }
    }
    
    public func observe(eventType: DataEventType) -> Observable<DataSnapshot> {
        return .create { observer in
            let refHandle = self.base.observe(eventType, with: { observer.onNext($0) }, withCancel: { observer.onError($0) })
            return Disposables.create {
                self.base.removeObserver(withHandle: refHandle)
            }
        }
    }
    
    public func observeAndPreviousSiblingKey(eventType: DataEventType) -> Observable<(DataSnapshot, String?)> {
        return .create { observer in
            let refHandle = self.base.observe(eventType, andPreviousSiblingKeyWith: {  observer.onNext(($0, $1)) })
            return Disposables.create {
                self.base.removeObserver(withHandle: refHandle)
            }
        }
    }

    public func setValue(value: Any?) -> Observable<DatabaseReference> {
        return .create { observer in
            self.base.setValue(value) {
                switch Result($1, $0) {
                case .success(let v): observer.onNext(v)
                case .failure(let e): observer.onError(e)
                }
            }
            return Disposables.create()
        }
    }
    
    public func setValue(value: Any?, andPriority: Any?) -> Observable<DatabaseReference> {
        return .create { observer in
            self.base.setValue(value, andPriority: andPriority) {
                switch Result($1, $0) {
                case .success(let v): observer.onNext(v)
                case .failure(let e): observer.onError(e)
                }
            }
            return Disposables.create()
        }
    }
}
