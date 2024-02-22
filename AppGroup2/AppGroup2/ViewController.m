//
//  ViewController.m
//  AppGroup2
//
//  Created by zd on 14/1/2024.
//

#import "ViewController.h"

#define GROUP1 @"group.jobs8.test1"
#define GROUPKEY @"groupkey"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)group_read:(UIButton *)sender {
    //获取App Group的共享目录
    NSURL *groupURL = [[NSFileManager defaultManager] containerURLForSecurityApplicationGroupIdentifier:GROUP1];
    NSURL *fileURL = [groupURL URLByAppendingPathComponent:@"appGroup.txt"];
    
    //读取文件
    NSString *str = [NSString stringWithContentsOfURL:fileURL encoding:NSUTF8StringEncoding error:nil];
    NSLog(@"%@", str);
}

- (IBAction)group_write:(UIButton *)sender {
    //获取App Group的共享目录
    NSURL *groupURL = [[NSFileManager defaultManager] containerURLForSecurityApplicationGroupIdentifier:GROUP1];
    NSURL *fileURL = [groupURL URLByAppendingPathComponent:@"appGroup.txt"];
    
    NSString *text = @"This is just a test string.";
    //写入文件
    [text writeToURL:fileURL atomically:YES encoding:NSUTF8StringEncoding error:nil];
}

- (IBAction)us_write:(UIButton *)sender {
    NSUserDefaults *ud = [[NSUserDefaults standardUserDefaults] initWithSuiteName:GROUP1];
    [ud setValue:@"This is a test string for UserDefaults onf app group" forKey:GROUPKEY];
}

- (IBAction)us_read:(UIButton *)sender {
    NSUserDefaults *ud = [[NSUserDefaults standardUserDefaults] initWithSuiteName:GROUP1];
    NSString *value = [ud valueForKey:@"groupkey"];
    NSLog(@"%@", value);
    
//    CFStringRef keyRef = CFSTR("groupkey");
//    CFStringRef valueRef = CFSTR("value1");
//    id userDefaultsValue = [[[NSUserDefaults alloc] initWithSuiteName:GROUP1] objectForKey:GROUPKEY];
//    NSLog(@"%@",userDefaultsValue);
//    id preferencesValue = CFBridgingRelease(CFPreferencesCopyAppValue(keyRef, valueRef));
//    NSLog(@"%@",preferencesValue);
}

@end
