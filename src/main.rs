extern crate syntax;

use syntax::Parser;

fn main() {

//    let s = "Hello, world!";
//    let ss = &s[7..12];
//    println!("{}", ss);

    let mut parser = Parser::new();

    let result = parser.parse(r#"g.V("idx1").V("idx2")"#);
//    match &result {
//        Node::Literal(i) => {
//            println!("Literal {:?}", i)
//        },
//        Node::Binary{
//            op: o, left: l, right: r
//        } => {
//            println!("Binary {:?} {:?} {:?}", o, l, r)
//        }
//    }
    println!("{:?}", result); // 6
}