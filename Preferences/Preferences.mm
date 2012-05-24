#import <UIKit/UIKit.h>

@interface PSListController : UIViewController {
    id _specifiers;
}
- (id)loadSpecifiersFromPlistName:(NSString *)name target:(id)target;
@end

@interface SparrowPlusListController : PSListController
@end

@implementation SparrowPlusListController

- (NSArray *)specifiers {
    if (!_specifiers) {
        _specifiers =  [[self loadSpecifiersFromPlistName:@"SparrowPrefs" target:self] mutableCopy];
    }

    return _specifiers;
}

- (void)followPressed:(id)specifier {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://freemanrepo.com/URL/1a"]];
}

- (void)contactPressed:(id)specifier {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"mailto:"]];
}

- (void)websitePressed:(id)specifier {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://freemanrepo.com/URL/1b"]];
}

- (void)laPressed:(id)specifier {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"cydia://package/com.freemanrepo.lockassistant"]];
}

- (void)sbPressed:(id)specifier {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"cydia://package/com.freemanrepo.siriboard"]];
}

- (void)msPressed:(id)specifier {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"cydia://package/com.freemanrepo.mediaspeak"]];
}

@end

