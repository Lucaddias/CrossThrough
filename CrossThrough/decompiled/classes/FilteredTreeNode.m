// FilteredTreeNode — CrossOver 26.3 arm64, Hopper pseudocode via REA

// 0x100024c64
// -[FilteredTreeNode init]
    var_10 = self;
    r0 = [[&var_10 super] init];
    return r0;


// 0x100024c98
// -[FilteredTreeNode dealloc]
    r31 = r31 - 0x120;
    var_30 = r24;
    decomp_var_28 = r23;
    var_20 = r22;
    decomp_var_18 = r21;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r19 = self;
    var_38 = **___stack_chk_guard;
    var_100 = q0;
    var_F0 = q0;
    r0 = self->_children;
    r0 = [r0 retain];
    r20 = r0;
    r0 = [r0 countByEnumeratingWithState:&var_100 objects:&decomp_var_b8 count:0x10];
    if (r0 != 0x0) {
            r21 = r0;
            r22 = *var_F0;
            do {
                    r23 = 0x0;
                    do {
                            if (*var_F0 != r22) {
                                    objc_enumerationMutation(r20);
                            }
                            [r19 abandonChild:*(var_F8 + r23 * 0x8)];
                            r23 = r23 + 0x1;
                    } while (r21 != r23);
                    r0 = [r20 countByEnumeratingWithState:&var_100 objects:&decomp_var_b8 count:0x10];
                    r21 = r0;
            } while (r0 != 0x0);
    }
    [r20 release];
    var_110 = r19;
    [[&var_110 super] dealloc];
    if (**___stack_chk_guard != var_38) {
            __stack_chk_fail();
    }
    return;


// 0x100024db0
// +[FilteredTreeNode keyPathsForValuesAffectingAncestors]
    r0 = [NSSet setWithObject:@"parent"];
    return r0;


// 0x100024dc4
// -[FilteredTreeNode ancestors]
    var_20 = r22;
    decomp_var_18 = r21;
    r31 = r31 + 0xffffffffffffffd0;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r19 = [[NSMutableArray array] retain];
    r0 = objc_loadWeakRetained((int64_t *)&self->_parent);
    if (r0 != 0x0) {
            r20 = r0;
            do {
                    [r19 addObject:r20];
                    r21 = [[r20 parent] retain];
                    [r20 release];
                    r20 = r21;
            } while (r21 != 0x0);
    }
    r0 = [r19 autorelease];
    return r0;


// 0x100024e4c
// +[FilteredTreeNode keyPathsForValuesAffectingLeaf]
    r0 = [NSSet setWithObject:@"children"];
    return r0;


// 0x100024e60
// -[FilteredTreeNode isLeaf]
    r0 = self;
    if (*(r0 + sign_extend_64(*(int32_t *)ivar_offset(_children))) == 0x0) {
            r0 = 0x1;
    }
    return r0;


// 0x100024e78
// -[FilteredTreeNode children]
    r0 = self->_children;
    r0 = objc_retainAutoreleaseReturnValue(r0);
    return r0;


// 0x100024e88
// -[FilteredTreeNode setChildren:]
    r31 = r31 - 0x1f0;
    var_50 = r28;
    decomp_var_48 = r27;
    var_40 = r26;
    decomp_var_38 = r25;
    var_30 = r24;
    decomp_var_28 = r23;
    var_20 = r22;
    decomp_var_18 = r21;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r20 = self;
    var_58 = **___stack_chk_guard;
    r0 = [arg2 retain];
    r19 = r0;
    r24 = sign_extend_64(*(int32_t *)ivar_offset(_children));
    if (*(r20 + r24) != r0) {
            r21 = [r20 isLeaf];
            var_1A0 = q0;
            var_190 = q0;
            r0 = *(r20 + r24);
            r0 = [r0 retain];
            r22 = r0;
            r0 = [r0 countByEnumeratingWithState:&var_1A0 objects:&decomp_var_d8 count:0x10];
            if (r0 != 0x0) {
                    r23 = r0;
                    r25 = *var_190;
                    do {
                            r26 = 0x0;
                            do {
                                    if (*var_190 != r25) {
                                            objc_enumerationMutation(r22);
                                    }
                                    [r20 abandonChild:*(var_198 + r26 * 0x8)];
                                    r26 = r26 + 0x1;
                            } while (r23 != r26);
                            r0 = [r22 countByEnumeratingWithState:&var_1A0 objects:&decomp_var_d8 count:0x10];
                            r23 = r0;
                    } while (r0 != 0x0);
            }
            [r22 release];
            r0 = [r19 mutableCopy];
            r8 = *(r20 + r24);
            *(r20 + r24) = r0;
            [r8 release];
            var_1E0 = q0;
            var_1D0 = q0;
            r0 = *(r20 + r24);
            r0 = [r0 retain];
            r22 = r0;
            r0 = [r0 countByEnumeratingWithState:&var_1E0 objects:&decomp_var_158 count:0x10];
            if (r0 != 0x0) {
                    r23 = r0;
                    r24 = *var_1D0;
                    do {
                            r25 = 0x0;
                            do {
                                    if (*var_1D0 != r24) {
                                            objc_enumerationMutation(r22);
                                    }
                                    [r20 adoptChild:*(var_1D8 + r25 * 0x8)];
                                    r25 = r25 + 0x1;
                            } while (r23 != r25);
                            r0 = [r22 countByEnumeratingWithState:&var_1E0 objects:&decomp_var_158 count:0x10];
                            r23 = r0;
                    } while (r0 != 0x0);
            }
            [r22 release];
            [r20 filterWithPredicate];
            if (r21 != [r20 isLeaf]) {
                    r0 = [r20 parent];
                    r0 = [r0 retain];
                    r21 = r0;
                    [r0 noteChildChangedPassesFilter:r20];
                    [r21 release];
            }
    }
    [r19 release];
    if (**___stack_chk_guard != var_58) {
            __stack_chk_fail();
    }
    return;


// 0x1000250a8
// -[FilteredTreeNode insertObject:inChildrenAtIndex:]
    var_30 = r24;
    decomp_var_28 = r23;
    r31 = r31 + 0xffffffffffffffc0;
    var_20 = r22;
    decomp_var_18 = r21;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r22 = arg3;
    r20 = self;
    r19 = [arg2 retain];
    r21 = [r20 isLeaf];
    r23 = sign_extend_64(*(int32_t *)ivar_offset(_children));
    r0 = *(r20 + r23);
    if (r0 == 0x0) {
            r0 = [[NSMutableArray alloc] init];
            r8 = *(r20 + r23);
            *(r20 + r23) = r0;
            [r8 release];
            r0 = *(r20 + r23);
    }
    [r0 insertObject:r19 atIndex:r22];
    [r20 adoptChild:r19];
    if ([r19 passesFilter] != 0x0) {
            [r20 addObjectToFilteredChildren:r19];
    }
    if (r21 != [r20 isLeaf]) {
            r0 = [r20 parent];
            r0 = [r0 retain];
            r21 = r0;
            [r0 noteChildChangedPassesFilter:r20];
            [r21 release];
    }
    [r19 release];
    return;


// 0x100025188
// -[FilteredTreeNode insertChildren:atIndexes:]
    r31 = r31 - 0x120;
    var_40 = r26;
    decomp_var_38 = r25;
    var_30 = r24;
    decomp_var_28 = r23;
    var_20 = r22;
    decomp_var_18 = r21;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r19 = self;
    var_48 = **___stack_chk_guard;
    r21 = [arg2 retain];
    r22 = [arg3 retain];
    r20 = [r19 isLeaf];
    r23 = sign_extend_64(*(int32_t *)ivar_offset(_children));
    r0 = *(r19 + r23);
    if (r0 == 0x0) {
            r0 = [[NSMutableArray alloc] init];
            r8 = *(r19 + r23);
            *(r19 + r23) = r0;
            [r8 release];
            r0 = *(r19 + r23);
    }
    [r0 insertObjects:r21 atIndexes:r22];
    var_110 = q0;
    var_100 = q0;
    r0 = [r21 retain];
    r21 = r0;
    r0 = [r0 countByEnumeratingWithState:&var_110 objects:&decomp_var_c8 count:0x10];
    if (r0 != 0x0) {
            r23 = r0;
            r24 = *var_100;
            do {
                    r25 = 0x0;
                    do {
                            if (*var_100 != r24) {
                                    objc_enumerationMutation(r21);
                            }
                            [r19 adoptChild:*(var_108 + r25 * 0x8)];
                            r25 = r25 + 0x1;
                    } while (r23 != r25);
                    r0 = [r21 countByEnumeratingWithState:&var_110 objects:&decomp_var_c8 count:0x10];
                    r23 = r0;
            } while (r0 != 0x0);
    }
    [r21 release];
    r23 = [[r21 indexesOfObjectsPassingTest:___block_literal_global] retain];
    [r22 release];
    if ([r23 count] != 0x0) {
            r22 = [[r21 objectsAtIndexes:r23] retain];
            r25 = [r19->_filteredChildren count];
            [r23 count];
            r24 = [[NSIndexSet indexSetWithIndexesInRange:r25] retain];
            [r19 insertFilteredChildren:r22 atIndexes:r24];
            [r24 release];
            [r22 release];
    }
    if (r20 != [r19 isLeaf]) {
            r0 = [r19 parent];
            r0 = [r0 retain];
            r20 = r0;
            [r0 noteChildChangedPassesFilter:r19];
            [r20 release];
    }
    [r23 release];
    [r21 release];
    if (**___stack_chk_guard != var_48) {
            __stack_chk_fail();
    }
    return;


// 0x1000253dc
// -[FilteredTreeNode removeObjectFromChildrenAtIndex:]
    var_20 = r22;
    decomp_var_18 = r21;
    r31 = r31 + 0xffffffffffffffd0;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r19 = self;
    r22 = sign_extend_64(*(int32_t *)ivar_offset(_children));
    r20 = [[*(self + r22) objectAtIndex:arg2] retain];
    [r19 abandonChild:r20];
    [*(r19 + r22) removeObjectAtIndex:arg2];
    r0 = r19->_filteredChildren;
    r0 = [r0 indexOfObjectIdenticalTo:r20];
    if (r0 != 0x7fffffffffffffff) {
            [r19 removeObjectFromFilteredChildrenAtIndex:r0];
    }
    [r20 release];
    return;


// 0x100025468
// -[FilteredTreeNode removeChildrenAtIndexes:]
    r31 = r31 - 0x70;
    var_30 = r24;
    decomp_var_28 = r23;
    var_20 = r22;
    decomp_var_18 = r21;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r19 = self;
    r21 = [arg2 retain];
    r0 = [NSMutableIndexSet indexSet];
    r0 = [r0 retain];
    r23 = sign_extend_64(*(int32_t *)ivar_offset(_children));
    r22 = *(r19 + r23);
    var_60 = *__NSConcreteStackBlock;
    r0 = [r0 retain];
    r20 = r0;
    var_38 = r0;
    [r22 enumerateObjectsAtIndexes:r21 options:0x0 usingBlock:&var_60];
    [*(r19 + r23) removeObjectsAtIndexes:r21];
    [r21 release];
    if ([r20 count] != 0x0) {
            [r19 removeFilteredChildrenAtIndexes:r20];
    }
    [var_38 release];
    [r20 release];
    return;


// 0x1000255dc
// -[FilteredTreeNode addObjectToChildren:]
    r20 = self->_children;
    r21 = [arg2 retain];
    [self insertObject:r21 inChildrenAtIndex:[r20 count]];
    [r21 release];
    return;


// 0x100025634
// -[FilteredTreeNode addChildrenFromArray:]
    var_20 = r22;
    decomp_var_18 = r21;
    r31 = r31 + 0xffffffffffffffd0;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r20 = self;
    r0 = [arg2 retain];
    r19 = r0;
    if ([r0 count] != 0x0) {
            r22 = [r20->_children count];
            [r19 count];
            r21 = [[NSIndexSet indexSetWithIndexesInRange:r22] retain];
            [r20 insertChildren:r19 atIndexes:r21];
            [r21 release];
    }
    [r19 release];
    return;


// 0x1000256c8
// +[FilteredTreeNode automaticallyNotifiesObserversOfFilterPredicate]
    return 0x0;


// 0x1000256d0
// -[FilteredTreeNode setFilterPredicate:]
    var_20 = r22;
    decomp_var_18 = r21;
    r31 = r31 + 0xffffffffffffffd0;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r20 = self;
    r0 = [arg2 retain];
    r19 = r0;
    r2 = r20->_filterPredicate;
    if (r2 != r0) {
            if (r19 != 0x0) {
                    if (r2 != 0x0) {
                            if (([r19 isEqual:r2] & 0x1) == 0x0) {
                                    r21 = [r20 passesFilter];
                                    [r20 willChangeValueForKey:@"filterPredicate"];
                                    [r20 setFilterPredicateInternal:r19];
                                    [r20 filterWithPredicate];
                                    [r20 didChangeValueForKey:@"filterPredicate"];
                                    if (r21 != [r20 passesFilter]) {
                                            r0 = [r20 parent];
                                            r0 = [r0 retain];
                                            r21 = r0;
                                            [r0 noteChildChangedPassesFilter:r20];
                                            [r21 release];
                                    }
                                    [r19 release];
                            }
                            else {
                                    [r19 release];
                            }
                    }
                    else {
                            r21 = [r20 passesFilter];
                            [r20 willChangeValueForKey:@"filterPredicate"];
                            [r20 setFilterPredicateInternal:r19];
                            [r20 filterWithPredicate];
                            [r20 didChangeValueForKey:@"filterPredicate"];
                            if (r21 != [r20 passesFilter]) {
                                    r0 = [r20 parent];
                                    r0 = [r0 retain];
                                    r21 = r0;
                                    [r0 noteChildChangedPassesFilter:r20];
                                    [r21 release];
                            }
                            [r19 release];
                    }
            }
            else {
                    r21 = [r20 passesFilter];
                    [r20 willChangeValueForKey:@"filterPredicate"];
                    [r20 setFilterPredicateInternal:r19];
                    [r20 filterWithPredicate];
                    [r20 didChangeValueForKey:@"filterPredicate"];
                    if (r21 != [r20 passesFilter]) {
                            r0 = [r20 parent];
                            r0 = [r0 retain];
                            r21 = r0;
                            [r0 noteChildChangedPassesFilter:r20];
                            [r21 release];
                    }
                    [r19 release];
            }
    }
    else {
            [r19 release];
    }
    return;


// 0x1000257a0
// -[FilteredTreeNode setFilterPredicateInternal:]
    r31 = r31 - 0x120;
    var_40 = r28;
    decomp_var_38 = r27;
    var_30 = r24;
    decomp_var_28 = r23;
    var_20 = r22;
    decomp_var_18 = r21;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r21 = arg2;
    r20 = self;
    var_48 = **___stack_chk_guard;
    r0 = [arg2 retain];
    r19 = r0;
    r22 = (int64_t *)&r20->_filterPredicate;
    r2 = *r22;
    if (r2 != r0) {
            if (r19 != 0x0) {
                    if (r2 != 0x0) {
                            if (([r19 isEqual:r2] & 0x1) == 0x0) {
                                    objc_storeStrong(r22, r21);
                                    var_110 = q0;
                                    var_100 = q0;
                                    r0 = r20->_children;
                                    r0 = [r0 retain];
                                    r20 = r0;
                                    r0 = [r0 countByEnumeratingWithState:&var_110 objects:&decomp_var_c8 count:0x10];
                                    if (r0 != 0x0) {
                                            r21 = r0;
                                            r23 = *var_100;
                                            do {
                                                    r24 = 0x0;
                                                    do {
                                                            if (*var_100 != r23) {
                                                                    objc_enumerationMutation(r20);
                                                            }
                                                            r22 = *(var_108 + r24 * 0x8);
                                                            if (([r22 filtersSeparately] & 0x1) == 0x0) {
                                                                    [r22 setFilterPredicateInternal:r19];
                                                            }
                                                            r24 = r24 + 0x1;
                                                    } while (r21 != r24);
                                                    r0 = [r20 countByEnumeratingWithState:&var_110 objects:&decomp_var_c8 count:0x10];
                                                    r21 = r0;
                                            } while (r0 != 0x0);
                                    }
                                    [r20 release];
                                    [r19 release];
                                    if (**___stack_chk_guard != var_48) {
                                            __stack_chk_fail();
                                    }
                            }
                            else {
                                    [r19 release];
                                    if (**___stack_chk_guard != var_48) {
                                            __stack_chk_fail();
                                    }
                            }
                    }
                    else {
                            objc_storeStrong(r22, r21);
                            var_110 = q0;
                            var_100 = q0;
                            r0 = r20->_children;
                            r0 = [r0 retain];
                            r20 = r0;
                            r0 = [r0 countByEnumeratingWithState:&var_110 objects:&decomp_var_c8 count:0x10];
                            if (r0 != 0x0) {
                                    r21 = r0;
                                    r23 = *var_100;
                                    do {
                                            r24 = 0x0;
                                            do {
                                                    if (*var_100 != r23) {
                                                            objc_enumerationMutation(r20);
                                                    }
                                                    r22 = *(var_108 + r24 * 0x8);
                                                    if (([r22 filtersSeparately] & 0x1) == 0x0) {
                                                            [r22 setFilterPredicateInternal:r19];
                                                    }
                                                    r24 = r24 + 0x1;
                                            } while (r21 != r24);
                                            r0 = [r20 countByEnumeratingWithState:&var_110 objects:&decomp_var_c8 count:0x10];
                                            r21 = r0;
                                    } while (r0 != 0x0);
                            }
                            [r20 release];
                            [r19 release];
                            if (**___stack_chk_guard != var_48) {
                                    __stack_chk_fail();
                            }
                    }
            }
            else {
                    objc_storeStrong(r22, r21);
                    var_110 = q0;
                    var_100 = q0;
                    r0 = r20->_children;
                    r0 = [r0 retain];
                    r20 = r0;
                    r0 = [r0 countByEnumeratingWithState:&var_110 objects:&decomp_var_c8 count:0x10];
                    if (r0 != 0x0) {
                            r21 = r0;
                            r23 = *var_100;
                            do {
                                    r24 = 0x0;
                                    do {
                                            if (*var_100 != r23) {
                                                    objc_enumerationMutation(r20);
                                            }
                                            r22 = *(var_108 + r24 * 0x8);
                                            if (([r22 filtersSeparately] & 0x1) == 0x0) {
                                                    [r22 setFilterPredicateInternal:r19];
                                            }
                                            r24 = r24 + 0x1;
                                    } while (r21 != r24);
                                    r0 = [r20 countByEnumeratingWithState:&var_110 objects:&decomp_var_c8 count:0x10];
                                    r21 = r0;
                            } while (r0 != 0x0);
                    }
                    [r20 release];
                    [r19 release];
                    if (**___stack_chk_guard != var_48) {
                            __stack_chk_fail();
                    }
            }
    }
    else {
            [r19 release];
            if (**___stack_chk_guard != var_48) {
                    __stack_chk_fail();
            }
    }
    return;


// 0x100025904
// -[FilteredTreeNode filteredChildren]
    r0 = self->_filteredChildren;
    r0 = objc_retainAutoreleaseReturnValue(r0);
    return r0;


// 0x100025914
// -[FilteredTreeNode setFilteredChildren:]
    var_20 = r22;
    decomp_var_18 = r21;
    r31 = r31 + 0xffffffffffffffd0;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r20 = self;
    r19 = [arg2 retain];
    r21 = sign_extend_64(*(int32_t *)ivar_offset(_filteredChildren));
    r0 = *(r20 + r21);
    if (r0 != r19) {
            if ([r0 count] != 0x0) {
                    r22 = 0x1;
            }
            [r19 count] == 0x0;
            r0 = [r19 mutableCopy];
            r8 = *(r20 + r21);
            *(r20 + r21) = r0;
            [r8 release];
            if (((r22 ^ 0x1) & 0x1) == 0x0) {
                    r0 = [r20 parent];
                    r0 = [r0 retain];
                    r21 = r0;
                    [r0 noteChildChangedPassesFilter:r20];
                    [r21 release];
            }
    }
    [r19 release];
    return;


// 0x1000259bc
// -[FilteredTreeNode insertObject:inFilteredChildrenAtIndex:]
    var_20 = r22;
    decomp_var_18 = r21;
    r31 = r31 + 0xffffffffffffffd0;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r21 = arg3;
    r20 = self;
    r19 = [arg2 retain];
    r22 = sign_extend_64(*(int32_t *)ivar_offset(_filteredChildren));
    r0 = *(r20 + r22);
    if (r0 == 0x0) {
            r0 = [[NSMutableArray alloc] init];
            r8 = *(r20 + r22);
            *(r20 + r22) = r0;
            [r8 release];
            r0 = *(r20 + r22);
    }
    [r0 insertObject:r19 atIndex:r21];
    if ([*(r20 + r22) count] == 0x1) {
            r0 = [r20 parent];
            r0 = [r0 retain];
            r21 = r0;
            [r0 noteChildChangedPassesFilter:r20];
            [r21 release];
    }
    [r19 release];
    return;


// 0x100025a64
// -[FilteredTreeNode insertFilteredChildren:atIndexes:]
    var_20 = r22;
    decomp_var_18 = r21;
    r31 = r31 + 0xffffffffffffffd0;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r20 = self;
    r19 = [arg2 retain];
    r21 = [arg3 retain];
    if ([r19 count] != 0x0) {
            r22 = sign_extend_64(*(int32_t *)ivar_offset(_filteredChildren));
            r0 = *(r20 + r22);
            if (r0 == 0x0) {
                    r0 = [[NSMutableArray alloc] init];
                    r8 = *(r20 + r22);
                    *(r20 + r22) = r0;
                    [r8 release];
                    r0 = *(r20 + r22);
            }
            [r0 insertObjects:r19 atIndexes:r21];
            if ([*(r20 + r22) count] == [r19 count]) {
                    r0 = [r20 parent];
                    r0 = [r0 retain];
                    r22 = r0;
                    [r0 noteChildChangedPassesFilter:r20];
                    [r22 release];
            }
    }
    [r21 release];
    [r19 release];
    return;


// 0x100025b38
// -[FilteredTreeNode addObjectToFilteredChildren:]
    r20 = self->_filteredChildren;
    r21 = [arg2 retain];
    [self insertObject:r21 inFilteredChildrenAtIndex:[r20 count]];
    [r21 release];
    return;


// 0x100025b90
// -[FilteredTreeNode removeObjectFromFilteredChildrenAtIndex:]
    var_10 = r20;
    decomp_var_8 = r19;
    r31 = r31 + 0xffffffffffffffe0;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r19 = self;
    r20 = sign_extend_64(*(int32_t *)ivar_offset(_filteredChildren));
    [*(self + r20) removeObjectAtIndex:arg2];
    r0 = *(r19 + r20);
    if (r0 != 0x0 && [r0 count] == 0x0) {
            r0 = [r19 parent];
            r0 = [r0 retain];
            r20 = r0;
            [r0 noteChildChangedPassesFilter:r19];
            [r20 release];
    }
    return;


// 0x100025bf8
// -[FilteredTreeNode removeFilteredChildrenAtIndexes:]
    var_20 = r22;
    decomp_var_18 = r21;
    r31 = r31 + 0xffffffffffffffd0;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r20 = self;
    r0 = [arg2 retain];
    r19 = r0;
    if ([r0 count] != 0x0) {
            r21 = sign_extend_64(*(int32_t *)ivar_offset(_filteredChildren));
            [*(r20 + r21) removeObjectsAtIndexes:r19];
            r0 = *(r20 + r21);
            if (r0 != 0x0) {
                    if ([r0 count] == 0x0) {
                            r0 = [r20 parent];
                            r0 = [r0 retain];
                            r21 = r0;
                            [r0 noteChildChangedPassesFilter:r20];
                            [r21 release];
                    }
            }
    }
    [r19 release];
    return;


// 0x100025c7c
// -[FilteredTreeNode passesFilter]
    var_30 = r24;
    decomp_var_28 = r23;
    r31 = r31 + 0xffffffffffffffc0;
    var_20 = r22;
    decomp_var_18 = r21;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r21 = self;
    r0 = [self filterPredicate];
    r0 = [r0 retain];
    r19 = r0;
    if (r0 != 0x0) {
            r0 = [r21 isLeaf];
            r22 = r0;
            if ((r0 & 0x1) != 0x0) {
                    if (([r21 isLeaf] & 0x1) == 0x0) {
                            [r19 release];
                            r0 = 0x0;
                    }
                    else {
                            r0 = [r21 filterPredicate];
                            r0 = [r0 retain];
                            r23 = r0;
                            r21 = [r0 evaluateWithObject:r21];
                            [r23 release];
                            if ((r22 & 0x1) == 0x0) {
                                    [r20 release];
                            }
                            [r19 release];
                            r0 = r21;
                    }
            }
            else {
                    r0 = [r21 filteredChildren];
                    r0 = [r0 retain];
                    r20 = r0;
                    if ([r0 count] != 0x0) {
                            [r20 release];
                            [r19 release];
                            r0 = 0x1;
                    }
                    else {
                            if ([r21 isLeaf] != 0x0) {
                                    r0 = [r21 filterPredicate];
                                    r0 = [r0 retain];
                                    r23 = r0;
                                    r21 = [r0 evaluateWithObject:r21];
                                    [r23 release];
                                    if ((r22 & 0x1) == 0x0) {
                                            [r20 release];
                                    }
                                    [r19 release];
                                    r0 = r21;
                            }
                            else {
                                    [r20 release];
                                    [r19 release];
                                    r0 = 0x0;
                            }
                    }
            }
    }
    else {
            [r19 release];
            r0 = 0x1;
    }
    return r0;


// 0x100025d60
// -[FilteredTreeNode noteChildChangedPassesFilter:]
    var_20 = r22;
    decomp_var_18 = r21;
    r31 = r31 + 0xffffffffffffffd0;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r20 = self;
    r19 = [arg2 retain];
    if (*(int8_t *)(r20 + sign_extend_64(*(int32_t *)ivar_offset(_insideFilterWithPredicate))) != 0x0) {
            [r19 release];
    }
    else {
            r0 = r20->_filteredChildren;
            if (r0 != 0x0) {
                    r21 = [r0 indexOfObjectIdenticalTo:r19];
                    r0 = [r19 passesFilter];
                    r8 = 0x7fffffffffffffff;
                    bool_6 = r21 == 0x7fffffffffffffff;
                    if (r21 == 0x7fffffffffffffff) {
                            r8 = 0x1;
                    }
                    if (!bool_6) {
                            if ((r0 & 0x1) == 0x0) {
                                    [r20 removeObjectFromFilteredChildrenAtIndex:r21];
                            }
                            else {
                                    if (r0 != 0x0) {
                                            if (r8 != 0x0) {
                                                    [r20 addObjectToFilteredChildren:r19];
                                            }
                                    }
                            }
                            [r19 release];
                    }
                    else {
                            if (r0 != 0x0) {
                                    if (r8 != 0x0) {
                                            [r20 addObjectToFilteredChildren:r19];
                                    }
                            }
                            [r19 release];
                    }
            }
            else {
                    r0 = [r19 passesFilter];
                    if (r0 != 0x0) {
                            if (0x1 != 0x0) {
                                    [r20 addObjectToFilteredChildren:r19];
                            }
                    }
                    [r19 release];
            }
    }
    return;


// 0x100025e10
// -[FilteredTreeNode adoptChild:]
    var_20 = r22;
    decomp_var_18 = r21;
    r31 = r31 + 0xffffffffffffffd0;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r19 = self;
    r0 = [arg2 retain];
    r20 = r0;
    if (([r0 filtersSeparately] & 0x1) == 0x0) {
            r21 = [[r19 filterPredicate] retain];
            [r20 setFilterPredicate:r21];
            [r21 release];
    }
    [r20 setParent:r19];
    [r20 release];
    return;


// 0x100025e80
// -[FilteredTreeNode abandonChild:]
    var_10 = r20;
    decomp_var_8 = r19;
    r31 = r31 + 0xffffffffffffffe0;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r0 = [arg2 retain];
    r19 = r0;
    [r0 setParent:0x0];
    if (([r19 filtersSeparately] & 0x1) == 0x0) {
            [r19 setFilterPredicate:0x0];
    }
    [r19 release];
    return;


// 0x100025ec8
// -[FilteredTreeNode filterWithPredicate]
    r31 = r31 - 0x160;
    var_50 = r28;
    decomp_var_48 = r27;
    var_40 = r26;
    decomp_var_38 = r25;
    var_30 = r24;
    decomp_var_28 = r23;
    var_20 = r22;
    decomp_var_18 = r21;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r19 = self;
    var_58 = **___stack_chk_guard;
    r25 = sign_extend_64(*(int32_t *)ivar_offset(_insideFilterWithPredicate));
    r26 = *(int8_t *)(self + r25);
    *(int8_t *)(self + r25) = 0x1;
    r20 = [[NSMutableSet set] retain];
    var_120 = q0;
    var_110 = q0;
    r0 = r19->_children;
    r0 = [r0 retain];
    r21 = r0;
    r0 = [r0 countByEnumeratingWithState:&var_120 objects:&decomp_var_d8 count:0x10];
    if (r0 != 0x0) {
            r22 = r0;
            r24 = *var_110;
            do {
                    r27 = 0x0;
                    do {
                            if (*var_110 != r24) {
                                    objc_enumerationMutation(r21);
                            }
                            r23 = *(var_118 + r27 * 0x8);
                            [r23 filterWithPredicate];
                            if ([r23 passesFilter] != 0x0) {
                                    [r20 addObject:r23];
                            }
                            r27 = r27 + 0x1;
                    } while (r22 != r27);
                    r0 = [r21 countByEnumeratingWithState:&var_120 objects:&decomp_var_d8 count:0x10];
                    r22 = r0;
            } while (r0 != 0x0);
    }
    [r21 release];
    r21 = [[NSMutableIndexSet indexSet] retain];
    r24 = sign_extend_64(*(int32_t *)ivar_offset(_filteredChildren));
    r22 = *(r19 + r24);
    var_150 = *__NSConcreteStackBlock;
    r0 = [r20 retain];
    r20 = r0;
    var_130 = r0;
    r0 = [r21 retain];
    r21 = r0;
    var_128 = r0;
    [r22 enumerateObjectsUsingBlock:&var_150];
    if ([r20 count] != 0x0) {
            r22 = [[r20 allObjects] retain];
            r24 = [*(r19 + r24) count];
            [r20 count];
            r23 = [[NSIndexSet indexSetWithIndexesInRange:r24] retain];
            [r19 insertFilteredChildren:r22 atIndexes:r23];
            [r23 release];
            [r22 release];
    }
    if ([r21 count] != 0x0) {
            [r19 removeFilteredChildrenAtIndexes:r21];
    }
    *(int8_t *)(r19 + r25) = r26;
    [var_128 release];
    [var_130 release];
    [r21 release];
    [r20 release];
    if (**___stack_chk_guard != var_58) {
            __stack_chk_fail();
    }
    return;


// 0x1000261ac
// -[FilteredTreeNode filterPredicate]
    r0 = self->_filterPredicate;
    return r0;


// 0x1000261bc
// -[FilteredTreeNode filtersSeparately]
    r0 = *(int8_t *)(int64_t *)&self->_filtersSeparately;
    return r0;


// 0x1000261cc
// -[FilteredTreeNode setFiltersSeparately:]
    *(int8_t *)(int64_t *)&self->_filtersSeparately = arg2;
    return;


// 0x1000261dc
// -[FilteredTreeNode parent]
    r0 = objc_loadWeakRetained((int64_t *)&self->_parent);
    r0 = [r0 autorelease];
    return r0;


// 0x1000261fc
// -[FilteredTreeNode setParent:]
    objc_storeWeak((int64_t *)&self->_parent, arg2);
    return;


// 0x100026210
// -[FilteredTreeNode .cxx_destruct]
    objc_destroyWeak((int64_t *)&self->_parent);
    objc_storeStrong((int64_t *)&self->_filterPredicate, 0x0);
    objc_storeStrong((int64_t *)&self->_filteredChildren, 0x0);
    objc_storeStrong((int64_t *)&self->_children, 0x0);
    return;


// === Block Invocations for FilteredTreeNode ===

// 0x1000253d4
// ___45-[FilteredTreeNode insertChildren:atIndexes:]_block_invoke
    r0 = [arg1 passesFilter];
    return r0;


// 0x100025554
// ___44-[FilteredTreeNode removeChildrenAtIndexes:]_block_invoke
    var_20 = r22;
    decomp_var_18 = r21;
    r31 = r31 + 0xffffffffffffffd0;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r19 = arg0;
    r20 = arg0[0x4];
    r21 = [arg1 retain];
    [r20 abandonChild:r21];
    r20 = [*(r19[0x4] + sign_extend_64(*(int32_t *)ivar_offset(_filteredChildren))) indexOfObjectIdenticalTo:r21];
    r0 = [r21 release];
    if (r20 != 0x7fffffffffffffff) {
            r0 = r19[0x5];
            r0 = [r0 addIndex:r20];
    }
    return r0;


// 0x100026148
// ___39-[FilteredTreeNode filterWithPredicate]_block_invoke
    var_20 = r22;
    decomp_var_18 = r21;
    r31 = r31 + 0xffffffffffffffd0;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r20 = arg2;
    r21 = arg0;
    r19 = [arg1 retain];
    if ([r21[0x4] containsObject:r19] != 0x0) {
            [r21[0x4] removeObject:r19];
    }
    else {
            [r21[0x5] addIndex:r20];
    }
    r0 = [r19 release];
    return r0;


