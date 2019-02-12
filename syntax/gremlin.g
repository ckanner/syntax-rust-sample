%lex

%%

\s+           /* skip whitespace */ return "";

\d+           return "NUMBER";

\"[^"]*\"    {  let n = yytext.len(); yytext = &yytext[1..(n -1)]; return "STRING"; }

"V"           return "V";

/lex

%left '.'

%{

/**
 * Recursive generic `Node` enum structure.
 */
#[derive(Debug)]
pub enum Step {

    V {
        id: &'static str,
    },

    HasLabel {
        label: &'static str,
    },

    Strategy {
        previous: Box<Step>,
        next: Box<Step>,
    },
}
/**
 * Final result type returned from `parse` method call.
 */
pub type TResult = Step;
/**
 * Hook executed on parse begin.
 */
fn on_parse_begin(_parser: &mut Parser, string: &'static str) {
    println!("Parsing: {:?}", string);
}

/**
 * Hook executed on parse end.
 */
fn on_parse_end(_parser: &mut Parser, result: &TResult) {
    println!("Parsed: {:?}", result);
}

%}

%%

Stmt
    : 'g' '.' VStep '.' Step {
        |$3: Step; $5: Step| -> Step;

        $$ = Step::Strategy {
            previous: Box::new($3),
            next: Box::new($5),
        };
    };

Step
    : Step '.' Step {
        |$1: Step; $3: Step| -> Step;

        $$ = Step::Strategy {
            previous: Box::new($1),
            next: Box::new($3),
        };
    }

    | VStep {
        $$ = $1;
    };

VStep
    : V '(' STRING ')' {
        |$3: &'static str| -> Step;

        $$ = Step::V {
            id: $3,
        };
    };



