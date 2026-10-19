// AddDependenciesViewController — CrossOver 26.3 arm64, Hopper pseudocode via REA

// 0x1000360ec
// -[AddDependenciesViewController init]
    var_10 = self;
    r0 = [[&var_10 super] initWithNibName:@"AddDependenciesView" bundle:0x0];
    return r0;


// 0x10003612c
// -[AddDependenciesViewController dealloc]
    r0 = [self installConfiguration];
    r0 = [r0 retain];
    r20 = r0;
    [r0 removeDelegate:self];
    [r20 release];
    var_20 = self;
    [[&var_20 super] dealloc];
    return;


// 0x10003618c
// +[AddDependenciesViewController keyPathsForValuesAffectingInstallConfiguration]
    r0 = [NSSet setWithObject:@"representedObject"];
    return r0;


// 0x1000361a0
// -[AddDependenciesViewController installConfiguration]
    r0 = [self representedObject];
    return r0;


// 0x1000361a4
// -[AddDependenciesViewController loadView]
    r31 = r31 - 0x180;
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
    var_60 = **___stack_chk_guard;
    var_118 = self;
    [[&var_118 super] loadView];
    r0 = [r19 installConfiguration];
    r0 = [r0 retain];
    r20 = r0;
    [r0 addDelegate:r19];
    [r20 release];
    var_168 = [[NSMutableArray array] retain];
    var_160 = q0;
    var_150 = q0;
    r0 = [r19 installConfiguration];
    r0 = [r0 retain];
    r22 = r0;
    r0 = [r0 installTask];
    r0 = [r0 retain];
    r23 = r0;
    r21 = [[r0 SuggestedDependencyOverrides] retain];
    [r23 release];
    [r22 release];
    r0 = [r21 countByEnumeratingWithState:&var_160 objects:&decomp_var_e0 count:0x10];
    if (r0 != 0x0) {
            r23 = r0;
            r28 = *var_150;
            do {
                    r20 = 0x0;
                    do {
                            if (*var_150 != r28) {
                                    objc_enumerationMutation(r21);
                            }
                            r25 = *(var_158 + r20 * 0x8);
                            r0 = [r19 installConfiguration];
                            r0 = [r0 retain];
                            r26 = r0;
                            r24 = [[r0 profileForAppID:r25] retain];
                            [r26 release];
                            r0 = [r24 valueForKey:@"is_ranked"];
                            r0 = [r0 retain];
                            r26 = r0;
                            r27 = [r0 boolValue];
                            [r26 release];
                            if (r27 != 0x0) {
                                    r0 = [r19 installConfiguration];
                                    r0 = [r0 retain];
                                    r26 = r0;
                                    r27 = [[r0 nameForProfileWithAppID:r25] retain];
                                    [r26 release];
                                    var_100 = @"appID";
                                    var_F0 = r25;
                                    r0 = [NSDictionary dictionaryWithObjects:&var_F0 forKeys:&var_100 count:0x2];
                                    r25 = [r0 retain];
                                    [var_168 addObject:r25];
                                    [r25 release];
                                    [r27 release];
                            }
                            [r24 release];
                            r20 = r20 + 0x1;
                    } while (r23 != r20);
                    r0 = [r21 countByEnumeratingWithState:&var_160 objects:&decomp_var_e0 count:0x10];
                    r23 = r0;
            } while (r0 != 0x0);
    }
    [r21 release];
    [r19 setAddableDependencies:var_168];
    r0 = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:0x1 selector:@selector(localizedStandardCompare:)];
    r0 = [r0 retain];
    r21 = r0;
    var_108 = r0;
    r0 = [NSArray arrayWithObjects:&var_108 count:0x1];
    r22 = [r0 retain];
    r0 = [r19 arrayController];
    r0 = [r0 retain];
    r19 = r0;
    [r0 setSortDescriptors:r22];
    [r19 release];
    [r22 release];
    [r21 release];
    [var_168 release];
    if (**___stack_chk_guard != var_60) {
            __stack_chk_fail();
    }
    return;


// 0x1000364c4
// -[AddDependenciesViewController addDependencies:]
    r19 = [arg2 retain];
    r0 = [self arrayController];
    r0 = [r0 retain];
    r22 = r0;
    r0 = [r0 selectedObjects];
    r0 = [r0 retain];
    r23 = r0;
    r21 = [[r0 valueForKey:@"appID"] retain];
    [r23 release];
    [r22 release];
    r0 = [self installConfiguration];
    r0 = [r0 retain];
    r22 = r0;
    r23 = [[r0 installTask] retain];
    r24 = [[InstallConfiguration overrideInclude] retain];
    [r23 addDependencyOverrides:r21 ofType:r24];
    [r24 release];
    [r23 release];
    [r22 release];
    r0 = [self view];
    r0 = [r0 retain];
    r20 = r0;
    [r0 tryToPerform:@selector(performClose:) with:r19];
    [r19 release];
    [r20 release];
    [r21 release];
    return;


// 0x1000365e4
// -[AddDependenciesViewController searchField]
    r0 = objc_loadWeakRetained((int64_t *)&self->_searchField);
    r0 = [r0 autorelease];
    return r0;


// 0x100036604
// -[AddDependenciesViewController setSearchField:]
    objc_storeWeak((int64_t *)&self->_searchField, arg2);
    return;


// 0x100036618
// -[AddDependenciesViewController arrayController]
    r0 = objc_loadWeakRetained((int64_t *)&self->_arrayController);
    r0 = [r0 autorelease];
    return r0;


// 0x100036638
// -[AddDependenciesViewController setArrayController:]
    objc_storeWeak((int64_t *)&self->_arrayController, arg2);
    return;


// 0x10003664c
// -[AddDependenciesViewController addableDependencies]
    r0 = self->_addableDependencies;
    return r0;


// 0x10003665c
// -[AddDependenciesViewController setAddableDependencies:]
    objc_setProperty_nonatomic_copy();
    return;


// 0x100036668
// -[AddDependenciesViewController .cxx_destruct]
    objc_storeStrong((int64_t *)&self->_addableDependencies, 0x0);
    objc_destroyWeak((int64_t *)&self->_arrayController);
    objc_destroyWeak((int64_t *)&self->_searchField);
    return;


