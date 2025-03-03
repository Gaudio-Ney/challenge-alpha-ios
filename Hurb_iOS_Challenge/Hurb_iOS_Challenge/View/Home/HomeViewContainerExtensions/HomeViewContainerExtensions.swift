//
//  HomeViewContainerExtensions.swift
//  Hurb_iOS_Challenge
//
//  Created by Gáudio Ney on 23/05/22.
//

import UIKit

// MARK: - UICollectionViewDataSource
extension HomeContainerView: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return StarsForSection.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let section: StarsForSection = StarsForSection(rawValue: section)!
        switch section {
        case .fiveStars:
            if fiveStarHotel.count > 0 {
                return fiveStarHotel.count
            }
            else { return 0 }
        case .fourStars:
            if fourStarHotel.count > 0 {
                return fourStarHotel.count
            }
            else { return 0 }
        case .threeStars:
            if threeStarHotel.count > 0 {
                return threeStarHotel.count
            }
            else { return 0 }
        case .twoStars:
            if twoStarHotel.count > 0 {
                return twoStarHotel.count
            }
            else { return 0 }
        case .oneStar:
            if oneStarHotel.count > 0 {
                return oneStarHotel.count
            }
            else { return 0 }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerIdentifier, for: indexPath) as! CollectionViewHeaderView
            /// Check if it is the first section
            if indexPath.section == 0 {
                headerView.headerDividingLine.isHidden = true
            }
            else {
                headerView.headerDividingLine.isHidden = false
            }
            headerView.sectionHeaderLabel.text = StarsForSection(rawValue: indexPath.section)?.headerTitle()
            return headerView
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let section: StarsForSection = StarsForSection(rawValue: section)!
        let headerSize = CGSize(width: UIScreen.main.bounds.width, height: 46)
        let noHeader = CGSize(width: UIScreen.main.bounds.width, height: 0)
        switch section {
        case .fiveStars:
            if fiveStarHotel.count > 0 { return headerSize }
            else { return noHeader }
        case .fourStars:
            if fourStarHotel.count > 0 { return headerSize }
            else { return noHeader }
        case .threeStars:
            if threeStarHotel.count > 0 { return headerSize }
            else { return noHeader }
        case .twoStars:
            if twoStarHotel.count > 0 { return headerSize }
            else { return noHeader }
        case .oneStar:
            if oneStarHotel.count > 0 { return headerSize }
            else { return noHeader }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section: StarsForSection = StarsForSection(rawValue: indexPath.section)!
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! HomeCollectionViewCell
        
        switch section {
        case .fiveStars:
            let hotel = fiveStarHotel[indexPath.row]
            let viewModel = HomeDetailViewModel()
            viewModel.hotelResult = hotel
            cell.hotelResult = hotel
        case .fourStars:
            let hotel = fourStarHotel[indexPath.row]
            let viewModel = HomeDetailViewModel()
            viewModel.hotelResult = hotel
            cell.hotelResult = hotel
        case .threeStars:
            let hotel = threeStarHotel[indexPath.row]
            let viewModel = HomeDetailViewModel()
            viewModel.hotelResult = hotel
            cell.hotelResult = hotel
        case .twoStars:
            let hotel = twoStarHotel[indexPath.row]
            let viewModel = HomeDetailViewModel()
            viewModel.hotelResult = hotel
            cell.hotelResult = hotel
        case .oneStar:
            let hotel = oneStarHotel[indexPath.row]
            let viewModel = HomeDetailViewModel()
            viewModel.hotelResult = hotel
            cell.hotelResult = hotel
        }
        return cell
    }
}

extension HomeContainerView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let section: StarsForSection = StarsForSection(rawValue: indexPath.section)!
        let selectedHotel: HotelResult?
        
        switch section {
        case .fiveStars: selectedHotel = fiveStarHotel[indexPath.row]
        case .fourStars: selectedHotel = fourStarHotel[indexPath.row]
        case .threeStars: selectedHotel = threeStarHotel[indexPath.row]
        case .twoStars: selectedHotel = twoStarHotel[indexPath.row]
        case .oneStar: selectedHotel = oneStarHotel[indexPath.row]
        }
        
        DispatchQueue.main.async { [weak self] in
            let viewController = DetailViewController()
            guard let selectedHotelResult = selectedHotel else { return }
            viewController.detailContainerView.hotelsResult  = selectedHotelResult
            self?.saveHotelAtLastSeenList(model: selectedHotelResult)
            self?.parentViewController?.navigationController?.pushViewController(viewController, animated: true)
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension HomeContainerView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return Constants.HomeCollectionViewConstraints.HOME_COLLECTIONVIEW_DIMENTIONS_SIZE_WITH_PADDING
    }
}
