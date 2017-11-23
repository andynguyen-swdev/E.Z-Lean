//
//  DiscoverDataSource.swift
//  Lab01
//
//  Created by Duy Anh on 2/19/17.
//  Copyright © 2017 Duy Anh. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import Firebase

class DiscoverDataSource: ReactiveCollectionViewDataSource {
    weak var collectionView: UICollectionView!
    
    var playlists: Variable<[Playlist]> = Variable([])
    
    var binding: Variable<Bool> = Variable(false)
    var bind: Disposable?
    
    var disposeBag = DisposeBag()
    
    init(collectionView: UICollectionView) {
        self.collectionView = collectionView
    }
    
    func bindDataSource() {
        playlists.asObservable()
            .observeOn(MainScheduler.instance)
            .bind(to: collectionView
                .rx
                .items(cellIdentifier: CategoryCell.identifier, cellType: CategoryCell.self)
            ) {
                row, playlist, cell in
                cell.configWith(playlist: playlist)
            }
            .disposed(by: disposeBag)
    }
    
    func getData() {
        let ref = Database.database().reference(withPath: "song_playlists")
        ref.observe(.value, with: { snapshot in
            snapshot.children.forEach { [weak self] item in
                let playlist = Playlist.create(snapshot: item as! DataSnapshot)
                self?.playlists.value.insert(playlist, at: 0)
            }
        })
    }
}
