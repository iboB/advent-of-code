use std::fs::File;
use std::io::{self, BufRead};

struct Toboggan {
    x: usize,
    y: usize,
    sum: usize,
}

impl Toboggan {
    fn new(x: usize, y: usize) -> Toboggan {
        Toboggan { x: x, y: y, sum: 0}
    }

    fn advance(&mut self, index: usize, line: &Vec<char>) {
        if index % self.y != 0 { return }
        let i = self.x * (index / self.y);
        if line[i % line.len()] == '#' {
            self.sum += 1;
        }
    }
}

fn main() {
    let file = match File::open("input.txt") {
        Err(why) => panic!("can't open input: {}", why),
        Ok(file) => file,
    };

    let mut ts = [
        Toboggan::new(1, 1),
        Toboggan::new(3, 1),
        Toboggan::new(5, 1),
        Toboggan::new(7, 1),
        Toboggan::new(1, 2),
    ];
    for (i, line) in io::BufReader::new(file).lines().enumerate() {
        let uline = &line.unwrap();
        let chars: Vec<char> = uline.chars().collect();
        for t in &mut ts {
            t.advance(i, &chars);
        }
    }
    for t in ts.iter() {
        println!("({};{}): {}", t.x, t.y, t.sum);
    }
    let p: usize = ts.iter().map(|t| t.sum).product();
    println!("{}", p);
}
