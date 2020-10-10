using {northwind} from './NorthWind';

/**
 * Annotations for Products Entity
 */
annotate northwind.Products with @(
    Common : {Label : '{i18n>Products}'},
    UI     : {
        SelectionFields               : [
        ToCategory_Id,
        ToCurrency_Id
        ],
        HeaderInfo                    : {
            TypeName       : '{i18n>Product}',
            TypeNamePlural : '{i18n>Products}'
        },
        LineItem                      : {$value : [
        {Value : ImageUrl},
        {Value : Name},
        {Value : Description},
        {Value : ToCategory_Id},
        {Value : ReleaseDate},
        {Value : DiscontinuedDate},
        {
            $Type  : 'UI.DataFieldForAnnotation',
            Target : '@UI.DataPoint#AverageRatingValue'
        },
        {Value : Price}
        ]},
        DataPoint #AverageRatingValue : {
            Value         : Rating,
            Title         : '{i18n>Rating}',
            TargetValue   : 5,
            Visualization : #Rating
        }
    }
) {
    ImageUrl         @(
        title : '{i18n>Image}',
        UI    : {IsImageURL : true}
    );
    Id               @title : '{i18n>Id}';
    Name             @title : '{i18n>Name}';
    Description      @title : '{i18n>Description}';
    ToCategory       @(
        title  : '{i18n>Category}',
        Common : {
            Text      : {
                $value                 : Category,
                ![@UI.TextArrangement] : #TextOnly
            },
            ValueList : {
                SearchSupported : true,
                CollectionPath  : 'VH_Categories',
                Parameters      : [
                {
                    $Type             : 'Common.ValueListParameterInOut',
                    LocalDataProperty : ToCategory_Id,
                    ValueListProperty : 'Code'
                },
                {
                    $Type             : 'Common.ValueListParameterInOut',
                    LocalDataProperty : Category,
                    ValueListProperty : 'Text'
                }
                ]
            }
        }
    );
    ReleaseDate      @title : '{i18n>ReleaseDate}';
    DiscontinuedDate @title : '{i18n>DiscontinuedDate}';
    Rating           @title : '{i18n>Rating}';
    Price            @(
        title    : '{i18n>Price}',
        Measures : {Unit : ToCurrency_Id}
    );
    ToCurrency       @(
        mandatory,
        title  : '{i18n>CurrencyKey}',
        Common : {
            ValueListWithFixedValues : false,
            ValueList                : {
                SearchSupported : true,
                CollectionPath  : 'VH_Currencies',
                Parameters      : [
                {
                    $Type             : 'Common.ValueListParameterInOut',
                    LocalDataProperty : ToCurrency_Id,
                    ValueListProperty : 'Code'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'Text'
                }
                ]
            }
        }
    );
};

/**
 * Annotations for VH_Categories Entity
 */
annotate northwind.VH_Categories with {
    Code @(
        title  : '{i18n>Code}',
        UI     : {Hidden : true},
        Common : {Text : {
            $value                 : Text,
            ![@UI.TextArrangement] : #TextOnly
        }}
    );
    Text @(
        title : '{i18n>Category}',
        UI    : {HiddenFilter : true}
    );
};

/**
 * Annotations for VH_Currencies Entity
 */
annotate northwind.VH_Currencies with {
    Code @(
        title : '{i18n>Currency}',
        UI    : {HiddenFilter : true}
    );
    Text @(
        title : '{i18n>Description}',
        UI    : {HiddenFilter : true}
    );
};
