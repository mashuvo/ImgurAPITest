//
//  MSGallery.h
//  MSTestApp
//
//  Created by Masud Shuvo on 5/10/16.
//  Copyright © 2016 Masud Shuvo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MSGallery : NSObject

@property (nonatomic, strong) NSString *galleryId;
@property (nonatomic, strong) NSString *galleryTitle;
@property (nonatomic, strong) NSString *galleryDescription;
@property (nonatomic, strong) NSString *vote;
@property (nonatomic, strong) NSNumber *views;
@property (nonatomic, strong) NSString *imageLink;
@property (nonatomic, strong) NSNumber *ups;
@property (nonatomic, strong) NSNumber *downs;
@property (nonatomic, strong) NSNumber *points;
@property (nonatomic, strong) NSNumber *score;
@property (nonatomic, strong) NSNumber *is_album;

-(instancetype)initWithDictionary: (NSDictionary *) dictionary;

@end
