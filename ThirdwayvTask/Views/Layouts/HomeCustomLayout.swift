//
//  HomeCustomLayout.swift
//  ThirdwayvTask
//
//  Created by Ahmed Soultan on 14/12/2022.
//

import UIKit

protocol HomeLayoutDelegate {
    func collectionView(collectionView: UICollectionView, heightForItemAtIndexPath indexPath: IndexPath) -> CGFloat
}

class homeLayout: UICollectionViewLayout {

    var delegate: HomeLayoutDelegate!
    var numberOfColumns = 1

    private var cache = [UICollectionViewLayoutAttributes]()
    private var contentHeight: CGFloat = 0
    private var width: CGFloat {
        get {
            return CGRectGetWidth(collectionView!.bounds)
        }
    }

    override var collectionViewContentSize: CGSize{
        return CGSize(width: width, height: contentHeight)
    }

    override func prepare() {
        if cache.isEmpty {
            let columnWidth = width / CGFloat(numberOfColumns)

            var xOffsets = [CGFloat]()
            for column in 0 ..< numberOfColumns {
                xOffsets.append(CGFloat(column) * columnWidth)
            }
            var yOffsets = [CGFloat](repeating: 0, count:numberOfColumns)
            var column = 0
            for item in 0 ..< collectionView!.numberOfItems(inSection: 0){
                let indexPath = IndexPath(item: item, section: 0)
                let height = delegate.collectionView(collectionView: collectionView!,
                                                     heightForItemAtIndexPath: indexPath)
                let frame = CGRect(x: xOffsets[column], y: yOffsets[column], width: columnWidth, height: height)
                let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                attributes.frame = frame
                cache.append(attributes)
                contentHeight = max(contentHeight, CGRectGetMaxY(frame))
                yOffsets[column] = yOffsets[column] + height
                column = column >= (numberOfColumns - 1) ? 0 : 1
            }
        }
    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var layoutAttributes = [UICollectionViewLayoutAttributes]()
        for attribute in cache {
            if CGRectIntersectsRect(attribute.frame, rect){
                layoutAttributes.append(attribute)
            }
        }
        return layoutAttributes
    }
}
