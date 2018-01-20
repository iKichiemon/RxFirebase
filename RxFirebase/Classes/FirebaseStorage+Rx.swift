import RxSwift
import FirebaseStorage
import FirebaseAuth

public extension Reactive where Base: StorageReference {
    
    // MARK - Download
    
    public func downloadURL() -> Single<URL> {
        return .create { observer in
            self.base.downloadURL {
                switch Result($0, $1) {
                case .success(let v): observer(.success(v))
                case .failure(let e): observer(.error(e))
                }
            }
            return Disposables.create()
        }
    }
    
    // MARK - Put
    
    public func putData(uploadData: Data, metadata: StorageMetadata? = nil) -> Single<StorageMetadata> {
        return .create { observer in
            self.base.putData(uploadData, metadata: metadata) {
                switch Result($0, $1) {
                case .success(let v): observer(.success(v))
                case .failure(let e): observer(.error(e))
                }
            }
            return Disposables.create()
        }
    }
    
    public func putFile(from url: URL, metadata: StorageMetadata? = nil) -> Single<StorageMetadata> {
        return .create { observer in
            self.base.putFile(from: url, metadata: metadata) {
                switch Result($0, $1) {
                case .success(let v): observer(.success(v))
                case .failure(let e): observer(.error(e))
                }
            }
            return Disposables.create()
        }
    }
    
    // MARK - Get
    
    public func getData(maxSize: Int64) -> Observable<Data> {
        return .create { observer in
            self.base.getData(maxSize: maxSize) {
                switch Result($0, $1) {
                case .success(let v): observer.onNext(v)
                case .failure(let e): observer.onError(e)
                }
            }
            return Disposables.create()
        }
    }
    
    public func getMetadata() -> Observable<StorageMetadata> {
        return .create { observer in
            self.base.getMetadata {
                switch Result($0, $1) {
                case .success(let v): observer.onNext(v)
                case .failure(let e): observer.onError(e)
                }
            }
            return Disposables.create()
        }
    }
    
    // MARK - Delete
    
    public func delete() -> Single<Void> {
        return .create { observer in
            self.base.delete { maybeError in
                if let error = maybeError {
                    observer(.error(error))
                } else {
                    observer(.success(()))
                }
            }
            return Disposables.create()
        }
    }
    
    // MARK - Update
    
    public func updateMetadata(updateMetadata: StorageMetadata) -> Observable<StorageMetadata> {
        return .create { observer in
            self.base.updateMetadata(updateMetadata) {
                switch Result($0, $1) {
                case .success(let v): observer.onNext(v)
                case .failure(let e): observer.onError(e)
                }
            }
            return Disposables.create()
        }
    }
    
    // MARK - Write
    
    public func write(toFile url: URL) -> Observable<URL> {
        return .create { observer in
            self.base.write(toFile: url) {
                switch Result($0, $1) {
                case .success(let v): observer.onNext(v)
                case .failure(let e): observer.onError(e)
                }
            }
            return Disposables.create()
        }
    }
}

