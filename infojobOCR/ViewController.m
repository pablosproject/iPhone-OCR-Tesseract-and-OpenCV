//
//  ViewController.m
//  infojobOCR
//
//  Created by Paolo Tagliani on 08/06/12.
//  Copyright (c) 2012 26775. All rights reserved.
//
#import "ViewController.h"
#import "ImageProcessingImplementation.h"
#import "UIImage+operation.h"


@interface ViewController ()

@end

@implementation ViewController


@synthesize takenImage;
@synthesize process;
@synthesize resultView;
@synthesize imageProcessor;
@synthesize read;
@synthesize processedImage;
@synthesize rotateButton;
@synthesize Histogrambutton;
@synthesize FilterButton;
@synthesize BinarizeButton;
@synthesize originalButton;

- (void)viewDidLoad
{
    [super viewDidLoad];
    imageProcessor= [[ImageProcessingImplementation alloc]  init];    
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setResultView:nil];
    [self setProcess:nil];
    [self setRead:nil];
    [self setRotateButton:nil];
    [self setRotateButton:nil];
    [self setHistogrambutton:nil];
    [self setFilterButton:nil];
    [self setBinarizeButton:nil];
    [self setOriginalButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    
    if(interfaceOrientation == UIInterfaceOrientationPortrait) return YES;
    else return NO;
}

- (IBAction)Pre:(id)sender {
    
    NSLog(@"Dimension taken image: %f x %f",takenImage.size.width, takenImage.size.height);
    self.processedImage=[imageProcessor processImage:[self takenImage]];
    self.resultView.image=[self processedImage];
    NSLog(@"Dimension processed image: %f x %f",takenImage.size.width, takenImage.size.height);

    
}

- (IBAction)OCR:(id)sender {
    
    NSString *readed=[imageProcessor OCRImage:[self processedImage]];
    [[[UIAlertView alloc] initWithTitle:@""
                                message:[NSString stringWithFormat:@"Recognized:\n%@", readed]
                               delegate:nil
                      cancelButtonTitle:nil
                      otherButtonTitles:@"OK", nil] show];
}

- (IBAction)PreRotation:(id)sender {
    
    self.processedImage=[imageProcessor processRotation:[self processedImage]];
    self.resultView.image=[self processedImage];
}

- (IBAction)PreHistogram:(id)sender {
    
    self.processedImage=[imageProcessor processHistogram:[self processedImage]];
    self.resultView.image=[self processedImage];
}

- (IBAction)PreFilter:(id)sender {
    
    self.processedImage=[imageProcessor processFilter:[self processedImage]];
    self.resultView.image=[self processedImage];
}

- (IBAction)PreBinarize:(id)sender {
    
    self.processedImage=[imageProcessor processBinarize:[self processedImage]];
    self.resultView.image=[self processedImage];
}

- (IBAction)returnOriginal:(id)sender {
    
    self.processedImage=[self takenImage ];
    self.resultView.image= [self takenImage];
}
                       
                       
- (IBAction)TakePhoto:(id)sender {
    mediaPicker = [[UIImagePickerController alloc] init];
    mediaPicker.delegate=self;
    mediaPicker.allowsEditing = YES;
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:
                                      @"Take a photo or choose existing, and use the control to center the announce"
                                                                 delegate: self                                                        cancelButtonTitle:@"Cancel"
                                                   destructiveButtonTitle:nil
                                                        otherButtonTitles:@"Take photo", @"Choose Existing", nil];
        [actionSheet showInView:self.view];
    } else {
        mediaPicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;     
        [self presentModalViewController:mediaPicker animated:YES];
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if(buttonIndex != actionSheet.cancelButtonIndex)
    {
        if (buttonIndex == 0) {
            mediaPicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        } else if (buttonIndex == 1) {
            mediaPicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        }
        
        [self presentModalViewController:mediaPicker animated:YES];
    }
    
    else [self dismissModalViewControllerAnimated:YES]; 
    
    
}

- (UIView*)CreateOverlay{
    
    UIView *overlay= [[UIView alloc] 
                      initWithFrame:CGRectMake
                      (0, 0, self.view.frame.size.width, self.view.frame.size.height*0.10)];//width equal and height 15%
    overlay.backgroundColor=[UIColor blackColor];
    overlay.alpha=0.5;
    
    return overlay;
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    [picker dismissModalViewControllerAnimated:YES];
    
    //I take the coordinate of the cropping
    CGRect croppedRect=[[info objectForKey:UIImagePickerControllerCropRect] CGRectValue];

    UIImage *original=[info objectForKey:UIImagePickerControllerOriginalImage];
   

    UIImage *rotatedCorrectly;
    
    if (original.imageOrientation!=UIImageOrientationUp)
    rotatedCorrectly=[original rotate:original.imageOrientation];
    else rotatedCorrectly=original;
    

    CGImageRef ref= CGImageCreateWithImageInRect(rotatedCorrectly.CGImage, croppedRect);
    self.takenImage= [UIImage imageWithCGImage:ref];
    self.resultView.image=[self takenImage];
     self.processedImage=[self takenImage ];
    process.hidden=NO;
    BinarizeButton.hidden=NO;
    Histogrambutton.hidden=NO;
    FilterButton.hidden=NO;
    rotateButton.hidden=NO;
        self.read.hidden=NO;    
    originalButton.hidden=NO;
    
}

@end
