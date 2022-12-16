
import UIKit
import Kingfisher

extension UIImageView {
    
    func circuleImage() {
        self.layer.cornerRadius = self.frame.height / 2
    }
    
    func setImageByKingFisher (url: String) {
        let url = URL(string: url)
        let processor = DownsamplingImageProcessor(size: self.bounds.size)
        |> RoundCornerImageProcessor(cornerRadius: 8)
        self.kf.indicatorType = .activity
        self.kf.setImage(
            with: url,
            placeholder: UIImage(named: "placeholderImage"),
            options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheMemoryOnly
            ])
    }
}
