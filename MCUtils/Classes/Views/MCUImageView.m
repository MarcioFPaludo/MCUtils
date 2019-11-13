//
//  MCUImageView.m
//  MCUtils
//
//  Created by Márcio Fochesato Paludo on 6/1/16.
//

#import "MCUImageView.h"

#define kCloseScale 0.5f
#define kMinZoomScale 1.0f
#define kDefaultZoomScale kMinZoomScale
#define kMaxZoomScale 2.0f

@interface MCUImageView () <UIScrollViewDelegate>

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *contentView;

@end

@implementation MCUImageView

@dynamic image;

- (instancetype)init
{
    self = [super init];
    
    if (self)
        [self initialize];
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
        [self initialize];
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    
    if (self)
        [self initialize];
    
    return self;
}

- (void)initialize
{
    self.backgroundColor = UIColor.lightGrayColor;
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.decelerationRate = UIScrollViewDecelerationRateNormal;
    scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    scrollView.showsHorizontalScrollIndicator  = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.maximumZoomScale = kMaxZoomScale;
    scrollView.minimumZoomScale = kMinZoomScale;
    scrollView.zoomScale = kDefaultZoomScale;
    scrollView.clipsToBounds = NO;
    scrollView.delegate = self;
    scrollView.bounces = YES;
    _scrollView = scrollView;
    
    [self addSubview:scrollView];
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    imageView.userInteractionEnabled = YES;
    imageView.clipsToBounds = YES;
    _imageView = imageView;
    
    [scrollView addSubview:imageView];
    
    [self buildConstraints];
}

- (void)checkImageSize:(CGSize)size
{
    if (size.width > self.frame.size.width || size.height > self.frame.size.height)
        [_imageView setContentMode:UIViewContentModeScaleAspectFit];
    else
        [_imageView setContentMode:UIViewContentModeCenter];
}

- (void)buildConstraints
{
    NSDictionary *views = @{@"ImageView" : _imageView, @"ScrollView" : _scrollView};
    NSMutableArray<NSLayoutConstraint *> *constraints =  [[NSMutableArray alloc] init];
    
    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[ScrollView]|" options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil views:views]];
    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[ScrollView]|" options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil views:views]];
    
    [self addConstraints:constraints];
    [NSLayoutConstraint activateConstraints:constraints];
    
    [constraints removeAllObjects];
    
    [constraints addObject:[_imageView.widthAnchor constraintGreaterThanOrEqualToAnchor:_scrollView.widthAnchor]];
    [constraints addObject:[_imageView.heightAnchor constraintGreaterThanOrEqualToAnchor:_scrollView.heightAnchor]];
    [constraints addObject:[_imageView.centerXAnchor constraintEqualToAnchor:_scrollView.centerXAnchor]];
    [constraints addObject:[_imageView.centerYAnchor constraintEqualToAnchor:_scrollView.centerYAnchor]];
    
    [_scrollView addConstraints:constraints];
    [NSLayoutConstraint activateConstraints:constraints];
}

#pragma mark - Getters

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return _imageView;
}

- (UIImage *)image
{
    return _imageView.image;
}

#pragma mark - Setters

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    
    [self checkImageSize:[_imageView.image size]];
}

- (void)setImage:(UIImage *)image
{
    _imageView.image = image;

    [self checkImageSize:[image size]];
}

@end
