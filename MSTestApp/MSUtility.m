//
//  MSUtility.m
//  MSTestApp
//
//  Created by Masud Shuvo on 5/10/16.
//  Copyright © 2016 Masud Shuvo. All rights reserved.
//

#import "MSUtility.h"

@implementation MSUtility

+ (void)imageData:(NSURL *)url withCompletion:(void (^)( NSData *imageData, NSError *error))completion
{
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration:defaultConfigObject];
    
    NSURLSessionDataTask *task = [defaultSession dataTaskWithURL:url completionHandler: ^(NSData *data, NSURLResponse *response, NSError *error) {
        if(!error)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(data,nil);
            });
        }
        else {
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(nil,error);
            });
        }
    }];
    
    [task resume];
}

+ (NSString *)sectionString:(MSGallerySection)section
{
    NSString *string = @"hot";
    
    switch (section) {
        case MSGallerySectionTop:
            string = @"top";
            break;
        case MSGallerySectionUser:
            string = @"user";
            break;
        default:
            break;
    }
    return string;
}

+ (NSString *)sortString:(MSGallerySort)sort
{
    NSString *string = @"viral";
    
    switch (sort) {
        case MSGallerySortTop:
            string = @"top";
            break;
        case MSGallerySortTime:
            string = @"time";
            break;
        case MSGallerySortRising:
            string = @"rising";
            break;
        default:
            break;
    }
    return string;
}

+ (NSString *)windowString:(MSGalleryWindowTime)sort
{
    NSString *string = @"day";
    
    switch (sort) {
        case MSGalleryWindowTimeWeek:
            string = @"week";
            break;
        case MSGalleryWindowTimeMonth:
            string = @"month";
            break;
        case MSGalleryWindowTimeYear:
            string = @"year";
            break;
        case MSGalleryWindowTimeAll:
            string = @"all";
            break;
        default:
            break;
    }
    return string;
}

@end
