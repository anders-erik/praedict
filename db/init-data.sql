

INSERT INTO source (    uuid, 
                        type, 
                        url, 
                        author, 
                        read_date) VALUES

                    (   'ab947b3ad3', 
                        'blog', 
                        'What''s the difference between references and pointers in Rust_ _ nicole@web.html', 
                        'Nicole Tietz-Sokolskaya', 
                        '2025-01-17');


INSERT INTO environment (   uuid, 
                            image_name, 
                            type) VALUES

                        (   '43933abdee', 
                            'praedict/rust-bookworm-1.84_0', 
                            'rust_1.84-bookworm-docker-#0'
                        );


INSERT INTO code_snippet (  uuid, 
                            title, 
                            content, 
                            run_command, 
                            std_out, 
                            std_err, 
                            note, 
                            quality_rank,

                            environment_uuid, 
                            source_uuid
                        ) VALUES

                        (   'ab3956104e',
                            'Printing variables',
                            '
fn main() {
    let x: u32 = 10;
    let ref_x: &u32 = &x;
    let pointer_x: *const u32 = &x;
    println!("x: {x}");
    println!("ref_x: {}", ref_x);
    println!("pointer_x: {:?}", pointer_x);
}', 
                            'rustc ./main.rs',
'x: 10
ref_x: 10
pointer_x: 0x7ffd048e6604
',
                            '',
                            'No Notes',
                            3,
                            '43933abdee',
                            'ab947b3ad3');


INSERT INTO code_snippet (  uuid, 
                            title, 
                            content, 
                            run_command, 
                            std_out, 
                            std_err, 
                            note, 
                            quality_rank,

                            environment_uuid, 
                            source_uuid
                        ) VALUES

                        (   'ab3956104e',
                            'Printing variables',
                            '
fn main() {
    let x: u32 = 10;
    let ref_x: &u32 = &x;
    let pointer_x: *const u32 = &x;

    println!("x: {x}");
    println!("ref_x: {}", ref_x);
    println!("pointer_x: {:?}", *pointer_x);
}', 
                            'rustc ./main.rs',
                            '',
                            'error[E0133]: dereference of raw pointer is unsafe and requires unsafe function or block
 --> ./snippet/snippet.rs:8:33
  |
8 |     println!("pointer_x: {:?}", *pointer_x);
  |                                 ^^^^^^^^^^ dereference of raw pointer
  |
  = note: raw pointers may be null, dangling or unaligned; they can violate aliasing rules and cause data races: all of these are undefined behavior

error: aborting due to 1 previous error

For more information about this error, try `rustc --explain E0133`.
',
                            'Need unsafe to compile.',
                            3,
                            '43933abdee',
                            'ab947b3ad3');


INSERT INTO code_snippet (  uuid, 
                            title, 
                            content, 
                            run_command, 
                            std_out, 
                            std_err, 
                            note, 
                            quality_rank,

                            environment_uuid, 
                            source_uuid
                        ) VALUES

                        (   'ab3956104e',
                            'Printing variables',
                            '
fn main() {
    let x: u32 = 10;
    let ref_x: &u32 = &x;
    let pointer_x: *const u32 = &x;

    println!("x: {x}");
    println!("ref_x: {}", ref_x);
    println!("*pointer_x: {}", unsafe { *pointer_x } );
}', 
                            'rustc ./main.rs',
                            'x: 10
ref_x: 10
*pointer_x: 10
',
                            '',
                            'Compiles and run ok with unsafe block.',
                            3,
                            '43933abdee',
                            'ab947b3ad3');


-- Insert sample data
-- INSERT INTO code_snippet (title, content) VALUES 
--     ('FizzBuzz', 'for (let i = 1; i <= 100; i++) { console.log(i % 3 === 0 ? (i % 5 === 0 ? "FizzBuzz" : "Fizz") : i % 5 === 0 ? "Buzz" : i); }'),
--     ('Factorial', 'function factorial(n) { return n === 0 ? 1 : n * factorial(n - 1); }');

-- -- INSERT INTO guess (snippet_id, guess_text, is_correct) VALUES 
--     (1, 'FizzBuzz implementation', 1),
--     (2, 'Recursive factorial function', 1);
