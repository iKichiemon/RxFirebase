import RxSwift
import FirebaseFirestore

// MARK: - Firestore

extension Reactive where Base: Firestore {
   
    enum TransactionError: Error {
        case cannotGetObject
    }
    
    public func runTransaction<T>(updateBlock: @escaping (Transaction, NSErrorPointer) -> T?) -> Single<T> {
        return .create { observer in
            self.base.runTransaction(updateBlock) {
                switch Result($0, $1) {
                case .success(let v as T): observer(.success(v))
                case .failure(let e): observer(.error(e))
                default: observer(.error(TransactionError.cannotGetObject))
                }
            }
            return Disposables.create()
        }
    }
}

// MARK: - WriteBatch

extension Reactive where Base: WriteBatch {
    
    public func commit() -> Completable {
        return .create { observer in
            self.base.commit {
                if let error = $0 {
                    observer(.error(error))
                } else {
                    observer(.completed)
                }
            }
            return Disposables.create()
        }
    }
}

// MARK: - DocumentReference

extension Reactive where Base: DocumentReference {
    
    public func updateData(fields: [AnyHashable: Any]) -> Completable {
        return .create { observer in
            self.base.updateData(fields) {
                if let error = $0 {
                    observer(.error(error))
                } else {
                    observer(.completed)
                }
            }
            return Disposables.create()
        }
    }
    
    public func setData(documentData: [String: Any], merge: Bool) -> Completable {
        return .create { observer in
            self.base.setData(documentData, merge: merge) {
                if let error = $0 {
                    observer(.error(error))
                } else {
                    observer(.completed)
                }
            }
            return Disposables.create()
        }
    }
    
    public func setData(documentData: [String: Any]) -> Completable {
        return .create { observer in
            self.base.setData(documentData) {
                if let error = $0 {
                    observer(.error(error))
                } else {
                    observer(.completed)
                }
            }
            return Disposables.create()
        }
    }
    
    public func addSnapshotListener(data: [String: Any]) -> Observable<DocumentSnapshot> {
        return .create { observer in
            let listener = self.base.addSnapshotListener {
                switch Result($0, $1) {
                case .success(let v): observer.onNext(v)
                case .failure(let e): observer.onError(e)
                }
            }
            return Disposables.create {
                listener.remove()
            }
        }
    }
    
}

// MARK: - CollectionReference

extension Reactive where Base: CollectionReference {
    
    public func addDocuments(data: [String: Any]) -> Completable {
        return .create { observer in
            self.base.addDocument(data: data) {
                if let error = $0 {
                    observer(.error(error))
                } else {
                    observer(.completed)
                }
            }
            return Disposables.create()
        }
    }
    
    public func getDocuments() -> Observable<QuerySnapshot> {
        return .create { observer in
            self.base.getDocuments {
                switch Result($0, $1) {
                case .success(let v): observer.onNext(v)
                case .failure(let e): observer.onError(e)
                }
            }
            return Disposables.create()
        }
    }
}

// MARK: - Query

extension Reactive where Base: Query {
    
    public func addSnapshotListener() -> Observable<QuerySnapshot> {
        return self.addSnapshotListener(includeMetadataChanges: false)
    }
    
    public func addSnapshotListener(includeMetadataChanges: Bool) -> Observable<QuerySnapshot> {
        return .create { observer in
            let listener = self.base.addSnapshotListener(includeMetadataChanges: includeMetadataChanges) {
                switch Result($0, $1) {
                case .success(let v): observer.onNext(v)
                case .failure(let e): observer.onError(e)
                }
            }
            return Disposables.create {
                listener.remove()
            }
        }
    }
    
}
