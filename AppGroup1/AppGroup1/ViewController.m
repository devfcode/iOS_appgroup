//
//  ViewController.m
//  AppGroup1
//
//  Created by zd on 14/1/2024.
//

#import "ViewController.h"

#define GROUP1 @"group.jobs8.test1"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *show;

@property(nonatomic,strong)NSMutableDictionary *tipDic;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"bundlePath:%@",[[NSBundle mainBundle] bundlePath]);
    NSLog(@"HomeDirectory:%@",NSHomeDirectory());
}

- (IBAction)gropu_read:(UIButton *)sender {
    self.tipDic = [[NSMutableDictionary alloc] init];
    // 获取App Group的共享目录
    NSURL *groupURL = [[NSFileManager defaultManager] containerURLForSecurityApplicationGroupIdentifier:GROUP1];
    // 创建一个文件路径
    NSURL *fileURL = [groupURL URLByAppendingPathComponent:@"appGroup.txt"];
    [self.tipDic setValue:fileURL.path forKey:@"fileURL"];
    NSLog(@"%d fileURL:%@",__LINE__,fileURL.path);
    //读取文件
    NSString *str = [NSString stringWithContentsOfURL:fileURL encoding:NSUTF8StringEncoding error:nil];
    NSLog(@"%@", str);
    if (str) {
        [self.tipDic setValue:str forKey:@"write"];
    }
    [self showLog:self.tipDic];
}

- (IBAction)group_write:(UIButton *)sender {
    self.tipDic = [[NSMutableDictionary alloc] init];
    //获取App Group的共享目录
    NSURL *groupURL = [[NSFileManager defaultManager] containerURLForSecurityApplicationGroupIdentifier:GROUP1];
    NSURL *fileURL = [groupURL URLByAppendingPathComponent:@"appGroup.txt"];
    [self.tipDic setValue:fileURL.path forKey:@"fileURL"];
    NSString *text = @"This is just a test string.";
    //写入文件
    [text writeToURL:fileURL atomically:YES encoding:NSUTF8StringEncoding error:nil];
    if (text) {
        [self.tipDic setValue:text forKey:@"read"];
    }
    [self showLog:self.tipDic];
}

- (IBAction)ud_write:(UIButton *)sender {
    self.tipDic = [[NSMutableDictionary alloc] init];
    NSUserDefaults *ud = [[NSUserDefaults standardUserDefaults] initWithSuiteName:GROUP1];
    [ud setValue:@"This is a test string for UserDefaults of app group" forKey:@"groupkey"];
    [self.tipDic setValue:@"success" forKey:@"write"];
    [self showLog:self.tipDic];
}

- (IBAction)us_read:(UIButton *)sender {
    self.tipDic = [[NSMutableDictionary alloc] init];
    NSUserDefaults *ud = [[NSUserDefaults standardUserDefaults] initWithSuiteName:GROUP1];
    NSString *value = [ud valueForKey:@"groupkey"];
    NSLog(@"%@", value);
    if (value) {
        [self.tipDic setValue:value forKey:@"read"];
    }
    [self showLog:self.tipDic];
}

-(void)showTip:(NSString * _Nonnull)tip {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.show setText:tip];
        [self.show layoutSubviews];
        NSLog(@"%@",tip);
    });
}

-(void)showLog:(NSDictionary * _Nonnull)tipDict {
    NSError *err;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:tipDict options:NSJSONWritingPrettyPrinted error:&err];
    
    if (err) {
        [self showTip:[err localizedFailureReason]];
    }else{
        NSString *logStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        [self showTip:logStr];
    }
}

@end
