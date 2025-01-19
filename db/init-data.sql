

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
                            'anderserik/rust-u-d-1.84-1.0', 
                            'rust-ubuntu-docker'
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
                            '   
x: 10
ref_x: 10
pointer_x: 0x7ffd046a6444',
                            '',
                            'No Notes',
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
