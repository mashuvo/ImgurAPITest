//
//  MSImageDetailsView.h
//  MSTestApp
//
//  Created by Masud Shuvo on 5/12/16.
//  Copyright © 2016 Masud Shuvo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MSImageDetailsView : UIView

@property (nonatomic, strong) IBOutlet UIImageView *imageView;
@property (nonatomic, strong) IBOutlet UILabel *imageTitle;
@property (nonatomic, strong) IBOutlet UILabel *imageDescription;
@property (nonatomic, strong) IBOutlet UILabel *upVote;
@property (nonatomic, strong) IBOutlet UILabel *downVote;
@property (nonatomic, strong) IBOutlet UILabel *imageScore;

@end
