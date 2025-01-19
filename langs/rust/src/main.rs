
pub mod praedict;

fn main() {


    let mut praedict_obj = praedict::Praedict::new();
    praedict_obj.compile();
    praedict_obj.run();
    praedict_obj.print();

    praedict_obj.cleanup();

    // praedict::Praedict::echo();
}