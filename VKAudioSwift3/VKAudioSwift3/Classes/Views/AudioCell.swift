//
//  AudioCell.swift
//  VKAudioSwift3
//
//  Created by Roman Rybachenko on 11/14/16.
//  Copyright © 2016 Roman Rybachenko. All rights reserved.
//

import UIKit

protocol AudioCellDelegate: class {
    func playButtonTappedInCell(cell: AudioCell)
    func downloadButtonTappedInCell(cell: AudioCell)
}

class AudioCell: UITableViewCell {
    // MARK: Outlets
    @IBOutlet weak var audioTitleLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var downloadButton: UIButton!
    
    weak var delegate: AudioCellDelegate?
    
    
    // MARK: Properties
    var audio: VKAudio? {
//        get {
//            return super.audio
//        } set {
//            self.audioTitleLabel.text = newValue?.title
//            self.artistLabel.text = newValue?.artist
//        }
        didSet {
            self.audioTitleLabel.text = audio?.title
            self.artistLabel.text = audio?.artist
        }
    }
    
    
    // MARK: Overriden funcs
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    // MARK: Action funcs
    @IBAction func playButtonTapped(_ sender: UIButton) {
        self.delegate?.playButtonTappedInCell(cell: self)
    }
    
    @IBAction func downloadButtonTapped(_ sender: UIButton) {
        self.delegate?.downloadButtonTappedInCell(cell: self)
    }
    
    
    // MARK: Static funcs
    
    static func cellIdentifier() -> String {
        return "AudioCell"
    }
    
    static func cellHeight() -> CGFloat {
        return 48.0
    }
}
