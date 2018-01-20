//
//  ViewController.swift
//  RxFirebase
//
//  Created by iKichiemon on 01/16/2018.
//  Copyright (c) 2018 iKichiemon. All rights reserved.
//

import UIKit
import RxSwift
import RxFirebase
import FirebaseDatabase

class ViewController: UITableViewController {

    private var comments: [DataSnapshot] = []
    private var disposeBag = DisposeBag()
    private var ref: DatabaseReference!

    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference().child("examples")
        
        ref.rx
            .observeSingleEvent(eventType: .value)
            .subscribeOn(MainScheduler.instance)
            .subscribe(onSuccess: { [weak self] snapshot in
                    self?.comments = snapshot.children.allObjects as! [DataSnapshot]
                    self?.tableView.reloadData()
                },
                onError: nil)
            .disposed(by: disposeBag)
        
        ref.rx
            .observe(eventType: .childAdded)
            .subscribeOn(MainScheduler.instance)
            .subscribe(
                onNext: { [weak self] snapshot in
                    self?.comments.append(snapshot)
                    self?.tableView.reloadData()
                },
                onError: nil,
                onCompleted: nil,
                onDisposed: nil)
            .disposed(by: disposeBag)

        ref.rx
            .observe(eventType: .childRemoved)
            .subscribeOn(MainScheduler.instance)
            .subscribe(
                onNext: { [weak self] snapshot in
                    guard self?.comments.count != 0 else { return }
                    guard let index = self?.indexOfMessage(snapshot)  else { return }
                    self?.comments.remove(at: index)
                    self?.tableView.reloadData()
                },
                onError: nil,
                onCompleted: nil,
                onDisposed: nil)
            .disposed(by: disposeBag)
    }
    
    private func indexOfMessage(_ snapshot: DataSnapshot) -> Int? {
        return self.comments.index(of: snapshot)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        let text = comments[indexPath.row].value as? String
        cell.textLabel?.text = text
        return cell
    }
}

