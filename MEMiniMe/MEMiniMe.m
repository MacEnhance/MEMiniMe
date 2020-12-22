//
//  MEMiniMe.m
//  Created by Wolfgang Baird on 12/22/20.
//  Copyright © 2020 Wolfgang Baird. All rights reserved.
//

#import "ZKSwizzle.h"
#import <Cocoa/Cocoa.h>

static void hastaLaVistaBaby(NSWindow* w) { if (w.toolbarStyle != NSWindowToolbarStyleUnifiedCompact) [w setToolbarStyle:NSWindowToolbarStyleUnifiedCompact]; }

@interface Goodbye : NSObject @end
@interface miniTitle : NSWindow @end

@implementation Goodbye
+ (void)load {
    for (NSWindow *w in NSApp.windows) hastaLaVistaBaby(w);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{ for (NSWindow *w in NSApp.windows) hastaLaVistaBaby(w); });
    NSArray *globalBlacklist = [NSArray arrayWithContentsOfFile:[[NSBundle bundleForClass:self.class] pathForResource:@"blacklist" ofType:@"plist"]];
    if (![globalBlacklist containsObject:NSBundle.mainBundle.bundleIdentifier] && ![NSUserDefaults.standardUserDefaults boolForKey:@"MEMiniMeBlacklist"])
        ZKSwizzle(miniTitle, NSWindow);
}
@end

@implementation miniTitle
- (void)setToolbarStyle:(NSWindowToolbarStyle)toolbarStyle { ZKOrig(void, NSWindowToolbarStyleUnifiedCompact); }
- (void)display { hastaLaVistaBaby(self); ZKOrig(void); }
- (BOOL)makeFirstResponder:(NSResponder *)responder { hastaLaVistaBaby(self); return ZKOrig(BOOL, responder); }
@end
