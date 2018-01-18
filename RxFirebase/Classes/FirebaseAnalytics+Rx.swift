import RxSwift
import FirebaseStorage

public extension Reactive where Base: StorageReference {

    // MARK - put

    public func putData(uploadData: Data, metadata: StorageMetadata? = nil) -> Observable<StorageUploadTask> {
        return .create { observer in
            observer.onNext(self.base.putData(uploadData, metadata: metadata, completion: { (metadata, error) in
            }))
            return Disposables.create()
        }
    }

    public func putFile(from url: URL, metadata: StorageMetadata? = nil) -> Observable<StorageUploadTask> {
        return .create { observer in
            observer.onNext(self.base.putFile(from: url, metadata: metadata, completion: { (metadata, error) in
            }))
            return Disposables.create()
        }
    }


    // MARK - get

    public func getData(maxSize: Int64) -> Observable<Data> {
        return .create { observer in
            self.base.getData(maxSize: maxSize) { (data, error) in
                observer.onNext()
            }
            return Disposables.create()
        }
    }

    public func getMetadata() -> Observable<StorageDownloadTask> {
        return .create { observer in
            self.base.getMetadata(completion: { metadata, error in
                switch (metadata, error) {
                case (.some(let meta), .none): observer.onNext(meta)
                case (.none, .some(let error)): observer.onError(error)
                default: fatalError()
                }
            })
            return Disposables.create()
        }
    }
}

public struct Test {
    let a: String
    public init(a: String) {
        self.a = a
    }
    func b() {
        let store = Storage.storage().reference().child("a")
    }
}

