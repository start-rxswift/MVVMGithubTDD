//
//  RepositoryCell.swift
//  TddMVVMGithub
//
//  Created by tskim on 11/08/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import UIKit

class RepositoryCell: UICollectionViewCell, NibForName {
    @IBOutlet weak var repositoryName: UILabel!
    @IBOutlet weak var ownerName: UILabel!
    @IBOutlet weak var starCount: UILabel!
    @IBOutlet weak var forkCount: UILabel!
}
