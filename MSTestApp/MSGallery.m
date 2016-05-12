//
//  MSGallery.m
//  MSTestApp
//
//  Created by Masud Shuvo on 5/10/16.
//  Copyright © 2016 Masud Shuvo. All rights reserved.
//

#import "MSGallery.h"

@interface MSGallery ()

@property (nonatomic, strong) NSDictionary *dictionary;

@end

@implementation MSGallery

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        self.dictionary = dictionary;
    }
    return self;
}

-(void)setDictionary:(NSDictionary *)dictionary
{
    self.galleryId = dictionary[@"id"];
    self.galleryTitle = dictionary[@"title"];
    self.galleryDescription = dictionary[@"description"];
    self.imageLink = dictionary[@"link"];
    self.vote = dictionary[@"vote"];
    self.views = dictionary[@"views"];
    self.ups = dictionary[@"ups"];
    self.downs = dictionary[@"downs"];
    self.points = dictionary[@"points"];
    self.score = dictionary[@"score"];
    self.is_album = dictionary[@"is_album"];
}

- (NSString *)description
{
    NSDictionary *dict = @{
                           @"id": self.galleryId,
                           @"title": self.galleryTitle,
                           @"description": self.galleryDescription,
                           @"link" : self.imageLink,
                           @"vote": self.vote,
                           @"views": self.views,
                           @"ups": self.ups,
                           @"downs": self.downs,
                           @"points" : self.points,
                           @"score": self.score,
                           @"is_album" : self.is_album
                           };
    return [dict description];
}

@end
