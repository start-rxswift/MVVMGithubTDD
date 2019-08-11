//
//  ViewController.swift
//  TddMVVMGithub
//
//  Created by tskim on 10/08/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import RxDataSources
import UIKit

class GithubSearchViewController: UIViewController, HasDisposeBag {

    private let viewModel: SearchViewModel
    @IBOutlet weak var collectionView: UICollectionView!

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    private let uiSearchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.returnKeyType = .done
        searchBar.placeholder = "Search"
        return searchBar
    }()

    let dataSource = RxCollectionViewSectionedAnimatedDataSource<RepositorySection>(
        configureCell: { ds, cv, ip, item in
            guard let cell = cv.dequeueReusableCell(withReuseIdentifier: RepositoryCell.swiftIdentifier, for: ip) as? RepositoryCell else { return UICollectionViewCell() }
            cell.repositoryName.text = item.name
            cell.ownerName.text = item.owner.login
            cell.starCount.text = String(item.stargazers_count)
            cell.forkCount.text = String(item.forks_count)
            return cell
        }
    )

    init(viewModel: SearchViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        activityIndicator.isHidden = true
        collectionView.register(RepositoryCell.nib, forCellWithReuseIdentifier: RepositoryCell.swiftIdentifier)
        collectionView.rx.setDelegate(self).disposed(by: disposeBag)
        navigationItem.titleView = uiSearchBar

        viewModel.isLoading
            .distinctUntilChanged()
            .debug("isLoading")
            .bind(to: activityIndicator.rx.showLoading)
            .disposed(by: disposeBag)

        uiSearchBar.rx.text.orEmpty
            .distinctUntilChanged()
            .bind(to: viewModel.searchText)
            .disposed(by: disposeBag)

        uiSearchBar.rx.searchButtonClicked
            .do(onNext: { [weak uiSearchBar] in
                uiSearchBar?.resignFirstResponder()
            })
            .bind(to: viewModel.doSearch)
            .disposed(by: disposeBag)

        viewModel.sections
            .bind(to: collectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)

    }
}

extension GithubSearchViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let collectionViewLayout = collectionViewLayout as? UICollectionViewFlowLayout else { return CGSize(width: 0, height: 0) }
        let sectionInset = collectionViewLayout.sectionInset
        let contentWidth = collectionView.safeAreaLayoutGuide.layoutFrame.width
            - sectionInset.left
            - sectionInset.right
            - collectionView.contentInset.left
            - collectionView.contentInset.right

        return CGSize(width: contentWidth, height: 130)
    }
}
