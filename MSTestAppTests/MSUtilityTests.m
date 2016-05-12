//
//  MSUtilityTests.m
//  MSTestApp
//
//  Created by Masud Shuvo on 5/12/16.
//  Copyright © 2016 Masud Shuvo. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MSUtility.h"

@interface MSUtilityTests : XCTestCase

@end

@implementation MSUtilityTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}
//+ (NSString *)sectionString:(MSGallerySection)section;
//+ (NSString *)sortString:(MSGallerySort)sort;
//+ (NSString *)windowString:(MSGalleryWindowTime)sort;
- (void)testSectionString
{
    XCTAssertTrue([[MSUtility sectionString:MSGallerySectionHot] isEqualToString:@"hot"], @"Wrong return value");
    XCTAssertTrue([[MSUtility sectionString:MSGallerySectionTop] isEqualToString:@"top"], @"Wrong return value");
    XCTAssertTrue([[MSUtility sectionString:MSGallerySectionUser] isEqualToString:@"user"], @"Wrong return value");
    XCTAssertTrue([[MSUtility sectionString:-1] isEqualToString:@"hot"], @"Wrong return value");
}

- (void)testSortString
{
    XCTAssertTrue([[MSUtility sortString:MSGallerySortViral] isEqualToString:@"viral"], @"Wrong return value");
    XCTAssertTrue([[MSUtility sortString:MSGallerySortTop] isEqualToString:@"top"], @"Wrong return value");
    XCTAssertTrue([[MSUtility sortString:MSGallerySortTime] isEqualToString:@"time"], @"Wrong return value");
    XCTAssertTrue([[MSUtility sortString:MSGallerySortRising] isEqualToString:@"rising"], @"Wrong return value");
    XCTAssertTrue([[MSUtility sortString:-1] isEqualToString:@"viral"], @"Wrong return value");
}

- (void)testWindowString
{
    XCTAssertTrue([[MSUtility windowString:MSGalleryWindowTimeDay] isEqualToString:@"day"], @"Wrong return value");
    XCTAssertTrue([[MSUtility windowString:MSGalleryWindowTimeWeek] isEqualToString:@"week"], @"Wrong return value");
    XCTAssertTrue([[MSUtility windowString:MSGalleryWindowTimeMonth] isEqualToString:@"month"], @"Wrong return value");
    XCTAssertTrue([[MSUtility windowString:MSGalleryWindowTimeYear] isEqualToString:@"year"], @"Wrong return value");
    XCTAssertTrue([[MSUtility windowString:MSGalleryWindowTimeAll] isEqualToString:@"all"], @"Wrong return value");
    XCTAssertTrue([[MSUtility windowString:-1] isEqualToString:@"day"], @"Wrong return value");
}

@end
