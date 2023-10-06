//
//  MusicTableViewCell.swift
//  iTunesDemo
//
//  Created by yaojunren on 2023/10/3.
//

import Combine
import Foundation
import Kingfisher
import UIKit
protocol MusicCellViewModel {
    var imageUrl: URL? { get }
    var imageShape: ShapeType { get }
    var title: String? { get }
    var detail: String? { get }

    var actionItem: ActionItem? { get }
    /// 跳转到Music iTunes 的链接
    var viewURL: URL? { get }
}

class MusicTableViewCell: UITableViewCell, NibFromClassNameble {
    @IBOutlet var iconImageView: UIImageView!
    @IBOutlet var topLabel: UILabel!
    @IBOutlet var bottomLabel: UILabel!
    @IBOutlet var rightButton: UIButton!
    var viewModel: MusicCellViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }

            if let url = viewModel.imageUrl {
                iconImageView.isHidden = false
                iconImageView.kf.setImage(with: url)
                switch viewModel.imageShape {
                case .circle:
                    iconImageView.layer.cornerRadius = 24
                case let .round(r):
                    iconImageView.layer.cornerRadius = r
                }
            } else {
                iconImageView.isHidden = true
            }

            if let title = viewModel.title {
                topLabel.isHidden = false
                topLabel.text = title
            } else {
                topLabel.isHidden = true
            }

            if let text = viewModel.detail {
                bottomLabel.isHidden = false
                bottomLabel.text = text
            } else {
                bottomLabel.isHidden = true
            }
            if let item = viewModel.actionItem {
                rightButton.isHidden = false
                switch item {
                case let .button(image):
                    rightButton.setImage(image, for: .normal)
                }
            } else {
                rightButton.isHidden = true
            }
        }
    }

    public var cancellable: AnyCancellable?
    public var tapPubluic = PassthroughSubject<MusicCellViewModel, Never>()
    override func awakeFromNib() {
        super.awakeFromNib()

        rightButton.setTitle(nil, for: .normal)
        rightButton.addTarget(self, action: #selector(tapRightButton), for: .touchUpInside)
    }

    @objc func tapRightButton() {
        guard let viewModel = viewModel else { return }
        tapPubluic.send(viewModel)
    }
}
