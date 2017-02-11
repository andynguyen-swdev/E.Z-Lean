//
//  RecentCollectionViewDataSource.swift
//  E.Z Lean
//
//  Created by Duy Anh on 2/7/17.
//  Copyright © 2017 E.Z Lean. All rights reserved.
//

import RxSwift
import RxCocoa
import RxDataSources

class RecentCollectionViewDataSource {
    weak var collectionView: UICollectionView!
    var disposeBag = DisposeBag()
    var articles: Variable<[Article]> = Variable([])
    
    init(_ cView: UICollectionView) {
        self.collectionView = cView
    }
    
    func config() {
        bindDataSource()
        getData()
    }
    
    func bindDataSource() {
        let dataSource = RxCollectionViewSectionedAnimatedDataSource<AnimatableSectionModel<String,Article>>()
        dataSource.configureCell = {
            data, cView, indexPath, article in
            let cell = cView.dequeueReusableCell(withReuseIdentifier: ArticleCell.identifier, for: indexPath) as! ArticleCell
            cell.titleLabel.text = article.title
            cell.thumbnailImageView.image = UIImage(named: "test\(indexPath.row)")
            return cell
        }
        dataSource.animationConfiguration = AnimationConfiguration(insertAnimation: .right, reloadAnimation: .automatic, deleteAnimation: .automatic)
        
        articles.asObservable()
            .map { articles in
                return [AnimatableSectionModel<String,Article>(model: "", items: articles)]
                }
            .bindTo(collectionView.rx
                .items(dataSource: dataSource))
            .addDisposableTo(disposeBag)
        
    }
    
    func getData() {
        let path0 = Bundle.main.path(forResource: "test0", ofType: "html")!
        let article0 = Article(title: "Bách khoa toàn thư về thể hình - Xây dựng cơ bắp từ A-Z - P.2", summary: "Các quy định an toàn và nguyên tắc trong phòng tập", contentLink: path0, imageLink: "")
        let path1 = Bundle.main.path(forResource: "test1", ofType: "html")!
        let article1 = Article(title: "Bách khoa toàn thư về thể hình - Xây dựng cơ bắp từ A-Z - P.1", summary: "“Tôi đã nghỉ thi đấu, nhưng tôi sẽ không bao giờ ngừng tập thể hình. Bởi nó là môn thể thao tuyệt vời nhất”", contentLink: path1, imageLink: "")
        let path2 = Bundle.main.path(forResource: "test2", ofType: "html")!
        let article2 = Article(title: "5 CÁCH CHO PHỤ NỮ GIẢM MỠ -TĂNG CƠ", summary: " Hiểu được phụ nữ luôn là 1 điều vô cùng khó khăn nên chúng ta không đem những phương pháp vốn dành cho đàn ông - những tế bào đơn giản đến ngờ ngệch - áp dụng cho phụ nữ - 1 cơ thể hoàn hảo của quá trình tiến hóa và thích nghi với thiên nhiên. Hãy thay đổi vấn đề từ các yếu tố căn bản là sinh lý thay vì chỉ biết tập và tập. Ps: bài viết khá dài và có những vấn đề chuyên môn nhưng các bạn cần xem để hiểu rõ sự khác biệt và có phương án xây dựng chế độ ăn và tập phù hợp.", contentLink: path2, imageLink: "")
        articles.value.append(article0)
        Thread.sleep(forTimeInterval: 1)
        articles.value.append(article1)
        Thread.sleep(forTimeInterval: 1)
        articles.value.append(article2)
    }
}
