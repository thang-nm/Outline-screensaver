//
//    ____       __  ___
//   / __ \__ __/ /_/ (_)__  ___
//  / /_/ / // / __/ / / _ \/ -_)
//  \____/\_,_/\__/_/_/_//_/\__/
//
//  Created by thang-nm on 6/9/19.
//  Copyright © 2019 thang-nm. All rights reserved.
//

import Foundation
import ScreenSaver
import AVKit

class OutlineView: ScreenSaverView {

  weak var player: AVPlayer?

  override init?(frame: NSRect, isPreview: Bool) {
    super.init(frame: frame, isPreview: isPreview)
    animationTimeInterval = 1 / 30.0
    initPlayer()
  }

  required init?(coder decoder: NSCoder) {
    super.init(coder: decoder)
    animationTimeInterval = 1 / 30.0
    initPlayer()
  }
}

extension OutlineView {

  func initPlayer() {
    guard
      let url = Bundle(for: OutlineView.self).url(forResource: "outline", withExtension: "mp4"),
      case let player = AVPlayer(url: url) else {
        return
    }

    NotificationCenter.default.addObserver(
      self,
      selector: #selector(playerItemDidReachEnd(_:)),
      name: .AVPlayerItemDidPlayToEndTime,
      object: nil)

    player.actionAtItemEnd = .none
    self.player = player

    let playerView = AVPlayerView()
    playerView.translatesAutoresizingMaskIntoConstraints = false
    playerView.player = player
    playerView.controlsStyle = .none
    addSubview(playerView)

    NSLayoutConstraint.activate([
      playerView.centerXAnchor.constraint(equalTo: centerXAnchor),
      playerView.centerYAnchor.constraint(equalTo: centerYAnchor),
      playerView.widthAnchor.constraint(equalToConstant: 520 / 2.5),
      playerView.heightAnchor.constraint(equalToConstant: 632 / 2.5)])
  }

  @objc func playerItemDidReachEnd(_ notiication: Notification) {
    player?.seek(to: .zero)
    player?.play()
  }
}

extension OutlineView {

  override func startAnimation() {
    super.startAnimation()
    player?.play()
  }

  override func stopAnimation() {
    super.stopAnimation()
  }

  override func draw(_ rect: NSRect) {
    super.draw(rect)
  }

  func hasConfigureSheet() -> Bool {
    return false
  }

  func configureSheet() -> NSWindow? {
    return nil
  }
}
