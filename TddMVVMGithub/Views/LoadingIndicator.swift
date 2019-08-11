//
//  LoadingIndicator.swift
//  TddMVVMGithub
//
//  Created by tskim on 11/08/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

extension Reactive where Base: UIActivityIndicatorView {
    var showLoading: Binder<Bool> {
        return Binder(self.base) { activityIndicator, isShow in
            if isShow {
                UIApplication.shared.isNetworkActivityIndicatorVisible = true
                UIApplication.shared.beginIgnoringInteractionEvents()
                activityIndicator.isHidden = false
                activityIndicator.startAnimating()
            } else {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                UIApplication.shared.endIgnoringInteractionEvents()
                activityIndicator.stopAnimating()
                activityIndicator.isHidden = true
            }
        }
    }
}
