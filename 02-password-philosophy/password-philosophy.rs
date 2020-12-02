use std::fs::File;
use std::io::{self, BufRead};
use regex::Regex;

// valid according to a
fn va(min: usize, max: usize, chr: char, pwd: &str) -> bool {
    return (min..=max).contains(&pwd.matches(chr).count());
}

fn vb(p0: usize, p1: usize, chr: char, pwd: &str) -> bool {
    let chars: Vec<char> = pwd.chars().collect();
    return (chars[p0-1] == chr) as i32 + (chars[p1-1] == chr) as i32 == 1;
}

fn main() {
    let file = match File::open("input.txt") {
        Err(why) => panic!("can't open input: {}", why),
        Ok(file) => file,
    };

    let re = Regex::new(r"^(\d+)-(\d+) ([a-z]): ([a-z]+)").unwrap();
    let sum = io::BufReader::new(file).lines().fold((0, 0), |s, line| {
        let uline = &line.unwrap();
        let cap = re.captures(uline).unwrap();
        let a = cap[1].parse::<usize>().unwrap();
        let b = cap[2].parse::<usize>().unwrap();
        let chr = cap[3].chars().next().unwrap();
        let pwd = &cap[4];
        (s.0 + va(a, b, chr, pwd) as i32, s.1 + vb(a, b, chr, pwd) as i32)
    });
    println!("a: {}", sum.0);
    println!("b: {}", sum.1);
}
