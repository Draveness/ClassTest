//
//  main.m
//  ClassTest
//
//  Created by draveness on 26/05/2017.
//  Copyright © 2017 draveness. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import "Foo.h"

Class getKlass(id object) {
    uintptr_t *isa = (uintptr_t *)object;
    return (Class)((*isa) & 0x00007ffffffffff8);
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        Foo *foo = [[Foo alloc] init];
        NSLog(@"Object %@: %p", foo, foo);
        Class kls = getKlass(foo);
        NSLog(@"Class %@: %p", kls, kls);
        Class metaKlass = getKlass(kls);
        NSLog(@"MetaClass %@: %p", metaKlass, metaKlass);
        Class metaKlassKlass = getKlass(metaKlass);
        NSLog(@"MetaClassClass %@: %p", metaKlassKlass, metaKlassKlass);
        Class metaKlassKlassKlass = getKlass(metaKlassKlass);
        NSLog(@"MetaClassClassClass %@: %p", metaKlassKlassKlass, metaKlassKlassKlass);

        NSLog(@"NSObject %@: %p", [NSObject class], [NSObject class]);
        NSLog(@"NSObjectMetaClass %@: %p", getKlass([NSObject class]), getKlass([NSObject class]));
        NSLog(@"NSObjectMetaClassClass %@: %p", getKlass(getKlass([NSObject class])), getKlass(getKlass([NSObject class])));
    }
    return 0;
}
