//
//  AppDelegate.h
//  LZDemo
//
//  Created by Jared on 2020/10/14.
//  Copyright © 2020 Jared. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (readonly, strong) NSPersistentContainer *persistentContainer;

@property (nonatomic, strong) UIWindow * window;

- (void)saveContext;


@end

