//
//  DBSignupViewController.m
//  DBSignup
//
//  Created by Davide Bettio on 7/4/11.
//  Copyright 2011 03081340121. All rights reserved.
//

#import "DBSignupViewController.h"
#import "LSMToolen.h"
// Safe releases
#define RELEASE_SAFELY(__POINTER) { [__POINTER release]; __POINTER = nil; }

#define FIELDS_COUNT            7
#define BIRTHDAY_FIELD_TAG      5
#define GENDER_FIELD_TAG        6

@implementation DBSignupViewController

@synthesize nameTextField = nameTextField_;
@synthesize lastNameTextField = lastNameTextField_;
@synthesize emailTextField = emailTextField_;
@synthesize passwordTextField = passwordTextField_;
@synthesize birthdayTextField = birthdayTextField_;
@synthesize genderTextField = genderTextField_;
@synthesize phoneTextField = phoneTextField_;
@synthesize photoButton = photoButton_;
@synthesize termsTextView = termsTextView_;

@synthesize emailLabel = emailLabel_;
@synthesize passwordLabel = passwordLabel_;
@synthesize birthdayLabel = birthdayLabel_;
@synthesize genderLabel = genderLabel_;
@synthesize phoneLabel = phoneLabel_;

@synthesize keyboardToolbar = keyboardToolbar_;
@synthesize genderPickerView = genderPickerView_;
@synthesize birthdayDatePicker = birthdayDatePicker_;

@synthesize birthday = birthday_;
@synthesize gender = gender_;
@synthesize photo = photo_;
@synthesize infoDic = infoDic_;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"注册";
    }
    return self;
}

- (void)dealloc
{
    RELEASE_SAFELY(nameTextField_);
    RELEASE_SAFELY(lastNameTextField_);
    RELEASE_SAFELY(emailTextField_);
    RELEASE_SAFELY(passwordTextField_);
    RELEASE_SAFELY(birthdayTextField_);
    RELEASE_SAFELY(genderTextField_);
    RELEASE_SAFELY(phoneTextField_);
    RELEASE_SAFELY(photoButton_);
    RELEASE_SAFELY(termsTextView_);
    
    RELEASE_SAFELY(emailLabel_);
    RELEASE_SAFELY(passwordLabel_);
    RELEASE_SAFELY(birthdayLabel_);
    RELEASE_SAFELY(genderLabel_);
    RELEASE_SAFELY(phoneLabel_);
    
    RELEASE_SAFELY(keyboardToolbar_);
    RELEASE_SAFELY(birthdayDatePicker_);
    RELEASE_SAFELY(genderPickerView_);
    
    RELEASE_SAFELY(birthday_);
    RELEASE_SAFELY(gender_);
    RELEASE_SAFELY(photo_);
    
    [super dealloc];
}
- (id)init
{
    self = [super init];
    if (self)
    {
        
        UIButton *rightBtn = [[[UIButton alloc] init] autorelease];
        [rightBtn setBackgroundImage:[UIImage imageNamed:@"NavigationButtonBG.png"]
                            forState:UIControlStateNormal];
        [rightBtn setTitle:@"注册" forState:UIControlStateNormal];
        rightBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        rightBtn.frame = CGRectMake(0.0, 0.0, 53.0, 30.0);
        [rightBtn addTarget:self action:@selector(signup:) forControlEvents:UIControlEventTouchUpInside];
        
        self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithCustomView:rightBtn] autorelease];
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
 // Implement loadView to create a view hierarchy programmatically, without using a nib.
 - (void)loadView
 {
 }
 */


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Signup button
//    UIBarButtonItem *signupBarItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"注册", @"") style:UIBarButtonItemStyleBordered target:self action:@selector(signup:)];
//    self.navigationItem.rightBarButtonItem = signupBarItem;
//    [signupBarItem release];
    
#warning 增加view的高度，以免显示出window颜色，此方法未能实现，暂时改为修改window背景色
    //增加view的高度，以免显示出window颜色
//    CGRect rect = self.view.frame;
//    rect.size.height += 200.0;
//    self.view.frame = rect;
//    self.view.autoresizingMask = UIViewAutoresizingNone;
//    self.view.window.backgroundColor =self.view.backgroundColor;
    
    self.view.backgroundColor = [UIColor colorWithRGB:0xe1e0de];
    
    // Birthday date picker
    if (self.birthdayDatePicker == nil) {
        self.birthdayDatePicker = [[UIDatePicker alloc] init];
        [self.birthdayDatePicker addTarget:self action:@selector(birthdayDatePickerChanged:) forControlEvents:UIControlEventValueChanged];
        self.birthdayDatePicker.datePickerMode = UIDatePickerModeDate;
        NSDate *currentDate = [NSDate date];
        NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
        [dateComponents setYear:-18];
        NSDate *selectedDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:currentDate  options:0];
        [dateComponents release];
        [self.birthdayDatePicker setDate:selectedDate animated:NO];
        [self.birthdayDatePicker setMaximumDate:currentDate];
    }
    
    // Gender picker
    if (self.genderPickerView == nil) {
        self.genderPickerView = [[UIPickerView alloc] init];
        self.genderPickerView.delegate = self;
        self.genderPickerView.showsSelectionIndicator = YES;
    }
    
    // Keyboard toolbar
    if (self.keyboardToolbar == nil) {
        self.keyboardToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 38.0f)];
        self.keyboardToolbar.barStyle = UIBarStyleBlackTranslucent;
        
        UIBarButtonItem *previousBarItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"上一项", @"")
                                                                            style:UIBarButtonItemStyleBordered
                                                                           target:self
                                                                           action:@selector(previousField:)];
        
        UIBarButtonItem *nextBarItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"下一项", @"")
                                                                        style:UIBarButtonItemStyleBordered
                                                                       target:self
                                                                       action:@selector(nextField:)];
        
        UIBarButtonItem *spaceBarItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                                      target:nil
                                                                                      action:nil];
        
        UIBarButtonItem *doneBarItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"完成", @"")
                                                                        style:UIBarButtonItemStyleDone
                                                                       target:self
                                                                       action:@selector(resignKeyboard:)];
        
        [self.keyboardToolbar setItems:[NSArray arrayWithObjects:previousBarItem, nextBarItem, spaceBarItem, doneBarItem, nil]];
        
        self.nameTextField.inputAccessoryView = self.keyboardToolbar;
        self.lastNameTextField.inputAccessoryView = self.keyboardToolbar;
        self.emailTextField.inputAccessoryView = self.keyboardToolbar;
        self.passwordTextField.inputAccessoryView = self.keyboardToolbar;
        self.birthdayTextField.inputAccessoryView = self.keyboardToolbar;
        self.birthdayTextField.inputView = self.birthdayDatePicker;
        self.genderTextField.inputAccessoryView = self.keyboardToolbar;
        self.genderTextField.inputView = self.genderPickerView;
        self.phoneTextField.inputAccessoryView = self.keyboardToolbar;
        
        [previousBarItem release];
        [nextBarItem release];
        [spaceBarItem release];
        [doneBarItem release];
    }
    
    // Set localization
    self.nameTextField.placeholder = NSLocalizedString(@"姓名", @"");
    self.lastNameTextField.placeholder = NSLocalizedString(@"电话号码", @"");
    self.emailLabel.text = [NSLocalizedString(@"邮箱", @"") uppercaseString]; 
    self.passwordLabel.text = [NSLocalizedString(@"密码", @"") uppercaseString];
    self.birthdayLabel.text = [NSLocalizedString(@"生日", @"") uppercaseString]; 
    self.genderLabel.text = [NSLocalizedString(@"性别", @"") uppercaseString]; 
    self.phoneLabel.text = [NSLocalizedString(@"座机号码", @"") uppercaseString];
    self.phoneTextField.placeholder = NSLocalizedString(@"可选", @"");
    self.termsTextView.text = NSLocalizedString(@"介绍", @"");
    
    // Reset labels colors
    [self resetLabelsColors];
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


#pragma mark - IBActions

- (IBAction)choosePhoto:(id)sender
{
    UIActionSheet *choosePhotoActionSheet;
    
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        choosePhotoActionSheet = [[UIActionSheet alloc] initWithTitle:NSLocalizedString(@"图片选择", @"")
                                                             delegate:self 
                                                    cancelButtonTitle:NSLocalizedString(@"取消", @"") 
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:NSLocalizedString(@"马上拍照", @""), NSLocalizedString(@"从相册获取", @""), nil];
    } else {
        choosePhotoActionSheet = [[UIActionSheet alloc] initWithTitle:NSLocalizedString(@"图片选择", @"")
                                                             delegate:self 
                                                    cancelButtonTitle:NSLocalizedString(@"取消", @"") 
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:NSLocalizedString(@"从相册获取", @""), nil];
    }
    
    [choosePhotoActionSheet showInView:self.view];
    [choosePhotoActionSheet release];
}


#pragma mark - Others

- (void)signup:(id)sender
{
    [self resignKeyboard:nil];
    
    // Check fields
    NSString * notice = [self checkNoticeForInput:nil];
    if(notice)
    {
        [LSMToolen noticeWithText:notice];
        return;
    }
    // Make request
    
    BOOL saveResult = [self saveNewPurchase:nil];
    if (!saveResult)
    {
        [LSMToolen noticeWithText:@"您的手机号码已经注册"];
        return;
    }
    
    [LSMToolen noticeWithText:@"您已经注册成功"];
    [self.navigationController popViewControllerAnimated:YES];
    
}
-(NSString *)checkNoticeForInput:(id)sender
{
//    self.nameTextField.placeholder = NSLocalizedString(@"姓名", @"");
//    self.lastNameTextField.placeholder = NSLocalizedString(@"电话号码", @"");
//    self.emailLabel.text = [NSLocalizedString(@"邮箱", @"") uppercaseString];
//    self.passwordLabel.text = [NSLocalizedString(@"密码", @"") uppercaseString];
//    self.birthdayLabel.text = [NSLocalizedString(@"生日", @"") uppercaseString];
//    self.genderLabel.text = [NSLocalizedString(@"性别", @"") uppercaseString];
//    self.phoneLabel.text = [NSLocalizedString(@"座机号码", @"") uppercaseString];
//    self.phoneTextField.placeholder = NSLocalizedString(@"可选", @"");
//    self.termsTextView.text = NSLocalizedString(@"介绍", @"");
    if (self.nameTextField.text==nil)
    {
        return @"请输入姓名";
    }
    if (self.lastNameTextField.text==nil)
    {
        return @"请输入电话号码";
    }
    if (self.emailTextField.text==nil)
    {
        return @"请输入邮箱";
    }
    if (self.passwordTextField.text==nil)
    {
        return @"请输入密码";
    }
    if (self.birthdayTextField.text==nil)
    {
        return @"请输入生日";
    }
    if (self.genderTextField.text==nil)
    {
        return @"请输入性别";
    }
    return nil;
}
-(BOOL)saveNewPurchase:(id)sender
{
    NSString * keyValue = self.lastNameTextField.text;
    LocalDBDataManager * manager = [LocalDBDataManager defaultManager];
    NSArray * array = [manager selectObjects:[PurchaserDataObject class] where:nil];
    for (PurchaserDataObject  * obj in array )
    {
        if (keyValue&&[obj.personIdStr_ isEqualToString:keyValue])
        {
            return NO;
        }
    }
    
    PurchaserDataObject * obj = [[PurchaserDataObject alloc] init];
    obj.name_ = self.nameTextField.text;//姓名
    obj.personIdStr_ = self.lastNameTextField.text;//key
    obj.telNum_ = self.lastNameTextField.text;//电话
    
    obj.loginPWD = self.passwordTextField.text;//密码
    obj.locationDSC_ = self.emailTextField.text;//邮箱
    obj.anOtherTelNum_ = self.phoneTextField.text;//座机
    obj.detailIntroduce_ = self.genderTextField.text;//性别
    
    if (!self.photo)
    {
        obj.relativeDSC_ = @"2.jpeg";
    }else
    {
        //保存图片
        NSString * path =[self savePhotoToCachesWith:obj.personIdStr_];
        obj.relativeDSC_ = path;
    }
    
    BOOL result =  [manager insertObject:obj];
    
    return result;
}

-(NSString *)savePhotoToCachesWith:(NSString *)imgName
{
    
    NSString * path = nil;
    UIImage * image = self.photo;
    NSString * normalPath = [LSMToolen imgPathForApp:nil];
    
    NSMutableString * totalName = [NSMutableString string];
    NSData *data = nil;
    if (UIImagePNGRepresentation(image) == nil) {
        //此时为jpg
        data = UIImageJPEGRepresentation(image, 1);
        [totalName appendFormat:@"%@.jpg",imgName];
    } else {
        //此时为png
        data = UIImagePNGRepresentation(image);
        [totalName appendFormat:@"%@.png",imgName];
    }
    
    path = [normalPath stringByAppendingPathComponent:totalName];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        NSFileManager * fileManager = [NSFileManager defaultManager];
        [fileManager createFileAtPath:path contents:data attributes:nil];
    });
    
    NSLog(@"path %@",path);
    return path;
}


- (void)resignKeyboard:(id)sender
{
    id firstResponder = [self getFirstResponder];
    if ([firstResponder isKindOfClass:[UITextField class]]) {
        [firstResponder resignFirstResponder];
        [self animateView:1];
        [self resetLabelsColors];
    }
}

- (void)previousField:(id)sender
{
    id firstResponder = [self getFirstResponder];
    if ([firstResponder isKindOfClass:[UITextField class]]) {
        NSUInteger tag = [firstResponder tag];
        NSUInteger previousTag = tag == 1 ? 1 : tag - 1;
        [self checkBarButton:previousTag];
        [self animateView:previousTag];
        UITextField *previousField = (UITextField *)[self.view viewWithTag:previousTag];
        [previousField becomeFirstResponder];
        UILabel *nextLabel = (UILabel *)[self.view viewWithTag:previousTag + 10];
        if (nextLabel) {
            [self resetLabelsColors];
            [nextLabel setTextColor:[DBSignupViewController labelSelectedColor]];
        }
        [self checkSpecialFields:previousTag];
    }
}

- (void)nextField:(id)sender
{
    id firstResponder = [self getFirstResponder];
    if ([firstResponder isKindOfClass:[UITextField class]]) {
        NSUInteger tag = [firstResponder tag];
        NSUInteger nextTag = tag == FIELDS_COUNT ? FIELDS_COUNT : tag + 1;
        [self checkBarButton:nextTag];
        [self animateView:nextTag];
        UITextField *nextField = (UITextField *)[self.view viewWithTag:nextTag];
        [nextField becomeFirstResponder];
        UILabel *nextLabel = (UILabel *)[self.view viewWithTag:nextTag + 10];
        if (nextLabel) {
            [self resetLabelsColors];
            [nextLabel setTextColor:[DBSignupViewController labelSelectedColor]];
        }
        [self checkSpecialFields:nextTag];
    }
}

- (id)getFirstResponder
{
    NSUInteger index = 0;
    while (index <= FIELDS_COUNT) {
        UITextField *textField = (UITextField *)[self.view viewWithTag:index];
        if ([textField isFirstResponder]) {
            return textField;
        }
        index++;
    }
    
    return NO;
}

- (void)animateView:(NSUInteger)tag
{
    CGRect rect = self.view.frame;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    
    if (tag > 2) {
        rect.origin.y = -44.0f * (tag - 2);
    } else {
        rect.origin.y = 0;
    }
    self.view.frame = rect;
    [UIView commitAnimations];
}

- (void)checkBarButton:(NSUInteger)tag
{
    UIBarButtonItem *previousBarItem = (UIBarButtonItem *)[[self.keyboardToolbar items] objectAtIndex:0];
    UIBarButtonItem *nextBarItem = (UIBarButtonItem *)[[self.keyboardToolbar items] objectAtIndex:1];
    
    [previousBarItem setEnabled:tag == 1 ? NO : YES];
    [nextBarItem setEnabled:tag == FIELDS_COUNT ? NO : YES];
}

- (void)checkSpecialFields:(NSUInteger)tag
{
    if (tag == BIRTHDAY_FIELD_TAG && [self.birthdayTextField.text isEqualToString:@""]) {
        [self setBirthdayData];
    } else if (tag == GENDER_FIELD_TAG && [self.genderTextField.text isEqualToString:@""]) {
        [self setGenderData];
    }
}

- (void)setBirthdayData
{
    self.birthday = self.birthdayDatePicker.date;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterLongStyle];
    [dateFormatter setLocale:[NSLocale currentLocale]];
    self.birthdayTextField.text = [dateFormatter stringFromDate:self.birthday];
    [dateFormatter release];
}

- (void)setGenderData
{
    if ([self.genderPickerView selectedRowInComponent:0] == 0) {
        self.genderTextField.text = NSLocalizedString(@"男", @"");
        self.gender = @"M";
    } else {
        self.genderTextField.text = NSLocalizedString(@"女", @"");
        self.gender = @"F";
    }
}

- (void)birthdayDatePickerChanged:(id)sender
{
    [self setBirthdayData];
}

- (void)resetLabelsColors
{
    self.emailLabel.textColor = [DBSignupViewController labelNormalColor];
    self.passwordLabel.textColor = [DBSignupViewController labelNormalColor];
    self.birthdayLabel.textColor = [DBSignupViewController labelNormalColor];
    self.genderLabel.textColor = [DBSignupViewController labelNormalColor];
    self.phoneLabel.textColor = [DBSignupViewController labelNormalColor];
}

- (IBAction)clickedForhideKeyboard:(id)sender
{
    [self resignKeyboard:nil];
    [self animateView:0];
}

+ (UIColor *)labelNormalColor
{
    return [UIColor colorWithRed:0.016 green:0.216 blue:0.286 alpha:1.000];
}

+ (UIColor *)labelSelectedColor
{
    return [UIColor colorWithRed:0.114 green:0.600 blue:0.737 alpha:1.000];
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    NSUInteger tag = [textField tag];
    [self animateView:tag];
    [self checkBarButton:tag];
    [self checkSpecialFields:tag];
    UILabel *label = (UILabel *)[self.view viewWithTag:tag + 10];
    if (label) {
        [self resetLabelsColors];
        [label setTextColor:[DBSignupViewController labelSelectedColor]];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSUInteger tag = [textField tag];
    if (tag == BIRTHDAY_FIELD_TAG || tag == GENDER_FIELD_TAG) {
        return NO;
    }
    
    return YES;
}


#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return 2;
}


#pragma mark - UIPickerViewDelegate

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UIImage *image = row == 0 ? [UIImage imageNamed:@"male.png"] : [UIImage imageNamed:@"female.png"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];        
    imageView.frame = CGRectMake(0, 0, 32, 32);
    
    UILabel *genderLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 0, 100, 32)];
    genderLabel.text = [row == 0 ? NSLocalizedString(@"男", @"") : NSLocalizedString(@"女", @"") uppercaseString];
    genderLabel.textAlignment = UITextAlignmentLeft;
    genderLabel.backgroundColor = [UIColor clearColor];
    
    UIView *rowView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 32)] autorelease];
    [rowView insertSubview:imageView atIndex:0];
    [rowView insertSubview:genderLabel atIndex:1];
    
    [imageView release];
    [genderLabel release];
    
    return rowView;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    [self setGenderData];
}


#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
	NSUInteger sourceType = 0;
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        switch (buttonIndex) {
            case 0:
                sourceType = UIImagePickerControllerSourceTypeCamera;
                break;
            case 1:
                sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                break;
            case 2:
                return;
        }
    } else {
        if (buttonIndex == 1) {
            return;
        } else {
            sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        }
    }
    
	UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
	imagePickerController.delegate = self;
	imagePickerController.allowsEditing = YES;
    imagePickerController.sourceType = sourceType;
	[self presentModalViewController:imagePickerController animated:YES];
}


#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info 
{
	[picker dismissModalViewControllerAnimated:YES];
	self.photo = [info objectForKey:UIImagePickerControllerEditedImage];
	[self.photoButton setImage:self.photo forState:UIControlStateNormal];
    self.infoDic = [NSDictionary dictionaryWithDictionary:info];
    
    
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
	[self dismissModalViewControllerAnimated:YES];
}

@end
