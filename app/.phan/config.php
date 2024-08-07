<?php

use Phan\Issue;

return [

    "target_php_version" => phpversion('tidy'),

    'directory_list' => [
        'src',
        'tests',
        'vendor/blns/blns',
        'vendor/mattsparks/blns-php',
    ],

    "exclude_analysis_directory_list" => [
        'vendor/'
    ],

    'plugins' => [
        'AlwaysReturnPlugin',
        'DollarDollarPlugin',
        'DuplicateArrayKeyPlugin',
        'DuplicateExpressionPlugin',
        'EmptyStatementListPlugin',
        'InvokePHPNativeSyntaxCheckPlugin',
        'LoopVariableReusePlugin',
        'PregRegexCheckerPlugin',
        'PrintfCheckerPlugin',
        'SleepCheckerPlugin',
        'UnreachableCodePlugin',
        'UseReturnValuePlugin',
    ],

    'minimum_severity' => Issue::SEVERITY_LOW,
    'quick_mode' => false,
    'backward_compatibility_checks' => true,
    'analyze_signature_compatibility' => true,
    'ignore_undeclared_variables_in_global_scope' => false,
    'allow_missing_properties' => false,
    'null_casts_as_any_type' => false,  
    'null_casts_as_array' => false,
    'array_casts_as_null' => false,

    'suppress_issue_types' => [
        'PhanUndeclaredExtendedClass',
        'PhanUndeclaredStaticMethod'
    ]
];
