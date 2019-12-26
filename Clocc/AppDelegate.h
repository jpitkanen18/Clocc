//
//  AppDelegate.h
//  Clocc
//
//  Created by Jese on 26.12.2019.
//  Copyright © 2019 jpitkanen18. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (readonly, strong) NSPersistentCloudKitContainer *persistentContainer;

- (void)saveContext;


@end

