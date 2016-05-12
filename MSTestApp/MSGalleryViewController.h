//
//  MSGalleryViewController.h
//  MSTestApp
//
//  Created by Masud Shuvo on 5/9/16.
//  Copyright © 2016 Masud Shuvo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MSImageDetailsView.h"
#import "MSUtility.h"

@interface MSGalleryViewController : UIViewController <UICollectionViewDelegateFlowLayout, UICollectionViewDelegate>

/**
 * The collection view that will display the galleries.
 */
@property (nonatomic, strong) IBOutlet UICollectionView *collectionView;

/**
 * This segmented control will allow users to select gallery section. Section's default value is hot.
 */
@property (nonatomic, strong) IBOutlet UISegmentedControl *sectionSegmentControl;

/**
 * This segmented control will allow users to select gallery sort option. Sort's default value is viral. rising is only available with user section.
 */
@property (nonatomic, strong) IBOutlet UISegmentedControl *sortSegmentControl;

/**
 * This segmented control will allow users to change the date range of the request if the section is "top". Window's default value is day.
 */
@property (nonatomic, strong) IBOutlet UISegmentedControl *windowSegmentControl;

/**
 * The view displays the details of selected gallery. Such as title, description, upvotes, downvotes, score and the gallery image.
 */
@property (nonatomic, strong) IBOutlet MSImageDetailsView *imageDetailsView;

/**
 * Show or hide viral images from the 'user' section. Defaults to true.
 */
@property (nonatomic, strong) IBOutlet UISwitch *viralOnOff;

/**
 * Will indicate fetch request is loading.
 */
@property (nonatomic, strong) IBOutlet UIActivityIndicatorView *loadingIndicator;

@end

