//
//  MSGalleryViewController.m
//  MSTestApp
//
//  Created by Masud Shuvo on 5/9/16.
//  Copyright © 2016 Masud Shuvo. All rights reserved.
//

#import <SDWebImage/UIImageView+WebCache.h>
#import "MSGalleryViewController.h"
#import "MSInfoViewController.h"
#import "MSGalleryDataService.h"
#import "MSCollectionViewCell.h"
#import "MSConstant.h"
#import "MSGallery.h"


@interface MSGalleryViewController () 

@property (nonatomic, assign) MSGallerySection section;
@property (nonatomic, assign) MSGallerySort sort;
@property (nonatomic, assign) MSGalleryWindowTime windowTime;
@property (nonatomic, strong) NSMutableArray *galleries;
@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, assign) float startingScrollViewContentOffsetY;

- (IBAction)sectionSegmentControlValueChanged:(id)sender;
- (IBAction)sortSegmentControlValueChanged:(id)sender;
- (IBAction)windowSegmentControlValueChanged:(id)sender;
- (IBAction)viralOnOffValueChanged:(id)sender;
- (IBAction)infoButtonPressed:(id)sender;

@end

@implementation MSGalleryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"Imgur Api Test App";
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self initiateDefaultValues];
    [self fetchData];
    
}

- (void)initiateDefaultValues
{
    self.galleries = [NSMutableArray array];
    self.section = MSGallerySectionHot;
    self.sort = MSGallerySortViral;
    self.windowTime = MSGalleryWindowTimeDay;
}

- (void)fetchData
{
    self.loadingIndicator.hidden = NO;
    
    //sending request to fetch gallery data with user selected parameters.
    [MSGalleryDataService fetchGalleryDataForSection:[MSUtility sectionString:self.section] sort:[MSUtility sortString:self.sort] window:[MSUtility windowString:self.windowTime] page:++self.currentPage showViral:self.viralOnOff.on withCompletion:^(NSArray *galleries, NSError *error) {
        if (!error && [galleries count] > 0) {
            [self.galleries addObjectsFromArray:galleries];
            [self.collectionView reloadData];
        }
         self.loadingIndicator.hidden = YES;
    }];
}

- (IBAction)sectionSegmentControlValueChanged:(id)sender
{
 
    switch (self.sectionSegmentControl.selectedSegmentIndex) {
        case MSGallerySectionTop:
            self.section = MSGallerySectionTop;
            [self.sortSegmentControl setEnabled:NO forSegmentAtIndex:3];
            [self.windowSegmentControl setEnabled:YES];
            break;
        case MSGallerySectionHot:
            self.section = MSGallerySectionHot;
            [self.sortSegmentControl setEnabled:NO forSegmentAtIndex:3];
            [self.windowSegmentControl setEnabled:NO];
            break;
        case MSGallerySectionUser:
            self.section = MSGallerySectionUser;
            [self.sortSegmentControl setEnabled:YES forSegmentAtIndex:3];
            [self.windowSegmentControl setEnabled:NO];
            break;
        default:
            break;
    }
    [self.galleries removeAllObjects];
    [self.collectionView reloadData];
    self.currentPage = 0;
    [self fetchData];
    
}

- (IBAction)sortSegmentControlValueChanged:(id)sender
{
    switch (self.sortSegmentControl.selectedSegmentIndex) {
        case MSGallerySortViral:
            self.sort = MSGallerySortViral;
            break;
        case MSGallerySortTop:
            self.sort = MSGallerySortTop;
            break;
        case MSGallerySortTime:
            self.sort = MSGallerySortTime;
            break;
        case MSGallerySortRising:
            self.sort = MSGallerySortRising;
            break;
        default:
            break;
    }
    [self.galleries removeAllObjects];
    [self.collectionView reloadData];
    self.currentPage = 0;
    [self fetchData];
}

- (IBAction)windowSegmentControlValueChanged:(id)sender
{
    switch (self.windowSegmentControl.selectedSegmentIndex) {
        case MSGalleryWindowTimeDay:
            self.windowTime = MSGalleryWindowTimeDay;
            break;
        case MSGalleryWindowTimeWeek:
            self.windowTime = MSGalleryWindowTimeWeek;
            break;
        case MSGalleryWindowTimeMonth:
            self.windowTime = MSGalleryWindowTimeMonth;
            break;
        case MSGalleryWindowTimeYear:
            self.windowTime = MSGalleryWindowTimeYear;
            break;
        case MSGalleryWindowTimeAll:
            self.windowTime = MSGalleryWindowTimeAll;
            break;
        default:
            break;
    }
    [self.galleries removeAllObjects];
    [self.collectionView reloadData];
    self.currentPage = 0;
    [self fetchData];
}

- (IBAction)viralOnOffValueChanged:(id)sender
{
    [self.galleries removeAllObjects];
    [self.collectionView reloadData];
    self.currentPage = 0;
    [self fetchData];
}

- (IBAction)infoButtonPressed:(id)sender
{
    MSInfoViewController *infoViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"infoViewController"];
    [self.navigationController pushViewController:infoViewController animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [_galleries count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MSCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MyCustomCell" forIndexPath:indexPath];
    
    cell.activityIndicator.hidden = NO;
    MSGallery *gallery = [_galleries objectAtIndex:indexPath.row];
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:gallery.imageLink]
                      placeholderImage:[UIImage imageNamed:@"placeholder"]
                             completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                 cell.activityIndicator.hidden = YES;
                                 if (error) {
                                     cell.imageView.image = [UIImage imageNamed:@"no-image"];
                                 }
                                 cell.imageDescription.text = gallery.galleryTitle;
                             }];
    
    return cell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //populate image details view with selected gallery's data
    MSGallery *gallery = [_galleries objectAtIndex:indexPath.row];
    [self.imageDetailsView.imageView sd_setImageWithURL:[NSURL URLWithString:gallery.imageLink]
                      placeholderImage:[UIImage imageNamed:@"placeholder"]
                             completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                 if (error) {
                                     self.imageDetailsView.imageView.image = [UIImage imageNamed:@"no-image"];
                                 }
                             }];
    self.imageDetailsView.upVote.text = [NSString stringWithFormat:@"%@",gallery.ups];
    self.imageDetailsView.downVote.text = [NSString stringWithFormat:@"%@",gallery.downs];
    self.imageDetailsView.imageScore.text = [NSString stringWithFormat:@"%@",gallery.score];
    
    if ([gallery.galleryTitle isKindOfClass:[NSNull class]]) {
        self.imageDetailsView.imageTitle.text = @"Title : No title available";
    }
    else {
        self.imageDetailsView.imageTitle.text = [NSString stringWithFormat:@"Title : %@",gallery.galleryTitle];
    }
    
    if ([gallery.galleryDescription isKindOfClass:[NSNull class]]) {
        self.imageDetailsView.imageDescription.text = @"Description : No description available";
    }
    else {
        self.imageDetailsView.imageDescription.text = [NSString stringWithFormat:@"Description : %@",gallery.galleryDescription];
    }
    
    //make visible image details view.
    self.imageDetailsView.hidden = NO;
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((self.view.frame.size.width - 100) / 2, (self.view.frame.size.width - 100) / 2);
}

- (UIEdgeInsets)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 25, 0, 25);
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    self.startingScrollViewContentOffsetY = scrollView.contentOffset.y;
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if(scrollView.frame.size.height + scrollView.contentOffset.y >= 0.8 * scrollView.contentSize.height
       && self.startingScrollViewContentOffsetY < scrollView.contentOffset.y){
        //load more galleries as user has almost reach the end point of current loaded galleries.
        [self fetchData];
    }
    self.startingScrollViewContentOffsetY = 0;
}

@end
